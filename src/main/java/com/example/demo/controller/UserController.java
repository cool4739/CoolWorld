package com.example.demo.controller;

//import com.dto.UserRegisterRequestDto;
//import com.dto.UserUpdateDto;
import com.example.demo.dao.User;
import com.example.demo.dto.UserLoginRequestDto;
import com.example.demo.etc.SessionManager;
import com.example.demo.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@RequiredArgsConstructor
@RestController
public class UserController {

    private final UserService userService;
    private final SessionManager sessionManager;

/*    @PostMapping("/user") // 생성
    public Long create(@RequestBody UserRegisterRequestDto userRegisterRequestDto) {
        //System.out.println("user" + user.getName());
        //System.out.println("user" + user.getId());
        //System.out.println("user" + user.getAddress());
        return userService.register(userRegisterRequestDto);
    }

    @GetMapping("/user/info") // 조회
    public User read(HttpSession httpSession) {
        User user = (User)httpSession.getAttribute("user");
        return userService.findById(user.getNum());
    }*/
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
    public ResponseEntity<?> webLogin(@RequestBody UserLoginRequestDto dto, HttpServletResponse response) {
        userService.login(dto, response);

        return ResponseEntity.ok().body("login success");
        //return ResponseEntity.ok().body(userService.login(dto));
    }

}

//https://jiwondev.tistory.com/171?category=879790 로그인 유지 참고 사이트

