package com.buba.service;

import com.buba.bean.ReportingData;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface ReportingDataService {
    int insertReportingData(ReportingData reportingData);

    PageInfo<ReportingData> findAllByUserId(Integer id, Integer page, Integer limit);

    List<ReportingData> showReportingData(Integer id);
}
