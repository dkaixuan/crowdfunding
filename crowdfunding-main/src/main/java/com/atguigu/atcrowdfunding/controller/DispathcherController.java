package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.Msg;
import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.atguigu.atcrowdfunding.util.exception.LoginFailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockServletContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class DispathcherController {
    @Autowired
    private UserService userService;

    @Autowired
    private MemberService memberService;

    @RequestMapping("/index")
    public String index(HttpSession session) {
        return "index";
    }

    @RequestMapping("/login")
    public String login(HttpServletRequest request) {
        Integer total_online_users = (Integer) request.getAttribute("TOTAL_ONLINE_USERS");
        System.out.println("在线人数------"+total_online_users);
        return "login";
    }

    @RequestMapping("/main")
    public String main() {

        return "main";
    }

    @ResponseBody
    @RequestMapping("/doLogin")
    public Object doLogin(String loginacct, String userpswd, String type, String rememberme,HttpSession session) {
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("loginacct",loginacct);
            paramMap.put("userpswd", MD5Util.digest(userpswd));
            paramMap.put("type",type);


            if ("member".equals(type)) {
            Member member=memberService.queryMemberLogin(paramMap);
                session.setAttribute(Const.LOGIN_MEMBER,member);

            } else if ("user".equals(type)) {
                User user = userService.queryUserlogin(paramMap);
                session.setAttribute(Const.LOGIN_USER,user);

            //--------------------//
            Map<Integer, Permission> map = new HashMap<>();
            List<Permission> myPermissions = userService.queryPermissionByUserId(user.getId());

            Permission permissionRoot = null;
            Set<String> myUris = new HashSet<>();

            for (Permission innerpermission : myPermissions) {
                map.put(innerpermission.getId(), innerpermission);
                myUris.add("/"+innerpermission.getUrl());
            }
            session.setAttribute(Const.MY_URIS,myUris);
            for (Permission permission : myPermissions) {
                Permission child=permission;
                if (child.getPid()==null) {
                    permissionRoot=permission;
                }else{
                    Permission parent = map.get(child.getPid());
                    parent.getChildren().add(child);
                }
            }

            session.setAttribute("permissionRoot", permissionRoot);
            //-----------------------//
            }
            return Msg.success().add("type",type);

        } catch (LoginFailException e) {
            return Msg.fail();
        }
    }



    @RequestMapping("/logout")
    public String logout(HttpSession httpSession) {
        httpSession.invalidate();
        return "redirect:/index.htm";
    }


    @RequestMapping("/member")
    public String member() {

        return "member/member";
    }


}
