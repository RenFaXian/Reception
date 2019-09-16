package com.buba.bean;


public class User {

  private Integer id;
  private String name;
  private String codename;
  private String password;
  private Integer userlevel;
  private Integer addid;

  public Integer getAddid() {
    return addid;
  }

  public void setAddid(Integer addid) {
    this.addid = addid;
  }

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getCodename() {
    return codename;
  }

  public void setCodename(String codename) {
    this.codename = codename;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public Integer getUserlevel() {
    return userlevel;
  }

  public void setUserlevel(Integer userlevel) {
    this.userlevel = userlevel;
  }
}
