package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    User queryUserlogin(Map<String, Object> paramMap);

    List<User> queryUsers(String queryText);

    void saveUser(User user);

    void deleteUser(Integer ids);

    void updateUser(User user);


    void deleteUserBatch(List<Integer> del_id);

    List<Role> queryAllRole();

    List<Role> queryRoleByUserId(Integer id);

    void saveUserRole(Integer userid, List<Integer> save_ids);

    void deleteUserRole(Integer userid, List<Integer> del_ids);

    List<Permission> queryPermissionByUserId(Integer id);
}

