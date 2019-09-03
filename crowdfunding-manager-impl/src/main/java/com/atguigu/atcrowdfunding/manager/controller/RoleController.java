package com.atguigu.atcrowdfunding.manager.controller;


import com.atguigu.atcrowdfunding.bean.Msg;
import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import com.atguigu.atcrowdfunding.manager.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Insert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    private RoleService roleService;

    @Autowired
    private PermissionService permissionService;

    @RequestMapping("/index")
    public String toRole() {
        return "role/index";
    }

    @ResponseBody
    @RequestMapping("/roles")
    public Msg roles(@RequestParam(value = "pn",defaultValue ="1") Integer pn) {
        PageHelper.startPage(pn, 10);
        List<Role> list = roleService.queryAllRole();
        PageInfo pageInfo = new PageInfo(list, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }
    @RequestMapping("/toAssignRole")
    public String toAssignRole() {

        return "role/assignpermission";
    }


    @ResponseBody
    @RequestMapping("/loadDataAsync")
    public List<Permission> loadData(Integer roleid) {
        List<Permission> root = new ArrayList<>();
        List<Permission> childredPermissions = permissionService.queryAllPermission();

        List<Integer> permissionIdsForId=permissionService.queryPermissionIdsRoleid(roleid);

        Map<Integer, Permission> map = new HashMap<>();
        for (Permission innerpermission : childredPermissions) {
            map.put(innerpermission.getId(), innerpermission);
            if (permissionIdsForId.contains(innerpermission.getId())) {
                innerpermission.setChecked(true);
            }
        }
        for (Permission permission : childredPermissions) {
            Permission child=permission;
            if (child.getPid()==null) {
                root.add(permission);
            }else{
                Permission parent = map.get(child.getPid());
                parent.getChildren().add(child);
            }

        }

        return root;
    }


    @ResponseBody
    @RequestMapping("/doAssignPermission")
    public Msg doAssignPermission(String ids,Integer roleid) {
        //删除roleid 对应的所有数据

        roleService.deleteAll(roleid);
        List<Integer> ins_id = new ArrayList<>();
        if (ids.contains("-")) {
            String[] split = ids.split("-");
            for (String s : split) {
                ins_id.add(Integer.parseInt(s));
            }
        }

        roleService.insertRolePermission(ins_id,roleid);


        return Msg.success();
    }




















}
