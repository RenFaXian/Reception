package com.buba.service;

import com.buba.bean.User;

public interface UserService {
    User login(String codename, String password);

    int insertUser(User user);
}
