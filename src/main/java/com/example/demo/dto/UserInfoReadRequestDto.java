package com.example.demo.dto;

import com.example.demo.dao.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserInfoReadRequestDto {
    private String userid;
    private String username;
    private String nickname;
    private String email;

    public UserInfoReadRequestDto(User entity) {
        this.userid = entity.getUserid();
        this.username = entity.getUsername();
        this.nickname = entity.getNickname();
        this.email = entity.getEmail();
    }
}