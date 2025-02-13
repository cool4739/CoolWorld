package com.example.demo.dto;

import com.example.demo.dao.UserKey;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserLoginRequestDto {

    private UserKey userKey;
    private String userpw;

}
