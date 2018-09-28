package org.szi.boot.controller;//Created on 3/7/18


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController
{
    @RequestMapping("/")
    public String  home() {
        return "Das boot, reporting for duty";
    }
}
