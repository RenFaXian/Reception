package com.buba.service.impl;

import com.buba.bean.ForecastData;
import com.buba.mapper.ForecastDataMapper;
import com.buba.service.ForecastDataService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ForecastDataServiceImpl implements ForecastDataService {

    @Autowired
    private ForecastDataMapper forecastDataMapper;

    @Override
    public int insertForecastData(ForecastData forecastData) {
        int i = forecastDataMapper.insertForecastData(forecastData);
        return i;
    }

    @Override
    public PageInfo<ForecastData> findAllForecastData(Integer page, Integer limit, Integer id) {
        PageHelper.startPage(page,limit);
        List<ForecastData> list = forecastDataMapper.findAllForecastData(id);
        PageInfo<ForecastData> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }
}
