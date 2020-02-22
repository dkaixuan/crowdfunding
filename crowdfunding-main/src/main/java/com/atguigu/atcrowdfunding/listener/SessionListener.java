package com.atguigu.atcrowdfunding.listener;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * @author kaixuan
 * @version 1.0
 * @date 2020/2/16 10:36
 */
public class SessionListener implements HttpSessionListener {

    public static int TOTAL_ONLINE_USERS=0;


    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {

        ServletContext servletContext = httpSessionEvent.getSession().getServletContext();
        servletContext.setAttribute("TOTAL_ONLINE_USERS", TOTAL_ONLINE_USERS);

        TOTAL_ONLINE_USERS = (Integer) servletContext.getAttribute("TOTAL_ONLINE_USERS");
        TOTAL_ONLINE_USERS++;


    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        ServletContext servletContext = httpSessionEvent.getSession().getServletContext();
        TOTAL_ONLINE_USERS = (Integer) servletContext.getAttribute("TOTAL_ONLINE_USERS");

        TOTAL_ONLINE_USERS--;
        servletContext.setAttribute("TOTAL_ONLINE_USERS", TOTAL_ONLINE_USERS);

    }
}
