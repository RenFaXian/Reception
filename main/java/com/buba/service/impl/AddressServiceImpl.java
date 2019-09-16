package com.buba.service.impl;

import com.buba.bean.Address;
import com.buba.bean.User;
import com.buba.mapper.AddressMapper;
import com.buba.service.AddressService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AddressServiceImpl implements AddressService {

    @Autowired
    private AddressMapper addressMapper;

    @Override
    public List<Address> findAllAddress() {
        List<Address> list = addressMapper.findAllAddress();
        for (Address address:list){
            if(address.getPid()==0){
                address.setOpen(true);
            }
        }
        return list;
    }

    @Override
    public int myModalinsertAddress(Address address) {
        int i = addressMapper.myModalinsertAddress(address);
        return i;
    }

    @Override
    public int delAddress(Integer id) {
        int i = addressMapper.delAddress(id);
        return i;
    }

    @Override
    public int updateAddress(Integer id, String name) {
        int i = addressMapper.updateAddress(id,name);
        return i;
    }

    @Override
    public PageInfo<User> findUserByAddid(Integer page, Integer limit, Integer id) {
        PageHelper.startPage(page,limit);
        List<User> list = addressMapper.findUserByAddid(id);
        PageInfo<User> userPageInfo = new PageInfo<>(list);
        return userPageInfo;
    }
}
