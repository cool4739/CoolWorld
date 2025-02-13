package com.example.demo.dto;

import com.example.demo.dao.User;
import com.example.demo.dao.UserKey;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserRegisterRequestDto {

    private UserKey userKey;
    private String userpw;
    private String nickname;
    private String username;
    //private Com com; //사용자구분(일반사용자/관리자?)

    public User toEntity() {
        return User.builder()
                .userid(this.userKey.getUserid())
                .userpw(this.userpw)
                .nickname(this.nickname)
                .username(this.username)
                .email(this.userKey.getEmail())
                .build();
    }
}
