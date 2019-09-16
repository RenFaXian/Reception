package com.buba.service.impl;

import com.buba.bean.User;
import com.buba.mapper.UserMapper;
import com.buba.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(String codename, String password) {
        return userMapper.login(codename,password);
    }

    @Override
    public int insertUser(User user) {
        int i = userMapper.insertUser(user);
        return i;
    }
}
