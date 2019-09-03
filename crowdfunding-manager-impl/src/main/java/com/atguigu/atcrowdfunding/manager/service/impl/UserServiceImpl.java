package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.dao.UserMapper;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.atguigu.atcrowdfunding.util.exception.LoginFailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;


    @Override
    public User queryUserlogin(Map<String, Object> paramMap) {
        User user = userMapper.queryUserlogin(paramMap);
        if (user == null) {
            throw new LoginFailException("用户账号或密码不正确");
        }
        return user;
    }

    @Override
    public List<User> queryUsers(String queryText) {

        return userMapper.queryUsers(queryText);
    }

    @Override
    public void saveUser(User user) {
        User users = new User();
        users.setLoginacct(user.getLoginacct());
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh-mm-s");
        String date=sf.format(new Date());
        users.setCreatetime(date);
        users.setUsername(user.getUsername());
        users.setEmail(user.getEmail());
        users.setUserpswd(MD5Util.digest(Const.PASSWORD));
        userMapper.insert(users);
    }

    @Override
    public void deleteUser(Integer ids) {
        userMapper.deleteByPrimaryKey(ids);
    }

    @Override
    public void updateUser(User user) {
        userMapper.updateByPrimaryKey(user);
    }

    @Override
    public void deleteUserBatch(List<Integer> del_id) {
        userMapper.deleteUserBatch(del_id);
    }

    @Override
    public List<Role> queryAllRole() {
        return userMapper.queryAllRole();
    }

    @Override
    public List<Role> queryRoleByUserId(Integer id) {
        return userMapper.queryRoleByUserId(id);
    }

    @Override
    public void saveUserRole(Integer userid, List<Integer> save_ids) {
        userMapper.saveUserRole(userid, save_ids);
    }

    @Override
    public void deleteUserRole(Integer userid, List<Integer> del_ids) {
        userMapper.deleteUserRole(userid, del_ids);
    }

    @Override
    public List<Permission> queryPermissionByUserId(Integer id) {
        return userMapper.queryPermissionByUserId(id);
    }


}
