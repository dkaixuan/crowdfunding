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
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext servletContext = sce.getServletContext();
        String contextPath = servletContext.getContextPath();
        servletContext.setAttribute("APP_PATH", contextPath);

        //加载所有许可路径
        ApplicationContext ioc = WebApplicationContextUtils.getWebApplicationContext(servletContext);
        PermissionService permissionService = ioc.getBean(PermissionService.class);

        List<Permission> permissions = permissionService.queryAllPermission();
        Set<String> allURIS = new HashSet<>();
        for (Permission permission : permissions) {
            allURIS.add("/"+permission.getUrl());
        }
        servletContext.setAttribute(Const.ALL_PERMISSION_URI,allURIS);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        ServletContext servletContext = servletContextEvent.getServletContext();
        servletContext.removeAttribute("APP_PATH");
    }
}
