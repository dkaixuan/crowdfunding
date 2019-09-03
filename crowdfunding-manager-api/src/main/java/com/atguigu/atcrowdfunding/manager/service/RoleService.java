package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Role;
import org.springframework.stereotype.Service;

import java.util.List;

public interface RoleService {

    List<Role> queryAllRole();
    
    void insertRolePermission(List<Integer> ins_id, Integer roleid);

    void deleteAll(Integer roleid);
}
