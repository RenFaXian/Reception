package com.buba.bean;


import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class ReportingData {

  private Integer id;
  private Integer actualTableCount;//实际桌数
  private Integer newCustomers;//新客户人数
  private Integer oldCustomers;//老客户人数
  private Integer intentionalCustomers;//意向客户人数
  private double premium;//保费
  @JsonFormat(pattern = "yyyy-MM-dd")
  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private Date activityTime;//活动时间
  private Integer userid;//userid的外键
  private Integer predictionid;//预报表的id

  private String addressName;//机构名称
  private Integer planTables;//计划召开桌数
  private String implementationRate;//执行率

  public String getAddressName() {
    return addressName;
  }

  public void setAddressName(String addressName) {
    this.addressName = addressName;
  }

  public Integer getPlanTables() {
    return planTables;
  }

  public void setPlanTables(Integer planTables) {
    this.planTables = planTables;
  }

  public String getImplementationRate() {
    return implementationRate;
  }

  public void setImplementationRate(String implementationRate) {
    this.implementationRate = implementationRate;
  }

  public Integer getPredictionid() {
    return predictionid;
  }

  public void setPredictionid(Integer predictionid) {
    this.predictionid = predictionid;
  }

  public Integer getUserid() {
    return userid;
  }

  public void setUserid(Integer userid) {
    this.userid = userid;
  }

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public Integer getActualTableCount() {
    return actualTableCount;
  }

  public void setActualTableCount(Integer actualTableCount) {
    this.actualTableCount = actualTableCount;
  }

  public Integer getNewCustomers() {
    return newCustomers;
  }

  public void setNewCustomers(Integer newCustomers) {
    this.newCustomers = newCustomers;
  }

  public Integer getOldCustomers() {
    return oldCustomers;
  }

  public void setOldCustomers(Integer oldCustomers) {
    this.oldCustomers = oldCustomers;
  }

  public Integer getIntentionalCustomers() {
    return intentionalCustomers;
  }

  public void setIntentionalCustomers(Integer intentionalCustomers) {
    this.intentionalCustomers = intentionalCustomers;
  }

  public double getPremium() {
    return premium;
  }

  public void setPremium(double premium) {
    this.premium = premium;
  }

  public Date getActivityTime() {
    return activityTime;
  }

  public void setActivityTime(Date activityTime) {
    this.activityTime = activityTime;
  }
}
