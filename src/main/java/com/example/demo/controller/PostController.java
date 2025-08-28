package com.example.demo.controller;

import com.example.demo.dao.Comment;
import com.example.demo.dao.Likes;
import com.example.demo.dao.Post;
import com.example.demo.dto.*;
import com.example.demo.etc.SessionManager;
import com.example.demo.service.PostService;
import jakarta.servlet.http.Cookie;
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
    private final SessionManager sessionManager;

    @PostMapping("/post/create") // 생성
    public Long create(@RequestBody PostRegisterRequestDto postRegisterRequestDto, HttpServletRequest request, HttpServletResponse response) {
        Cookie test = sessionManager.findCookie(request, "mySessionId");
        System.out.println("abcdabcd: " + test.getValue());
        return postService.register(postRegisterRequestDto, request, response);
    }

    @GetMapping("/post/read")
    public ResponseEntity<List<PostReadRequestDto>> read(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size, HttpServletRequest request, HttpServletResponse response) {
        List<PostReadRequestDto> posts = postService.readList(page, size, request, response);
        return ResponseEntity.ok(posts);
    }

    @GetMapping("/post/mypostlistread/{userid}")
    public ResponseEntity<List<PostReadRequestDto>> myPostListRead(@PathVariable String userid, @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size, HttpServletRequest request, HttpServletResponse response) {
        List<PostReadRequestDto> posts = postService.myPostListReadList(userid, page, size, request, response);
        return ResponseEntity.ok(posts);
    }

    @GetMapping("/post/info/{postid}-{userid}")
    public ResponseEntity<List<PostInfoRequestDto>> info(@PathVariable Long postid, @PathVariable String userid, HttpServletRequest request, HttpServletResponse response) {
        List<PostInfoRequestDto> posts = postService.postInfo(postid, userid, request, response);
        return ResponseEntity.ok(posts);
    }

    @PutMapping("/post/update") //수정
    public ResponseEntity<Post> update(@RequestBody PostUpdateRequestDto updateRequestDto) {
        Post post = postService.update(updateRequestDto);
        return ResponseEntity.ok(post);
    }

    @DeleteMapping("/post/delete/{postid}")
    public ResponseEntity<Long> delete(@PathVariable Long postid) {
        postService.delete(postid);
        return ResponseEntity.ok(postid);
    }

    @PostMapping("/post/comment") // 생성
    public ResponseEntity<Comment> comment(@RequestBody CommentRegisterRequestDto commentRegisterRequestDto, HttpServletRequest request, HttpServletResponse response) {
        return ResponseEntity.ok(postService.commentRegister(commentRegisterRequestDto, request, response));
    }

    @GetMapping("/post/commentList/{postid}-{userid}")
    public ResponseEntity<List<CommentReadRequestDto>> getComment(@PathVariable Long postid, @PathVariable String userid) {
        List<CommentReadRequestDto> commentRead = postService.commentRead(postid, userid);
        return ResponseEntity.ok(commentRead);
    }

    @DeleteMapping("/post/commentDelete/{commentid}")
    public ResponseEntity<Long> commnetDelete(@PathVariable Long commentid) {
        postService.commentDelete(commentid);
        return ResponseEntity.ok(commentid);
    }

    @PostMapping("/post/like") // 생성
    public ResponseEntity<Likes> like(@RequestBody LikesRequestDto likesRequestDto, HttpServletRequest request, HttpServletResponse response) {
        return ResponseEntity.ok(postService.like(likesRequestDto, request, response));
    }

}