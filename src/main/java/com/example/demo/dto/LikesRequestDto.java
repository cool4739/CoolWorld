package com.example.demo.dto;

import com.example.demo.dao.Likes;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class LikesRequestDto {
    private Long postid;

    public Likes toEntity(String userId, boolean like) {
        return Likes.builder()
                .postid(this.postid)
                .userid(userId)
                .liked(like)
                .build();
    }
}