package com.atguigu.atcrowdfunding.manager.dao;


import com.atguigu.atcrowdfunding.bean.Permission;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PermissionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Permission record);

    Permission selectByPrimaryKey(Integer id);

    List<Permission> selectAll();

    int updateByPrimaryKey(Permission record);

    Permission getRootPermission();

    List<Permission> getChildrenPermission(Integer id);

    List<Permission> queryAllPermission();

    void savePermission(Permission permission);


    List<Integer> queryPermissionIdsRoleid(@Param("roleid") Integer roleid);
}