package com.example.demo.controller;

import com.example.demo.dao.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

@Controller
public class HomeController {

    @RequestMapping("/test")
    public String test() {
        System.out.println("test");
        return "index";
    }

    @RequestMapping("/")
    public String login2(@SessionAttribute(name = "user", required = false) User user, Model model) {

        // [세션ID 쿠키]에 해당되는 세션 데이터없음
        if (user == null) {
            System.out.println("no session");
            return "login";
        }

        // 세션있음. 로그인상태 유지
        model.addAttribute("user", user);
        System.out.println("yes session");
        return "main";
    }

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

}
