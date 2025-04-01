package com.example.demo.service;

import com.example.demo.dao.Post;
import com.example.demo.dao.PostRepository;
import com.example.demo.dao.User;
import com.example.demo.dto.PostRegisterRequestDto;
import com.example.demo.etc.SessionManager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
@Transactional
public class PostService {

    private final PostRepository postRepository;
    private final SessionManager sessionManager;

    public Long register(PostRegisterRequestDto requestDto, HttpServletRequest request, HttpServletResponse response) {
        // 현재 가장 큰 postid 찾기
        int maxPostId = postRepository.findMaxPostId();
        // 새로운 postid = 기존 최대값 + 1
        String PostId = String.valueOf(maxPostId + 1);

        Object user = sessionManager.getSession(request, response);
        if (user == null) {
            System.out.println("post fail");
            return 0L; //세션아웃
        } else {
            SessionManager.SessionData sessionData = (SessionManager.SessionData) user;
            User loginUser = (User) sessionData.getValue();
            System.out.println("User ID: " + loginUser.getUserid());
            Post post = requestDto.toEntity(PostId, loginUser.getUserid(), loginUser.getNickname());
            postRepository.save(post);
            return 1L; //성공
        }
    }
}