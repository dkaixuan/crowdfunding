package com.atguigu.atcrowdfunding.Controller;

import com.atguigu.atcrowdfunding.bean.Msg;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.atguigu.atcrowdfunding.util.exception.LoginFailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
@Controller
public class DispathcherController {
    @Autowired
    private UserService userService;

    @RequestMapping("/index")
    public String index() {
        return "index";
    }

    @RequestMapping("/login")
    public String login() {

        return "login";
    }

    @RequestMapping("/main")
    public String main() {
        return "main";
    }

    @ResponseBody
    @RequestMapping("/doLogin")
    public Object doLogin(String loginacct, String userpswd, String type, HttpSession httpSession) {

        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("loginacct",loginacct);
            paramMap.put("userpswd", MD5Util.digest(userpswd));
            paramMap.put("type",type);
            User user = userService.queryUserlogin(paramMap);
            httpSession.setAttribute(Const.LOGIN_USER,user);
            return Msg.success();

        } catch (LoginFailException e) {
            return Msg.fail();
        }
    }
    @RequestMapping("/logout")
    public String logout(HttpSession httpSession) {

        httpSession.invalidate();

        return "redirect:/index.htm";
    }




}
