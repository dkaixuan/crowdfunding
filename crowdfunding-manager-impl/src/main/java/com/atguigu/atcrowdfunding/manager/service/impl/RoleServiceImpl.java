package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.manager.dao.RoleMapper;
import com.atguigu.atcrowdfunding.manager.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;


    @Override
    public List<Role> queryAllRole() {
        return roleMapper.selectAll();
    }



    @Override
    public void insertRolePermission(List<Integer> ins_id, Integer roleid) {
        roleMapper.insertRolePermission(ins_id, roleid);
    }

    @Override
    public void deleteAll(Integer roleid) {
        roleMapper.deleteAll(roleid);
    }

}
