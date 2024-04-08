package com.model2.mvc.web.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


//==> 회원관리 Controller
@Controller
public class MainController {

    ///Constructor
    public MainController(){
        System.out.println("==> MainController default Constructor call.............");
    }

    @GetMapping("/")
    public String index() {

        System.out.println("[ MainController.index() start........]");//<== 디버깅용
        //==> web.xml : <welcome-file>~~~.html or ~~.jsp</welcome-fle> : 물리적인 파일이어야 함.
        return "forward:/index.jsp";

    }
}