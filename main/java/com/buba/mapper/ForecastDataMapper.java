package com.buba.mapper;

import com.buba.bean.ForecastData;

import java.util.List;

public interface ForecastDataMapper {

    //添加预报数据信息
    int insertForecastData(ForecastData forecastData);

    //查询userid下的所有的预报信息
    List<ForecastData> findAllForecastData(Integer id);

    //根据ID修改status状态
    int updateForecastDataByID(Integer predictionid);
}
