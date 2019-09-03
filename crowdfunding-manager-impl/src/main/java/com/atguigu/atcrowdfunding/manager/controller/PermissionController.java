package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Msg;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/permission")
public class PermissionController {
    @Autowired
    private PermissionService permissionService;

    @RequestMapping("/index")
    public String index() {
        return "permission/index";
    }


    @RequestMapping("/toAdd")
    public String toAdd() {
        return "permission/add";
    }


    @RequestMapping("/toUpdate")
    public String toUpdate(Integer id, Map map) {
     Permission permission=permissionService.getPermissionById(id);
        map.put("permission", permission);

        return "permission/update";
    }

    @RequestMapping("/doUpdate")
    public String doUpdate(Permission permission) {
        permissionService.permissionUpdate(permission);

        return "permission/update";
    }





    @ResponseBody
    @RequestMapping("/doAdd")
    public Msg doAdd(Permission permission) {
        permissionService.savePermission(permission);

        return Msg.success();
    }







    //Demo1 模拟生成树
//    @ResponseBody
//    @RequestMapping("/loadData")
//    public Msg loadData() {
//        //父
//        Permission permission = new Permission();
//        permission.setName("系统权限菜单");
//        permission.setOpen(true);
//
//
//        //子
//        List<Permission> children = new ArrayList<>();
//        Permission permission1 = new Permission();
//        permission1.setName("控制面板");
//        Permission permission2 = new Permission();
//        permission2.setName("权限管理");
//
//        children.add(permission1);
//        children.add(permission2);
//
//        permission.setChildren(children);
//
//
//        List<Permission> root = new ArrayList<>();
//        root.add(permission);
//
//
//        return Msg.success().add("permission",permission);
//    }



    //Demo2 循环
//    @ResponseBody
//    @RequestMapping("/loadData")
//    public Msg loadData() {
//        //父
//            Permission permission = permissionService.getRootPermission();
//
//
//        //子
//            List<Permission> children = permissionService.getChildrenPermissionByPid(permission.getId());
//
//
//        permission.setChildren(children);
//
//
//            for (Permission child : children) {
//                child.setOpen(true);
//                List<Permission> innerchildren = permissionService.getChildrenPermissionByPid(child.getId());
//                child.setChildren(innerchildren);
//            }
//
//
//        List<Permission> root = new ArrayList<>();
//        root.add(permission);
//
//
//        return Msg.success().add("permission",permission);
//    }




//    //Demo3递归调用
//    @ResponseBody
//    @RequestMapping("/loadData")
//    public Msg loadData() {
//
//
//        //父
//        Permission permission = permissionService.getRootPermission();
//        queryChildPermissions(permission);

//        List<Permission> root = new ArrayList<>();
//        root.add(permission);
//
//
//
//        return Msg.success().add("root",root);
//    }
//
//    private void queryChildPermissions(Permission permission) {
//        List<Permission> children = permissionService.getChildrenPermissionByPid(permission.getId());
//        permission.setChildren(children);
//        for (Permission innerChildren:children) {
//            queryChildPermissions(innerChildren);
//        }
//    }
//



//    //Demo4一次查询所有数据
//    @ResponseBody
//    @RequestMapping("/loadData")
//    public Msg loadData() {
//        List<Permission> root = new ArrayList<>();
//        List<Permission> childredPermissions = permissionService.queryAllPermission();
//        for (Permission permission : childredPermissions) {
//             Permission child=permission;
//            if (child.getPid()==null) {
//                root.add(permission);
//            }else{
//                for (Permission innerpermission : childredPermissions) {
//                    if (child.getPid() == innerpermission.getId()) {
//                        Permission parent = innerpermission;
//                        parent.getChildren().add(child);
//                        break;
//                    }
//                }
//
//            }
//
//        }
//
//        return Msg.success().add("permission",root);
//    }
//

    //Demo5 map 解决双层for循环的问题
    @ResponseBody
    @RequestMapping("/loadData")
    public Msg loadData() {
        List<Permission> root = new ArrayList<>();
        List<Permission> childredPermissions = permissionService.queryAllPermission();
        Map<Integer, Permission> map = new HashMap<>();
        for (Permission innerpermission : childredPermissions) {
            map.put(innerpermission.getId(), innerpermission);
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

        return Msg.success().add("permission",root);
    }




//    private void queryChildPermissions(Permission permission) {
//        List<Permission> children = permissionService.getChildrenPermissionByPid(permission.getId());
//        permission.setChildren(children);
//        for (Permission innerChildren:children) {
//            queryChildPermissions(innerChildren);
//        }
//    }














}
