package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Msg;
import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.StringUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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


    /**
     * 分配角色
     * @param userid
     * @param roleIds
     * @return
     */
    @ResponseBody
    @RequestMapping("/doAssignRole")
    public Msg doAssignRole(@RequestParam("userid") Integer userid,
                            @RequestParam("roleIds") String roleIds){
        try {
            ArrayList roleIdList = new ArrayList();
            if (userid != null && StringUtils.isNotBlank(roleIds)) {
                if (roleIds.contains(",")) {
                    String[] split = roleIds.split(",");
                    for (String s : split) {
                        roleIdList.add(s);
                    }
                }else{
                    roleIdList.add(roleIds);
                }
            }
            userService.saveUserRole(userid, roleIdList);
        } catch (Exception e) {
            e.printStackTrace();
        }


        return Msg.success();
    }

    /**
     * 取消分配角色
     * @param userid
     * @param roleIds
     * @return
     */
    @ResponseBody
    @RequestMapping("/doUnAssignRole")
    public Msg doUnAssignRole(@RequestParam("userid") Integer userid,
                              @RequestParam("roleIds") String roleIds){
        try {
            ArrayList roleIdList = new ArrayList();
            if (userid != null && StringUtils.isNotBlank(roleIds)) {
                if (roleIds.contains(",")) {
                    String[] split = roleIds.split(",");
                    for (String s : split) {
                        roleIdList.add(s);
                    }
                }else{
                    roleIdList.add(roleIds);
                }
            }
            userService.deleteUserRole(userid,roleIdList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Msg.success();
    }

    //显示分配角色
    @RequestMapping("/assignRole")
    public String assignRole(Integer id, Map map) {
        map.put("id",id);
        return "user/assignrole" ;
    }



    @ResponseBody
    @RequestMapping("/getAssignRole")
    public Msg getAssignRole(Integer id) {

        //已分配列表
        ArrayList<Role> rightList = new ArrayList<>();
        //所有角色列表
        List<Role> allRoles = userService.queryAllRole();

        List<Role> userRoleIds = userService.queryRoleByUserId(id);
        for (Role allRole : allRoles) {
            //用户已经分配的角色
            if (userRoleIds.contains(allRole.getId())) {
                rightList.add(allRole);
            }
        }
        return Msg.success().add("leftList", allRoles).add("rightList", rightList);

    }

    @ResponseBody
    @RequestMapping(value = "/users", method = RequestMethod.GET)
    public Msg getUserList(@RequestParam(value = "page", defaultValue = "1") Integer page,
                           @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                           String queryText) {

        PageHelper.startPage(page, limit);
        List<User> list = userService.queryUsers(queryText);
        PageInfo pageInfo = new PageInfo(list, 6);

        return Msg.success().add("pageInfo", pageInfo);
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

        if (StringUtils.isNotBlank(ids)&&ids.contains(",")) {
            ArrayList arrayList = new ArrayList();
            String[] split = ids.split(",");
            for (String s : split) {
                arrayList.add(s);
            }
            userService.deleteUserBatch(arrayList);

        }
        if(StringUtils.isNotBlank(ids)&&!ids.contains(",")){
            userService.deleteUser(Integer.parseInt(ids));
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
