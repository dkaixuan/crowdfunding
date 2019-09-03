package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Msg;
import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

     @RequestMapping("/index")
     public String user() {

        return "/user/index";
    }

    @RequestMapping("/toRole")
    public String toRole() {
        return "/user/role";
    }

    @ResponseBody
    @RequestMapping("/doAssignRole")
    public Msg doAssignRole(Integer userid,String ids){
         try {
             List<Integer> save_ids = new ArrayList<>();
             if(ids.contains("-")){
                 String[] split = ids.split("-");
                 for (String s : split) {
                     save_ids.add(Integer.parseInt(s));
                 }
             }else{
                 save_ids.add(Integer.parseInt(ids));
             }
             userService.saveUserRole(userid,save_ids);
             return Msg.success();
         }catch (Exception e){
             return Msg.fail();
         }
    }

    @ResponseBody
    @RequestMapping("/doUnAssignRole")
    public Msg doUnAssignRole(Integer userid,String ids){
        try {
            List<Integer> del_ids = new ArrayList<>();
            if(ids.contains("-")){
                String[] split = ids.split("-");
                for (String s : split) {
                    del_ids.add(Integer.parseInt(s));
                }
            }else{
                del_ids.add(Integer.parseInt(ids));
            }
            userService.deleteUserRole(userid, del_ids);
            return Msg.success();
        }catch (Exception e){
            return Msg.fail();
        }
    }







    //显示分配角色
    @RequestMapping("/assignRole")
    public String assignRole(Integer id, Map map) {
        List<Role> listRole = userService.queryAllRole();
        List<Role> roleIds=userService.queryRoleByUserId(id);

        List<Role> leftRoleList = new ArrayList<>(); //未分配角色
        List<Role> rightRoleList = new ArrayList<>(); //已分配角色

        for (Role role : listRole) {
            if (roleIds.contains(role.getId())) {
                rightRoleList.add(role);
            }else{
                leftRoleList.add(role);
            }
        }
        map.put("leftRoleList", leftRoleList);
        map.put("rightRoleList", rightRoleList);

        return "user/assignrole" ;
    }


    @ResponseBody
    @RequestMapping(value = "/users",method = RequestMethod.GET)
    public Msg queryUsers(@RequestParam(value ="pn",defaultValue ="1") Integer pn,String queryText) {
        PageHelper.startPage(pn,10);
         List<User> list=userService.queryUsers(queryText);
        PageInfo pageInfo = new PageInfo(list, 6);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @ResponseBody
    @RequestMapping(value ="/user",method =RequestMethod.POST)
    public Msg saveUser(User user) {
        System.out.println(user.getEmail());

        userService.saveUser(user);

        return Msg.success();
    }


    @ResponseBody
    @RequestMapping("/doDelete")
    public Msg deleteUser(@RequestParam(value = "ids",required =false) String ids) {
        List<Integer> del_id = new ArrayList<>();
        if (ids.contains("-")) {
            String[] split = ids.split("-");
            for (String string : split) {
                del_id.add(Integer.parseInt(string));
            }
            userService.deleteUserBatch(del_id);
        }else{
            Integer id = Integer.parseInt(ids);
            userService.deleteUser(id);
        }
        return Msg.success();
    }


    @ResponseBody
    @RequestMapping("/doUpdate")
    public Msg doUpdate(User user) {
        System.out.println(user);
       userService.updateUser(user);
        return Msg.success();
    }



}
