package com.example.demo.service;

import com.example.demo.dao.*;
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

    /*@Transactional(readOnly = true) // 기능을 조회로 제한, 조회 속도 개선
    public PostReadRequestDto read(Long postid) { // 읽기
        Post post = postRepository.findByPostId(postid)
                .orElseThrow(() -> new IllegalArgumentException("없음"));
        return new PostReadRequestDto(post);
    }*/

    @Transactional(readOnly = true)
    public List<PostReadRequestDto> readList() {
        List<PostReadRequestDto> postList = postRepository.findAll().stream() //post테이블에서 모든데이터 가져오기
                .map(PostReadRequestDto::new) // 각각post를 dto에 맞춰서 바꾸고
                .collect(Collectors.toList()); //그걸 다시 list로

        return postList;
    }

    @Transactional(readOnly = true)
    public List<PostReadRequestDto> myPostListReadList(String userid) {
        List<Post> posts = postRepository.findAllByUserId(userid);

        List<PostReadRequestDto> postList = posts.stream()
                .map(PostReadRequestDto::new)
                .collect(Collectors.toList());

        return postList;
    }
}