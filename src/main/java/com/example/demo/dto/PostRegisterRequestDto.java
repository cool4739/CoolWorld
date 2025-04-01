package com.example.demo.dto;

import com.example.demo.dao.Post;
import com.example.demo.dao.PostKey;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class PostRegisterRequestDto {

    private String content;

    public Post toEntity(String postId, String userId, String nickName) {
        return Post.builder()
                .postid(postId)
                .userid(userId)
                .nickname(nickName)
                .content(this.content)
                .uptime(LocalDateTime.now())
                .build();
    }
}
