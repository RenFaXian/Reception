package com.buba.service.impl;

import com.buba.bean.PictureSheet;
import com.buba.mapper.PictureSheetMapper;
import com.buba.service.PictureSheetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PictureSheetServiceImpl implements PictureSheetService {


    @Autowired
    private PictureSheetMapper pictureSheetMapper;

    @Override
    public int insertImage(PictureSheet pictureSheet) {
        int i = pictureSheetMapper.insertImage(pictureSheet);
        return i;
    }
}
