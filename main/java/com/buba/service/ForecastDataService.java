package com.buba.service;

import com.buba.bean.ForecastData;
import com.github.pagehelper.PageInfo;

public interface ForecastDataService {

    //添加预报数据
    int insertForecastData(ForecastData forecastData);

    PageInfo<ForecastData> findAllForecastData(Integer page, Integer limit, Integer id);
}
