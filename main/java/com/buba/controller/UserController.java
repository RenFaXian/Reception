package com.buba.controller;

import com.buba.bean.User;
import com.buba.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("User")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("login1")
    @ResponseBody
    public boolean login(User user, HttpSession session){
        User user1 = userService.login(user.getCodename(),user.getPassword());
        if(user1!=null){
            session.setAttribute("user",user1);
            return true;
        }
        return false;
    }

    //退出登陆
    @RequestMapping("signout")
    public String signout(HttpSession session){
        if(session.getAttribute("user")!=null){
            session.removeAttribute("user");
        }
        return "login";
    }

    //添加用户
    @RequestMapping("insertUser")
    @ResponseBody
    public boolean insertUser(User user){
        int i = userService.insertUser(user);
        if(i>0){
            return true;
        }
        return false;
    }
}
