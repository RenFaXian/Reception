package com.buba.controller;

import com.buba.bean.ReportingData;
import com.buba.bean.User;
import com.buba.service.ReportingDataService;
import com.buba.utils.Headerid;
import com.buba.utils.TemplateExcelUtil;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("ReportingData")
public class ReportingDataController {

    @Autowired
    private ReportingDataService reportingDataService;

    //添加实际上报数据和图片上传
    @RequestMapping("insertReportingData")
    @ResponseBody
    public Map<String,Object> insertReportingData(ReportingData reportingData, HttpSession session){
        User user = (User) session.getAttribute("user");
        reportingData.setUserid(user.getId());
        int i = reportingDataService.insertReportingData(reportingData);
        System.out.println(reportingData.getId());
        Map<String,Object> map = new HashMap<>();
        if(i>0){
            map.put("flag",true);
            map.put("id",reportingData.getId());
        }else{
            map.put("flag",false);
        }
        return map;
    }

    //查看登陆user的所有数据及其下面的所有信息
    @RequestMapping("findAllByUserId")
    @ResponseBody
    public Map<String,Object> findAllByUserId(HttpSession session,Integer page,Integer limit){
        User user = (User) session.getAttribute("user");
        PageInfo<ReportingData> pageInfo = reportingDataService.findAllByUserId(user.getId(),page,limit);

        Map<String,Object> map = new HashMap<>();
        map.put("code",0);
        map.put("message","success");
        map.put("count",pageInfo.getTotal());
        map.put("data",pageInfo.getList());
        return map;
    }

    //查看登陆user的所有数据及其下面的所有信息
    @RequestMapping("showReportingData")
    @ResponseBody
    public List<ReportingData> showReportingData(HttpSession session){
        User user = (User) session.getAttribute("user");
        List<ReportingData> list = reportingDataService.showReportingData(user.getId());
        return list;
    }

    @RequestMapping("outputExcel")
    @ResponseBody
    public boolean outputExcel(HttpSession session){
        try {
            User user = (User) session.getAttribute("user");
            List<ReportingData> list = reportingDataService.showReportingData(user.getId());
            //模板位置
            String temp = "testData.xlsx";
            temp = session.getServletContext().getRealPath("Excel")+File.separator+temp;
            //目标路径
            String target = "E:\\河北省太平洋保险数据"+System.currentTimeMillis()+".xlsx";
            //获取第一个ID
            Integer qian = list.get(0).getId();
            //获取最后一个ID
            Integer hou = list.get(list.size()-1).getId();
            String allName =user.getName();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date d = new Date();
            //根据表的格式来给他取的值固定位置
            String[] params = {"",sdf.format(d),allName,""};
            /*ArrayList<String> headersId = (ArrayList<String>) new Headerid().getHeaderid(new ReportingData());*/
            ArrayList<String> headersId = new ArrayList<>();
            headersId.add("id");
            headersId.add("actualTableCount");
            headersId.add("newCustomers");
            headersId.add("oldCustomers");
            headersId.add("intentionalCustomers");
            headersId.add("premium");
            headersId.add("addressName");
            headersId.add("planTables");
            headersId.add("implementationRate");
            TemplateExcelUtil util = new TemplateExcelUtil<>();
            //调用工具类方法
            util.exportExcel(temp, target, params, headersId, list);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
