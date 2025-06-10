package com.example.demo.controller;

import com.example.demo.dao.User;
import com.example.demo.etc.SessionManager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

@Controller
public class HomeController {

    private final SessionManager sessionManager;

    public HomeController(SessionManager sessionManager) {
        this.sessionManager = sessionManager;
    }

    //login, main 세션체크 중복되는 코드 따로 분리
    private String handleSession(HttpServletRequest request, HttpServletResponse response, String noSessionPage, String sessionPage) {
        Object user = sessionManager.getSession(request, response);
        if (user == null) {
            System.out.println("no session");
            return noSessionPage;
        } else {
            SessionManager.SessionData sessionData = (SessionManager.SessionData) user;
            User loginUser = (User) sessionData.getValue();
            System.out.println("User ID: " + loginUser.getUserid());
            return sessionPage;
        }
    }

    @RequestMapping("/test")
    public String test() {
        System.out.println("test");
        return "index";
    }

    @RequestMapping("/")
    public String login(HttpServletRequest request, HttpServletResponse response) {
        return handleSession(request, response, "login", "main");
    }

/*    @RequestMapping("/")
    public String login(@SessionAttribute(name = "user", required = false) User user, Model model) {
        if (user == null) { // [세션ID 쿠키]에 해당되는 세션 데이터없음
            System.out.println("no session");
            return "login";
        } else { // 세션있음. 로그인상태 유지
            System.out.println("User ID: " + user.getId());
        }
        return "main";
    }*/

    @RequestMapping("/register")
    public String register() {
        return "register";
    }

    @RequestMapping("/findId")
    public String findId() {
        return "findId";
    }

    @RequestMapping("/findPw")
    public String findPw() {
        return "findPw";
    }

    @RequestMapping("/main")
    public String main(HttpServletRequest request, HttpServletResponse response) {
        return handleSession(request, response, "login", "main");
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        sessionManager.expire(request, response);
        return "login";
    }

    @RequestMapping("/newpost")
    public String newpost(HttpServletRequest request, HttpServletResponse response) {
        return handleSession(request, response, "login", "newpost");
    }

    @RequestMapping("/mypage")
    public String mypage(HttpServletRequest request, HttpServletResponse response, Model model) {
        Object user = sessionManager.getSession(request, response);
        if (user == null) {
            return "login";
        }
        SessionManager.SessionData sessionData = (SessionManager.SessionData) user;
        User loginUser = (User) sessionData.getValue();

        model.addAttribute("userid", loginUser.getUserid());

        return handleSession(request, response, "login", "mypage");
    }

}
