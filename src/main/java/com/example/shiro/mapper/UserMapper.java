package com.example.shiro.mapper;

import com.example.shiro.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    User findByUserName(@Param("userName") String userName);
}
