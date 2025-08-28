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
public class CommentReadRequestDto {
    private Long commentid;
    private String userid;
    private String comment;
    private LocalDateTime uptime;
    private boolean owner;
    private String nickname;

    public CommentReadRequestDto(Comment entity, boolean owner, String nickname) {
        this.commentid = entity.getCommentid();
        this.userid = entity.getUserid();
        this.comment = entity.getComment();
        this.uptime = entity.getUptime();
        this.owner = owner;
        this.nickname = nickname;
    }
}