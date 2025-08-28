package com.example.demo.dto;

import com.example.demo.dao.Comment;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CommentRegisterRequestDto {
    private String comment;
    private Long postid;

    public Comment toEntity(String userId, Long commentnum, Long commentid) {
        return Comment.builder()
                .commentid(commentid)
                .postid(this.postid)
                .userid(userId)
                .commentnum(commentnum)
                .comment(this.comment)
                .uptime(LocalDateTime.now())
                .build();
    }
}