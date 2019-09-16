package com.buba.controller;

import com.buba.bean.PictureSheet;
import com.buba.service.PictureSheetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
@RequestMapping("PictureSheet")
public class PictureSheetController {

    @Autowired
    private PictureSheetService pictureSheetService;

    @Value("${member.reportPath}")
    private String reportPath;

    @RequestMapping("insertImage")
    @ResponseBody
    public boolean insertImage(MultipartFile file, Integer id){
        File imgPath = new File(reportPath);
        if(!imgPath.isDirectory()){
            imgPath.mkdirs();
        }
        //新名字
        String newName = UUID.randomUUID().toString().toUpperCase().replace("-", "");

        try {
            file.transferTo(new File(reportPath+File.separator+newName+".jpg"));
        } catch (IOException e) {
            e.printStackTrace();
        }

        PictureSheet pictureSheet = new PictureSheet();
        pictureSheet.setAlbumName(newName);
        pictureSheet.setActivityid(id);
        int i = pictureSheetService.insertImage(pictureSheet);
        if(i>0){
            return true;
        }
        return false;
    }
}
