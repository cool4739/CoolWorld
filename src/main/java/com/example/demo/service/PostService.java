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

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
@Transactional
public class PostService {

    private final PostRepository postRepository;
    private final SessionManager sessionManager;

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

    @Transactional(readOnly = true)
    public List<PostReadRequestDto> readList(int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("postid").descending());
        List<PostReadRequestDto> postList = postRepository.findAll(pageable).stream()
                .map(PostReadRequestDto::new)
                .collect(Collectors.toList());
        return postList;
    }

    @Transactional(readOnly = true)
    public List<PostReadRequestDto> myPostListReadList(String userid, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("postid").descending());
        Page<Post> posts = postRepository.findPostListByUserId(userid, pageable);

        List<PostReadRequestDto> postList = posts.stream()
                .map(PostReadRequestDto::new)
                .collect(Collectors.toList());

        return postList;
    }

    @Transactional(readOnly = true)
    public List<PostInfoRequestDto> postInfo(Long postid, String userid) {
        PostKey postkey = new PostKey();
        postkey.setPostid(postid);

        Optional<Post> postOptional = postRepository.findByPostId(postkey);
        if (postOptional.isEmpty()) {
            return Collections.emptyList();
        }
        Post post = postOptional.get();

        // 현재 사용자(userid)와 게시글 작성자(post.getUserid()) 비교
        boolean owner = userid.equals(post.getUserid());
        PostInfoRequestDto dto = new PostInfoRequestDto(post, owner);

        return List.of(dto);
    }

    @Transactional
    public Post update(PostUpdateRequestDto updateRequestDto) { //저장
        PostKey postKey = new PostKey();
        postKey.setPostid(updateRequestDto.getPostid());
        System.out.println("test: " + updateRequestDto.getPostid());
        System.out.println("content: " + updateRequestDto.getContent());
        System.out.println("postkey: " + postKey.getPostid());
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
}