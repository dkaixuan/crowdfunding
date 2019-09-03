package com.atguigu.atcrowdfunding.interceptor;
import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.util.Const;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.Set;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //1。定义那些路径不需要拦截（白名单）
        Set<String> uri = new HashSet<>();
        uri.add("/user/reg.do");
        uri.add("/login.htm");
        uri.add("/main.htm");
        uri.add("/doLogin.do");
        uri.add("/logout.do");
        uri.add("/index.htm");
        uri.add("/member.htm");
        uri.add("/member/accttype.htm");
        //获取请求路径

        String servletPath=request.getServletPath();
        if (uri.contains(servletPath)) {
            return true;
        }



        HttpSession session = request.getSession();
        User user= (User) session.getAttribute(Const.LOGIN_USER);
        if (user != null) {
            return true;
        }
        Member member= (Member) session.getAttribute(Const.LOGIN_MEMBER);

        if (member != null) {
            return true;
        }

        else{
            response.sendRedirect(request.getContextPath()+ "/login.htm");
            return false;
        }

        }

}
