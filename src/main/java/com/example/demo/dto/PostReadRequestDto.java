package com.example.demo.dto;

import com.example.demo.dao.Post;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class PostReadRequestDto {
    private Long postid;
    private String content;
    private Long views;
    private Long comments;
    private Long likes;

    public PostReadRequestDto(Post entity) {
        this.postid = entity.getPostid();
        this.content = entity.getContent();
        this.views = entity.getViews();
        this.comments = entity.getComments();
        this.likes = entity.getLikes();
    }
}