package com.example.demo.service;

import com.example.demo.dto.UserLoginRequestDto;
//import com.dto.UserRegisterRequestDto;
//import com.dto.UserUpdateDto;
import com.example.demo.dao.User;
import com.example.demo.dao.UserRepository;
import com.example.demo.etc.SessionManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@RequiredArgsConstructor
@Service
@Transactional
public class UserService {

    private final UserRepository userRepository;
    private final SessionManager sessionManager;
    private final HttpSession httpSession;

    public User findById(Long num) {
        return userRepository.findById(num).orElseThrow(() -> new IllegalArgumentException("존재하지 않는 유저입니다."));
    }

/*    @Transactional
    public Long save(User user) { //저장
        return userRepository.save(user).getNum();
    }*/

/*    @Transactional
    public Long update(Long num, UserUpdateDto updateDto) { //수정
        User user = userRepository.findById(num)
                .orElseThrow(() -> new IllegalCallerException("없음"));
        user.update(updateDto);
        return num;
    }*/

    /*@Transactional
    public Long read(Long user_num, UserReadRequestDto userReadRequestDto) { //읽기
        User user = userRepository.findById(user_num)
                                  .orElseThrow(() -> new IllegalCallerException("없음"));
        return user_num;
    }*/

    @Transactional
    public void delete(Long num) { //삭제
        User user = findById(num);
        userRepository.delete(user);
    }

    public User login(UserLoginRequestDto requestDto, HttpServletResponse response) {
        User user = userRepository.findByUserId(requestDto.getId())
                .orElseThrow(() -> new IllegalCallerException("테이블에 유저가 없습니다"));
        if (user.getPw().equals(requestDto.getPw())) { //서버데이터 equals 입력한것
            httpSession.setAttribute("user",user); //user이라는 세션세팅
            return user;
        } else {
            System.out.println(requestDto.getId());
            System.out.println(requestDto.getPw());
            throw new IllegalCallerException("패스워드불일치");
        }
    }

  /*  public void login2(UserSaveRequestDto requestDto) { // void

        User user = userRepository.findByUserId(requestDto.getId())
                .orElseThrow(() -> new IllegalCallerException("테이블에 유저가 없습니다"));
        if (!user.getUser_pw().equals(requestDto.getPassword())) {
            throw new IllegalCallerException("패스워드불일치");
        } else {

        }
    }*/

/*    public Long register(UserRegisterRequestDto requestDto) {
        User user = requestDto.toEntity();
        User save = userRepository.save(user);
        return save.getNum();
    }*/
}