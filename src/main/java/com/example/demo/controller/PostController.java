package com.example.demo.controller;

import com.example.demo.dto.PostReadRequestDto;
import com.example.demo.dto.PostRegisterRequestDto;
import com.example.demo.service.PostService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class PostController {

    private final PostService postService;

    @PostMapping("/post/create") // 생성 //왜인지 모르겠다 LONG타입으로 반환해줘야지만 ajax에서 에러가 나지 않는다
    public Long create(@RequestBody PostRegisterRequestDto postRegisterRequestDto, HttpServletRequest request, HttpServletResponse response) {
        return postService.register(postRegisterRequestDto, request, response);
    }

    /*@GetMapping("/post/read") // 단일조회
    public ResponseEntity<PostReadRequestDto> get(@RequestParam Long postid) {
        PostReadRequestDto postDto = postService.read(postid);
        return ResponseEntity.ok(postDto);
    }*/

    @GetMapping("/post/read")
    public ResponseEntity<List<PostReadRequestDto>> getList() {
        List<PostReadRequestDto> posts = postService.readList();
        return ResponseEntity.ok(posts);
    }

}