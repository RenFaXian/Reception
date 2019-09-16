package com.buba.mapper;

import com.buba.bean.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {

    //登陆
    User login(@Param("codename") String codename,@Param("password") String password);

    //添加用户
    int insertUser(User user);
}
