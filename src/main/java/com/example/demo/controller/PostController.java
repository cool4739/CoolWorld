package com.example.demo.controller;

import com.example.demo.dto.PostRegisterRequestDto;
import com.example.demo.service.PostService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
public class PostController {

    private final PostService postService;

    @PostMapping("/post/create") // 생성 //왜인지 모르겠다 LONG타입으로 반환해줘야지만 ajax에서 에러가 나지 않는다
    public Long create(@RequestBody PostRegisterRequestDto postRegisterRequestDto, HttpServletRequest request, HttpServletResponse response) {
        return postService.register(postRegisterRequestDto, request, response);
    }

}