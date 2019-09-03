package com.atguigu.atcrowdfunding.listener;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import com.atguigu.atcrowdfunding.util.Const;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class StartSystemListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext application = servletContextEvent.getServletContext();
        String contextPath = application.getContextPath();
        application.setAttribute("APP_PATH",contextPath);

        //加载所有许可路径

        ApplicationContext ioc = WebApplicationContextUtils.getWebApplicationContext(application);
        PermissionService permissionService = ioc.getBean(PermissionService.class);

        List<Permission> permissions = permissionService.queryAllPermission();
        Set<String> allURIS = new HashSet<>();
        for (Permission permission : permissions) {
            allURIS.add("/"+permission.getUrl());
        }
        application.setAttribute(Const.ALL_PERMISSION_URI,allURIS);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
