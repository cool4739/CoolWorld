package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class TestController {

    @GetMapping("/test")
    public String test() {
        System.out.println("test");
        return "index";
    }

    @GetMapping("/")
    public String login() {
        System.out.println("test");
        return "login";
    }
}