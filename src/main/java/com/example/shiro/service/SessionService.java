package com.example.shiro.service;

import com.example.shiro.entity.UserOnline;

import java.util.List;

/**
 * @Description TODO
 * @Author lau
 * @Date 2019/5/10
 */
public interface SessionService {
    List<UserOnline> list();
    boolean forceLogout(String sessionId);
}
