package com.buba.service;

import com.buba.bean.Address;
import com.buba.bean.User;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface AddressService {


    List<Address> findAllAddress();

    int myModalinsertAddress(Address address);

    int delAddress(Integer id);

    int updateAddress(Integer id, String name);

    PageInfo<User> findUserByAddid(Integer page, Integer limit, Integer id);
}
