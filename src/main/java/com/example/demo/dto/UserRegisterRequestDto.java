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
public class UserRegisterRequestDto {

    private String userid;
    private String userpw;
    private String nickname;
    private String username;
    private String email;
    //private Com com; //사용자구분(일반사용자/관리자?)

    public User toEntity() {
        return User.builder()
                .userid(this.userid)
                .userpw(this.userpw)
                .nickname(this.nickname)
                .username(this.username)
                .email(this.email)
                .build();
    }
}
