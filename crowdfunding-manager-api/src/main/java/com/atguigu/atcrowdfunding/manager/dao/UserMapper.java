package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    User selectByPrimaryKey(Integer id);

    List<User> queryUsers(String queryText);

    int updateByPrimaryKey(User record);

    User queryUserlogin(Map<String, Object> paramMap);

    void deleteUserBatch(@Param("del_id") List<Integer> del_id);

    List<Role> queryAllRole();

    List<Role> queryRoleByUserId(@Param("id") Integer id);


    void saveUserRole(@Param("userid") Integer userid, @Param("ids") List<Integer> save_ids);

    void deleteUserRole(@Param("userid")Integer userid, @Param("ids")List<Integer> del_ids);

    List<Permission> queryPermissionByUserId(@Param("id") Integer id);
}