package com.example.shiro.common;

import com.example.shiro.entity.Permission;
import com.example.shiro.entity.Role;
import com.example.shiro.entity.User;
import com.example.shiro.mapper.UserMapper;
import com.example.shiro.mapper.UserPermissionMapper;
import com.example.shiro.mapper.UserRoleMapper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class ShiroRealm extends AuthorizingRealm {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;
    @Autowired
    private UserPermissionMapper userPermissionMapper;

    /**
     * 获取用户角色和权限
     * 当访问到页面的时候，链接配置了相应的权限或者shiro标签才会执行此方法否则不会执行
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        String userName = user.getUserName();

        System.out.println("用户" + userName + "获取权限-----ShiroRealm.doGetAuthorizationInfo");
        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();

        // 获取用户角色
        List<Role> roleList = userRoleMapper.findByUserName(userName);
        Set<String> roleSet = new HashSet<>();
        for (Role r : roleList) {
            roleSet.add(r.getName());
        }
        simpleAuthorizationInfo.setRoles(roleSet);

        // 获取用户权限集
        List<Permission> permissionList = userPermissionMapper.findByUserName(userName);
        Set<String> permissionSet = new HashSet<String>();
        for (Permission p : permissionList) {
            permissionSet.add(p.getName());
        }
        simpleAuthorizationInfo.setStringPermissions(permissionSet);
        return simpleAuthorizationInfo;
    }

    /**
     * 登录认证
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {

        // 获取用户输入的用户名密码
        String userName = (String) authenticationToken.getPrincipal();//获取用户名，默认和login.html中的username对应。
        String password = new String((char[])authenticationToken.getCredentials());

        System.out.println("用户" + userName + "认证-----ShiroRealm.doGetAuthenticationInfo");

        // 通过用户名到数据库查询用户信息
        User user = userMapper.findByUserName(userName);

        if (user == null) {
            throw new UnknownAccountException("用户名或密码错误！");
        }
        if (!password.equals(user.getPassword())) {
            throw new IncorrectCredentialsException("用户名或密码错误！");
        }
        if (user.getStatus().equals("0")) {
            throw new LockedAccountException("账号已被锁定,请联系管理员！");
        }
        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, password, getName());
        return info;
    }
}
