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

    private String id;
    private String pw;
    private String nickname;
    private String name;
    private String email;
    //private Com com; //사용자구분(일반사용자/관리자?)

    public User toEntity() {
        return User.builder()
                .id(this.id)
                .pw(this.pw)
                .nickname(this.nickname)
                .name(this.name)
                .email(this.email)
                .build();
    }
}
