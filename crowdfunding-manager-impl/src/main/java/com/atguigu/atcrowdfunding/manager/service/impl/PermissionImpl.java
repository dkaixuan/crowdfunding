package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.manager.dao.PermissionMapper;
import com.atguigu.atcrowdfunding.manager.dao.UserMapper;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PermissionImpl implements PermissionService {
    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public Permission getRootPermission() {

        return permissionMapper.getRootPermission();
    }

    @Override
    public List<Permission> getChildrenPermissionByPid(Integer id) {

        return permissionMapper.getChildrenPermission(id);
    }

    @Override
    public List<Permission> queryAllPermission() {
        return permissionMapper.queryAllPermission();
    }

    @Override
    public void savePermission(Permission permission) {
        permissionMapper.savePermission(permission);
    }

    @Override
    public Permission getPermissionById(Integer id) {
        return permissionMapper.selectByPrimaryKey(id);
    }

    @Override
    public void permissionUpdate(Permission permission) {
        permissionMapper.updateByPrimaryKey(permission);
    }

    @Override
    public List<Integer> queryPermissionIdsRoleid(Integer roleid) {
        return permissionMapper.queryPermissionIdsRoleid(roleid);
    }


}
