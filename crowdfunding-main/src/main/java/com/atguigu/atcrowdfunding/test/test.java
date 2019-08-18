package com.atguigu.atcrowdfunding.test;


import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.dao.UserMapper;
import com.atguigu.atcrowdfunding.util.MD5Util;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import java.util.logging.SimpleFormatter;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/spring-context.xml"})
public class test {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private SqlSession sqlSession;

    @Test
    public void testcrud() {

        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
            String uid2= UUID.randomUUID().toString().substring(0, 5)+i;
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss" );
            String time=sf.format(new Date());
            String password = MD5Util.digest("123456");
            User user = new User(null,uid,password,uid2,uid+"@qq.com",time);
           userMapper.insert(user);

        }



    }

}
