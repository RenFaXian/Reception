package com.buba.utils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

public class Headerid {

	public List<String> getHeaderid(Object obj){

		ArrayList<String> list = new ArrayList<String>();

		//获取Class对象
		Class clazz = obj.getClass();

		//获取所有的属性
		Field[] fields = clazz.getDeclaredFields();

		for(int i = 0 ; i < fields.length ; i ++) {
			list.add(fields[i].getName());
		}
		return list;
	}
}
