package com.atguigu.atcrowdfunding.interceptor;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import com.atguigu.atcrowdfunding.util.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Set;

public class AuthInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    private PermissionService permissionService;
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //查询所有许可


        Set<String> allURIS = (Set<String>) request.getSession().getServletContext().getAttribute(Const.ALL_PERMISSION_URI);


        Set<String> myURIS = (Set<String>) request.getSession().getAttribute(Const.MY_URIS);
        //判断请求路径是否在所有许可范围内
        String servletPath = request.getServletPath();
        if (allURIS.contains(servletPath)) {
            //判断请求路径是否在用户所拥有的权限内
            if (myURIS.contains(servletPath)) {
                return true;
            }
            else{
                response.sendRedirect(request.getContextPath()+"/index.htm");
                return false;
            }

        }


        return super.preHandle(request, response, handler);
    }
}
