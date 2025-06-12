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
public class UserUpdateRequestDto {
    private String userid;
    private String nickname;
    private String currentPassword;
    private String newPassword;
}
