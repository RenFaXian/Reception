package com.buba.mapper;

import com.buba.bean.Address;
import com.buba.bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AddressMapper {

    //查询所有的address表
    List<Address> findAllAddress();

    //添加节点信息
    int myModalinsertAddress(Address address);

    //删除信息
    int delAddress(Integer id);

    //修改信息
    int updateAddress(@Param("id") Integer id,@Param("name") String name);

    //查询父节点下面的所有的user用户
    List<User> findUserByAddid(Integer id);
}
