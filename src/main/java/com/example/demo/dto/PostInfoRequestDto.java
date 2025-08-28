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
public class PostInfoRequestDto {
    private Long postid;
    private String userid;
    private String nickname;
    private String content;
    private Long views;
    private Long comments;
    private Long likes;
    private LocalDateTime uptime;
    private String imagepath;
    private boolean owner;
    private boolean liked;

    public PostInfoRequestDto(Post entity, Long comments, Long likes, boolean owner, boolean liked) {
        this.postid = entity.getPostid();
        this.userid = entity.getUserid();
        this.nickname = entity.getNickname();
        this.content = entity.getContent();
        this.views = entity.getViews();
        this.comments = comments;
        this.likes = likes;
        this.uptime = entity.getUptime();
        this.imagepath = entity.getImagepath();
        this.owner = owner;
        this.liked = liked;
    }

    public PostInfoRequestDto(Post post) {
        this(post, 0L, 0L,false, false); // 기본값 false
    }
}