package com.buba.service.impl;

import com.buba.bean.Address;
import com.buba.bean.ReportingData;
import com.buba.mapper.ForecastDataMapper;
import com.buba.mapper.ReportingDataMapper;
import com.buba.service.ReportingDataService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class ReportingDataServiceImpl implements ReportingDataService {

    @Autowired
    private ReportingDataMapper reportingDataMapper;

    @Autowired
    private ForecastDataMapper forecastDataMapper;

    @Transactional
    public int insertReportingData(ReportingData reportingData) {
        int i = reportingDataMapper.insertReportingData(reportingData);
        int j = forecastDataMapper.updateForecastDataByID(reportingData.getPredictionid());
        return i+j;
    }

    @Override
    public PageInfo<ReportingData> findAllByUserId(Integer id, Integer page, Integer limit) {
        PageHelper.startPage(page,limit);
        List<ReportingData> list = null;
        if(id>1){
            List<Address> addressList = reportingDataMapper.findAddressID(id);
            Address address = new Address();
            address.setId(id);
            addressList.add(address);
            List<Integer> list1 = new ArrayList<Integer>();
            for(Address a:addressList){
                list1.add(a.getId());
            }
             list = reportingDataMapper.findAllByUserId(list1);

        }else if(id==1){
            list = reportingDataMapper.findAddressAll();
        }
        for (ReportingData r :list){
            r.setImplementationRate((r.getActualTableCount()/r.getPlanTables()*100)+"%");
        }
        PageInfo<ReportingData> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public List<ReportingData> showReportingData(Integer id) {
        List<ReportingData> list = null;
        if(id>1){
            List<Address> addressList = reportingDataMapper.findAddressID(id);
            Address address = new Address();
            address.setId(id);
            addressList.add(address);
            List<Integer> list1 = new ArrayList<Integer>();
            for(Address a:addressList){
                list1.add(a.getId());
            }
            list = reportingDataMapper.findAllByUserId(list1);
        }else if(id==1){
            list = reportingDataMapper.findAddressAll();
        }
        for (ReportingData r :list){
            r.setImplementationRate((r.getActualTableCount()/r.getPlanTables()*100)+"%");
        }
       return list;

    }
}
