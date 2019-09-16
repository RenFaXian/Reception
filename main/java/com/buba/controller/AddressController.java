package com.buba.controller;

import com.buba.bean.Address;
import com.buba.bean.User;
import com.buba.service.AddressService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("Address")
public class AddressController {

    @Autowired
    private AddressService addressService;

    @RequestMapping("findAllAddress")
    @ResponseBody
    public List<Address> findAllAddress(){
        return addressService.findAllAddress();
    }

    //添加
    @RequestMapping("myModalinsertAddress")
    @ResponseBody
    public boolean myModalinsertAddress(Address address){
        int i = addressService.myModalinsertAddress(address);
        if(i>0){
            return true;
        }
        return false;
    }

    //删除
    @RequestMapping("delAddress")
    @ResponseBody
    public boolean delAddress(Integer id){
        int i = addressService.delAddress(id);
        if(i>0){
            return true;
        }
        return false;
    }

    //修改
    @RequestMapping("updateAddress")
    @ResponseBody
    public boolean updateAddress(Integer id,String name){
        int i = addressService.updateAddress(id,name);
        if(i>0){
            return true;
        }
        return false;
    }

    //分页

    /**
     *
     * @param page 是当前页默认1
     * @param limit 每页数据默认30
     * @param id 点击的Id
     * @return
     */
    @RequestMapping("findUserByAddid")
    @ResponseBody
    public Map<String,Object> findUserByAddid(Integer page,Integer limit,Integer id){
        Map<String,Object> map = new HashMap<String,Object>();
        PageInfo<User> pageInfo = addressService.findUserByAddid(page,limit,id);

        map.put("code",0);
        map.put("message","success");
        map.put("count",pageInfo.getTotal());
        map.put("data",pageInfo.getList());
        return map;
    }
}
