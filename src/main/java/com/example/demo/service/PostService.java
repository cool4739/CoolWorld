package com.example.demo.service;

import com.example.demo.dao.Post;
import com.example.demo.dao.PostRepository;
import com.example.demo.dao.User;
import com.example.demo.dto.PostReadRequestDto;
import com.example.demo.dto.PostRegisterRequestDto;
import com.example.demo.etc.SessionManager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
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
        System.out.println("User ID: " + loginUser.getUserid());
        Post post = requestDto.toEntity(PostId, loginUser.getUserid(), loginUser.getNickname());
        Post savedPost = postRepository.save(post);
        return savedPost.getPostid(); // 실제 저장된 ID 반환
    }

    @Transactional(readOnly = true) // 기능을 조회로 제한, 조회 속도 개선
    public PostReadRequestDto read(Long postid) { // 읽기
        Post post = postRepository.findByPostId(postid)
                .orElseThrow(() -> new IllegalArgumentException("없음"));
        return new PostReadRequestDto(post);
    }

    @Transactional(readOnly = true)
    public List<PostReadRequestDto> readList() {
        List<PostReadRequestDto> postList = postRepository.findAll().stream()
                .map(PostReadRequestDto::new)
                .collect(Collectors.toList());

        // 로그 출력
        postList.forEach(post -> {
            System.out.println("Content: " + post.getContent());
            System.out.println("Views: " + post.getViews());
            System.out.println("Comments: " + post.getComments());
            System.out.println("Likes: " + post.getLikes());
            System.out.println("-----------------------------");
        });

        return postList;
    }
}