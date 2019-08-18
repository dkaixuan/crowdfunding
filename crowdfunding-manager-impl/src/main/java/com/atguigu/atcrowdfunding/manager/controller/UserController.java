package com.atguigu.atcrowdfunding.manager.controller;


import com.atguigu.atcrowdfunding.bean.Msg;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

     @RequestMapping("/index")
     public String user() {

        return "/user/index";
    }

    @ResponseBody
    @RequestMapping(value = "/users",method = RequestMethod.GET)
    public Msg queryUsers(@RequestParam(value ="pn",defaultValue ="1") Integer pn) {
        PageHelper.startPage(pn,10);
         List<User> list=userService.queryUsers();
        PageInfo pageInfo = new PageInfo(list, 6);
        return Msg.success().add("pageInfo",pageInfo);
    }

}
