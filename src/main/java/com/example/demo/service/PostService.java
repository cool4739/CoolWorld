package com.example.demo.service;

import com.example.demo.dao.*;
import com.example.demo.dto.*;
import com.example.demo.etc.SessionManager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
@Transactional
public class PostService {

    private final UserRepository userRepository;
    private final PostRepository postRepository;
    private final CommentRepository commentRepository;
    private final LikesRepository likesRepository;
    private final SessionManager sessionManager;

    private Map<String, LocalDateTime> viewTimestamps = new ConcurrentHashMap<>();

    public Long register(PostRegisterRequestDto requestDto, HttpServletRequest request, HttpServletResponse response) {

        // 현재 가장 큰 postid 찾기
        Long maxPostId = postRepository.findMaxPostId();
        // 새로운 postid = 기존 최대값 + 1
        Long PostId = maxPostId + 1;

        Object user = sessionManager.getSession(request, response);
        if (user == null) {
            System.out.println("post fail");
            throw new IllegalStateException("세션이 존재하지 않습니다."); // 예외로 명확하게 처리
        }
        SessionManager.SessionData sessionData = (SessionManager.SessionData) user;
        User loginUser = (User) sessionData.getValue();
        System.out.println(sessionData.toString());
        System.out.println("User ID: " + loginUser.getUserid());
        Post post = requestDto.toEntity(PostId, loginUser.getUserid(), loginUser.getNickname());
        Post savedPost = postRepository.save(post);
        return savedPost.getPostid(); // 실제 저장된 ID 반환
    }

    /*@Transactional(readOnly = true) // 기능을 조회로 제한, 조회 속도 개선
    public PostReadRequestDto read(Long postid) { // 읽기
        Post post = postRepository.findByPostId(postid)
                .orElseThrow(() -> new IllegalArgumentException("없음"));
        return new PostReadRequestDto(post);
    }*/

    @Transactional(readOnly = true) // 읽는 기능에는 이걸 넣어서 성능 향상을 기대한다.
    public List<PostReadRequestDto> readList(int page, int size, HttpServletRequest request, HttpServletResponse response) {
        Object user = sessionManager.getSession(request, response);
        if (user == null) {
            System.out.println("post fail");
            throw new IllegalStateException("세션이 존재하지 않습니다."); // 예외로 명확하게 처리
        }
        SessionManager.SessionData sessionData = (SessionManager.SessionData) user;
        User loginUser = (User) sessionData.getValue();
        System.out.println(sessionData.toString());
        System.out.println("User ID: " + loginUser.getUserid());

        Pageable pageable = PageRequest.of(page, size, Sort.by("postid").descending());

        List<PostReadRequestDto> postList = postRepository.findAll(pageable).getContent().stream()
                .map(post -> {
                    //like 기록 확인
                    LikesKey likesKey = new LikesKey();
                    likesKey.setPostid(post.getPostid());
                    likesKey.setUserid(loginUser.getUserid());
                    Optional<Likes> existingLike = likesRepository.findByPostIdAndUserId(likesKey);
                    boolean liked = existingLike.map(Likes::isLiked).orElse(false);
                    Long likesCount = likesRepository.countByPostId(post.getPostid());
                    Long comments = commentRepository.countByPostId(post.getPostid());

                    return new PostReadRequestDto(post, comments, likesCount, liked); // liked는 임시로 true
                })
                .collect(Collectors.toList());

        return postList;
    }

    @Transactional(readOnly = true)
    public List<PostReadRequestDto> myPostListReadList(String userid, int page, int size, HttpServletRequest request, HttpServletResponse response) {
        Object user = sessionManager.getSession(request, response);
        if (user == null) {
            System.out.println("post fail");
            throw new IllegalStateException("세션이 존재하지 않습니다."); // 예외로 명확하게 처리
        }
        SessionManager.SessionData sessionData = (SessionManager.SessionData) user;
        User loginUser = (User) sessionData.getValue();
        System.out.println(sessionData.toString());
        System.out.println("User ID: " + loginUser.getUserid());

        Pageable pageable = PageRequest.of(page, size, Sort.by("postid").descending());
        Page<Post> posts = postRepository.findPostListByUserId(userid, pageable);

        List<PostReadRequestDto> postList = posts.getContent().stream()
                .map(post -> {
                    //like 기록 확인
                    LikesKey likesKey = new LikesKey();
                    likesKey.setPostid(post.getPostid());
                    likesKey.setUserid(loginUser.getUserid());
                    Optional<Likes> existingLike = likesRepository.findByPostIdAndUserId(likesKey);
                    boolean liked = existingLike.map(Likes::isLiked).orElse(false);
                    Long likesCount = likesRepository.countByPostId(post.getPostid());
                    Long comments = commentRepository.countByPostId(post.getPostid());

                    return new PostReadRequestDto(post, comments, likesCount, liked); // liked는 임시로 true
                })
                .collect(Collectors.toList());

        return postList;
    }

    @Transactional
    public List<PostInfoRequestDto> postInfo(Long postid, String userid, HttpServletRequest request, HttpServletResponse response) {
        PostKey postkey = new PostKey();
        postkey.setPostid(postid);

        Optional<Post> postOptional = postRepository.findByPostId(postkey);
        if (postOptional.isEmpty()) {
            return Collections.emptyList();
        }
        Post post = postOptional.get();

        // 키 생성 (userid-postid)
        String viewKey = userid + "-" + postid;
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime lastViewTime = viewTimestamps.get(viewKey);

        if (lastViewTime == null || Duration.between(lastViewTime, now).toMinutes() >= 30) {
            // 30분 이상 지났으면 조회수 증가
            post.setViews(post.getViews() + 1);
            postRepository.save(post);
            viewTimestamps.put(viewKey, now);
        }

        // 현재 사용자(userid)와 게시글 작성자(post.getUserid()) 비교
        boolean owner = userid.equals(post.getUserid());

        //like 기록 확인
        LikesKey likesKey = new LikesKey();
        likesKey.setPostid(postid);
        likesKey.setUserid(userid);
        Optional<Likes> existingLike = likesRepository.findByPostIdAndUserId(likesKey);
        Long likesCount = likesRepository.countByPostId(post.getPostid());
        Long comments = commentRepository.countByPostId(post.getPostid());

        if (existingLike.isPresent()) {
            Likes likes = existingLike.get();
            PostInfoRequestDto dto = new PostInfoRequestDto(post, comments, likesCount, owner, likes.isLiked());
            return List.of(dto);
        } else {
            PostInfoRequestDto dto = new PostInfoRequestDto(post, comments, likesCount, owner, false);
            return List.of(dto);
        }
    }

    @Transactional
    public Post update(PostUpdateRequestDto updateRequestDto) { //저장
        PostKey postKey = new PostKey();
        postKey.setPostid(updateRequestDto.getPostid());
        Post post = postRepository.findByPostId(postKey)
                .orElseThrow(() -> new IllegalArgumentException("해당 사용자가 존재하지 않습니다."));

        post.setContent(updateRequestDto.getContent());
        return postRepository.save(post);
    }

    @Transactional
    public void delete(Long postid) { //삭제
        PostKey postkey = new PostKey();
        postkey.setPostid(postid);
        Post post = postRepository.findByPostId(postkey).orElseThrow(() -> new IllegalArgumentException("존재하지 않습니다."));
        postRepository.delete(post);
    }

    public Comment commentRegister(CommentRegisterRequestDto requestDto, HttpServletRequest request, HttpServletResponse response) {
        Long maxCommentId = commentRepository.findMaxCommentId();
        Long commentId = maxCommentId + 1;

        Object user = sessionManager.getSession(request, response);
        if (user == null) {
            System.out.println("post fail");
            throw new IllegalStateException("세션이 존재하지 않습니다."); // 예외로 명확하게 처리
        }
        SessionManager.SessionData sessionData = (SessionManager.SessionData) user;
        User loginUser = (User) sessionData.getValue();
        System.out.println(sessionData.toString());
        System.out.println("User ID: " + loginUser.getUserid());
        Comment comment = requestDto.toEntity(loginUser.getUserid(), 1L, commentId);
        return commentRepository.save(comment);
    }

    @Transactional(readOnly = true)
    public List<CommentReadRequestDto> commentRead(Long postid, String userid) {
        // postid로 댓글 목록 조회 (최신순으로 정렬)
        List<Comment> comments = commentRepository.findByPostidOrderByUptimeDesc(postid);

        // Comment 엔티티를 CommentReadRequestDto로 변환
        return comments.stream()
                .map(comment -> {
                    boolean owner = comment.getUserid().equals(userid);
                    UserKey userkey = new UserKey();
                    userkey.setUserid(comment.getUserid());

                    Optional<User> userOptional = userRepository.findByUserId(userkey);
                    User user = userOptional.get();

                    return new CommentReadRequestDto(comment, owner, user.getNickname());
                })

                .collect(Collectors.toList());
    }

    @Transactional
    public void commentDelete(Long commentid) { //삭제
        Comment comment = commentRepository.findById(commentid).orElseThrow(() -> new IllegalArgumentException("존재하지 않습니다."));
        commentRepository.delete(comment);
    }

    public Likes like(LikesRequestDto requestDto, HttpServletRequest request, HttpServletResponse response) {
        Object user = sessionManager.getSession(request, response);
        if (user == null) {
            System.out.println("post fail");
            throw new IllegalStateException("세션이 존재하지 않습니다."); // 예외로 명확하게 처리
        }
        SessionManager.SessionData sessionData = (SessionManager.SessionData) user;
        User loginUser = (User) sessionData.getValue();
        System.out.println(sessionData.toString());
        System.out.println("User ID: " + loginUser.getUserid());

        //like 기록 확인
        LikesKey likesKey = new LikesKey();
        likesKey.setPostid(requestDto.getPostid());
        likesKey.setUserid(loginUser.getUserid());
        Optional<Likes> existingLike = likesRepository.findByPostIdAndUserId(likesKey);

        if (existingLike.isPresent()) {
            System.out.println("Existing like found: " + existingLike.get().isLiked());
            Likes likes = existingLike.get();
            likes.setLiked(!likes.isLiked()); // 상태 반전
            return likesRepository.save(likes); // 변경된 상태 저장
        } else {
            Likes likes = requestDto.toEntity(loginUser.getUserid(), true);
            return likesRepository.save(likes);
        }
    }

}