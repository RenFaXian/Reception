package com.buba.controller;

import com.buba.bean.ForecastData;
import com.buba.bean.User;
import com.buba.service.ForecastDataService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("ForecastData")
public class ForecastDataController {

    @Autowired
    private ForecastDataService forecastDataService;

    //添加预报数据
    @RequestMapping("insertForecastData")
    @ResponseBody
    public boolean insertForecastData(ForecastData forecastData, HttpSession session){
        User user = (User) session.getAttribute("user");
        forecastData.setUserid(user.getId());
        int i = forecastDataService.insertForecastData(forecastData);
        if(i>0){
            return true;
        }
        return false;
    }

    //查找所有的预报数据
    @RequestMapping("findAllForecastData")
    @ResponseBody
    public Map<String,Object> findAllForecastData(Integer page,Integer limit,HttpSession session){
        Map<String,Object> map = new HashMap<String,Object>();
        User user = (User) session.getAttribute("user");
        PageInfo<ForecastData> pageInfo = forecastDataService.findAllForecastData(page,limit,user.getId());
        map.put("code",0);
        map.put("message","success");
        map.put("count",pageInfo.getTotal());
        map.put("data",pageInfo.getList());
        return map;
    }
}
