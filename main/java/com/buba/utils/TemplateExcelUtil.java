package com.buba.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class TemplateExcelUtil<T> {

    /**
     * 导出excel
     * 这是一个通用的方法，利用了JAVA的反射机制，可以将放置在JAVA集合中并且符号一定条件的数据以EXCEL 的形式输出
     * temp         模板路径
     * target       存储目标地址
     * params       表头里的参数数组
     * headersId    表格属性列名对应的javaBean字段---你需要导出的字段名（为了更灵活控制你想要导出的字段）
     *  dtoList     需要显示的数据集合,集合中一定要放置符合javabean风格的类的对象
     * 返回响应体
     */
    public  void exportExcel(String temp,String target, String[] params,List<String> headersId,
                             List<T> dtoList) {

        /*（二）字段*/
        Map<Integer, String> titleFieldMap = new HashMap<>();
        int value = 0;
        for (int i = 0; i < headersId.size(); i++) {
            if (!headersId.get(i).equals(null)) {
                titleFieldMap.put(value, headersId.get(i));//将属性字段获取存入map
                value++;
            }
        }

        /* （三）读取模板*/
        XSSFWorkbook wb = null;//创建工作簿
        File file = new File(temp);
        try {
            wb = (XSSFWorkbook) WorkbookFactory.create(new FileInputStream(file));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (InvalidFormatException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        /** 得到第一个sheet */
        XSSFSheet sheet = wb.getSheetAt(0);//获取sheet
        sheet.setDefaultColumnWidth((short)20);//设置表格默认列宽度为20个字节
        //补充标题头的参数
        XSSFRow row1 = sheet.getRow(1);//获取行
        XSSFCell cell11 = row1.getCell(0);//获取单元格
        String string11 = MessageFormat.format(cell11.getStringCellValue(), params);//获取单元格内容
        cell11.setCellValue(string11);//设置单元格内容

        XSSFRow row2 = sheet.getRow(2);//获取第二行
        XSSFCell cell20 = row2.getCell(0);//获取单元格
        String string20 = MessageFormat.format(cell20.getStringCellValue(), params);
        cell20.setCellValue(string20);//设置值

        //得到表格的样式
        XSSFCellStyle cellStyle = sheet.getRow(4).getCell(0).getCellStyle();

        XSSFRow row=null;
        XSSFCell cell=null;
        //表格标题一行的字段的集合
        Collection zdC = titleFieldMap.values();//得到属性集合
        Iterator<T> labIt = dtoList.iterator();//总记录的迭代器，得到值
        int zdRow =3;//列序号
        while (labIt.hasNext()) {//记录的迭代器，遍历总记录     使用hasNext()检查序列中是否还有元素。
            int zdCell = 0;
            zdRow++;
            row = sheet.createRow(zdRow);//循环创建行
            T l = (T) labIt.next();//使用next()获得序列中的下一个元素。
            // 利用反射，根据javabean属性的先后顺序，动态调用getXxx()方法得到属性值
            Field[] fields = l.getClass().getDeclaredFields();//获得JavaBean全部属性
            for (short i = 0; i < fields.length; i++) {//遍历属性，比对
                Field field = fields[i];
                String fieldName = field.getName();//属性名
                Iterator<String> zdIt = zdC.iterator();//一条字段的集合的迭代器
                while (zdIt.hasNext()) {//遍历要导出的字段集合
                    if (zdIt.next().equals(fieldName)) {//比对JavaBean的属性名，一致就写入，不一致就丢弃
                        String getMethodName = "get"
                                + fieldName.substring(0, 1).toUpperCase()
                                + fieldName.substring(1);//拿到属性的get方法
                        Class tCls = l.getClass();//拿到JavaBean对象
                        try {
                            Method getMethod = tCls.getMethod(getMethodName,
                                    new Class[] {});//通过JavaBean对象拿到该属性的get方法，从而进行操控
                            Object val = getMethod.invoke(l, new Object[] {});//操控该对象属性的get方法，从而拿到属性值
                            Class t = getMethod.getReturnType();
                            cell = row.createCell((short) zdCell);
                            cell.setCellStyle(cellStyle);//单元格样式
                            //根据值的类型设置单元格的值
                            switch (t.getName()) {
                                case "java.lang.Integer":
                                    if(null!=val){
                                        cell.setCellValue((Integer)val);
                                    }
                                    break;
                                case "java.util.Date":
                                    if(null!=val){
                                        Date date=(Date)val;
                                        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
                                        cell.setCellValue(sdf.format(date));
                                    }
                                    break;
                                default:
                                    cell.setCellValue(String.valueOf(val));
                                    break;
                            }
                            zdCell++;
                        } catch (SecurityException e) {
                            e.printStackTrace();
                        } catch (IllegalArgumentException e) {
                            e.printStackTrace();
                        } catch (NoSuchMethodException e) {
                            e.printStackTrace();
                        } catch (IllegalAccessException e) {
                            e.printStackTrace();
                        } catch (InvocationTargetException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        //4.存储文件
        try {
            FileOutputStream out=new FileOutputStream(target);
            wb.write(out);
            out.flush();
            out.close();
        } catch (FileNotFoundException e) {

            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * Excel读取 操作
     */
    public static List<List<String>> readExcel(InputStream is)
            throws IOException {
        Workbook wb = null;
        try {
            wb = WorkbookFactory.create(is);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (InvalidFormatException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        /** 得到第一个sheet */
        Sheet sheet = wb.getSheetAt(0);
        /** 得到Excel的行数 */
        int totalRows = sheet.getPhysicalNumberOfRows();

        /** 得到Excel的列数 */
        int totalCells = 0;
        if (totalRows >= 1 && sheet.getRow(0) != null) {
            totalCells = sheet.getRow(0).getPhysicalNumberOfCells();
        }

        List<List<String>> dataLst = new ArrayList<List<String>>();
        /** 循环Excel的行 */
        for (int r = 0; r < totalRows; r++) {
            Row row = sheet.getRow(r);
            if (row == null)
                continue;
            List<String> rowLst = new ArrayList<String>();
            /** 循环Excel的列 */
            for (int c = 0; c < totalCells; c++) {
                Cell cell = row.getCell(c);
                String cellValue = "";
                if (null != cell) {
                     /*HSSFDataFormatter hSSFDataFormatter = new HSSFDataFormatter();
                     cellValue= hSSFDataFormatter.formatCellValue(cell);*/

                    // 以下是判断数据的类型
                    CellType type = cell.getCellTypeEnum();

                    switch (type) {
                        case NUMERIC: // 数字
                            cellValue = cell.getNumericCellValue() + "";
                            break;
                        case STRING: // 字符串
                            cellValue = cell.getStringCellValue();
                            break;
                        case BOOLEAN: // Boolean
                            cellValue = cell.getBooleanCellValue() + "";
                            break;
                        case FORMULA: // 公式
                            cellValue = cell.getCellFormula() + "";
                            break;
                        case BLANK: // 空值
                            cellValue = "";
                            break;
                        case _NONE: // 故障
                            cellValue = "非法字符";
                            break;
                        default:
                            cellValue = "未知类型";
                            break;
                    }
                }
                rowLst.add(cellValue);
            }
            /** 保存第r行的第c列 */
            dataLst.add(rowLst);
        }
        return dataLst;
    }

}
