package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    Role selectByPrimaryKey(Integer id);

    List<Role> selectAll();

    int updateByPrimaryKey(Role record);



    void insertRolePermission(@Param("ins_id") List<Integer> ins_id, @Param("roleid") Integer roleid);

    void deleteAll(@Param("roleid") Integer roleid);
}