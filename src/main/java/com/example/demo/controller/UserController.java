package com.example.demo.controller;

//import com.dto.UserUpdateDto;
import com.example.demo.dao.User;
import com.example.demo.dto.UserLoginRequestDto;
import com.example.demo.dto.UserRegisterRequestDto;
import com.example.demo.etc.SessionManager;
import com.example.demo.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;
import java.util.Objects;

@RequiredArgsConstructor
@RestController
public class UserController {

    private final UserService userService;
    private final SessionManager sessionManager;

    private User getLoginUser(HttpServletRequest request, HttpServletResponse response) {
        Object user = sessionManager.getSession(request, response);
        if (user == null) {
            return null;
        } else {
            SessionManager.SessionData sessionData = (SessionManager.SessionData) user;
            return (User) sessionData.getValue();
        }
    }

    @PostMapping("/user/create") // 생성 //왜인지 모르겠다 LONG타입으로 반환해줘야지만 ajax에서 에러가 나지 않는다
    public Long create(@RequestBody UserRegisterRequestDto userRegisterRequestDto) {
        return userService.register(userRegisterRequestDto); // 0 -> id, 1 -> email, 2 -> ok
    }

    @GetMapping("/user/mypage/{userid}")
    public User getUserById(@PathVariable String userid) {
        if (userid == null) {
            System.out.println("null");
            return null;
        }
        return userService.findById(userid);
    }
    //session.invalidate(); 세션 제거

    /*@GetMapping("/user/{user_num}") // 조회
    public Long read(@PathVariable Long user_num, @RequestBody UserReadRequestDto userReadRequestDto) {
        return userService.read(user_num, userReadRequestDto);
    }*/

/*    @PutMapping("/user/update") //수정
    public Long update(HttpSession httpSession, @RequestBody UserUpdateDto updateDto) {
        System.out.println("update api");
        User user = (User)httpSession.getAttribute("user");
        return userService.update(user.getNum(), updateDto);
    }

    @DeleteMapping("/user/{num}/delete") //삭제
    public Long delete(@PathVariable Long num) {
        userService.delete(num);
        return num;
    }*/

    @PostMapping("/user/login") //로그인
    public User webLogin(@RequestBody UserLoginRequestDto dto, HttpServletResponse response, HttpServletRequest request) {
        return userService.login(dto, response, request);
    }

    @GetMapping("/user/findIdPro/{email}") //아이디찾기
    public User findIdPro(@PathVariable("email") String email) {
        return userService.findByEmail(email);
    }

    @PostMapping("/user/logout")
    public ResponseEntity<Void> logout(HttpServletRequest request, HttpServletResponse response) {
        userService.logout(request, response);
        Map<String, String> result = Map.of("message", "logout success"); //json응답용
        return ResponseEntity.ok().build();
    }

}

//https://jiwondev.tistory.com/171?category=879790 로그인 유지 참고 사이트

