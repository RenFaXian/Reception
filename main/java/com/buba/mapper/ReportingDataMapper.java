package com.buba.mapper;

import com.buba.bean.Address;
import com.buba.bean.ReportingData;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReportingDataMapper {


    int insertReportingData(ReportingData reportingData);

    List<Address> findAddressID(Integer id);


    List<ReportingData> findAllByUserId(@Param("list1") List<Integer> list1);

    List<ReportingData> findAddressAll();

}
