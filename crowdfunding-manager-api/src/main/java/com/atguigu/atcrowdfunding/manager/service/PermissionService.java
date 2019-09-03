package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Permission;

import java.util.List;

public interface PermissionService {
    Permission getRootPermission();


    List<Permission> getChildrenPermissionByPid(Integer id);

    List<Permission> queryAllPermission();

    void savePermission(Permission permission);

    Permission getPermissionById(Integer id);

    void permissionUpdate(Permission permission);

    List<Integer> queryPermissionIdsRoleid(Integer roleid);
}
