<%--
  Created by IntelliJ IDEA.
  User: Renfaxian
  Date: 2019/9/3
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看数据吧</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.2.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css"/>
    <script src="${pageContext.request.contextPath}/static/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/static/echarts/echarts.min.js"></script>
    <script type="text/javascript">
        $(function () {
            showViewBing();
            showViewBing2();
        })
        function showViewBing2() {
            $.ajax({
                url:"${pageContext.request.contextPath}/ReportingData/showReportingData",
                dataType:"json",
                success:function (data) {
                    var myChart = echarts.init(document.getElementById("main2"));
                    var sData = [];
                    for (var i = 0; i < data.length; i++) {
                        sData.push({value: data[i].premium, name: data[i].addressName});
                    }

                    console.log(sData);
                     var option = {
                        title:{
                            text:"汇总数据统计",
                            x:"center"
                        },
                        tooltip:{
                            trigger:'item',
                            //饼图: {a}（系列名称），{b}（数据项名称/类目值），{c}（数值）, {d}（百分比）
                            formatter:"{a} <br/>{b} : {c}万元 ({d}%)"
                        },legend: {
                            orient: 'vertical',
                            left: 'left',
                            data: sData
                        },

                        series:{
                            type:"pie",
                            //半径([内半径，外半径])，写一个是圆，写两个是空心圆
                            radius:"80%",
                            //圆心   其实就是一个定位，根据xy轴定位
                            center:["50%","55%"],
                            data:sData
                        }
                    };
                    myChart.setOption(option,true);
                }
            })
        }
        function showViewBing() {
            $.ajax({
                url:"${pageContext.request.contextPath}/ReportingData/showReportingData",
                dataType:"json",
                success:function (data) {
                    var myChart = echarts.init(document.getElementById("main"));
                    var sData = [];
                    for(var i=0;i<data.length;i++){
                        sData.push({value:data[i].premium,name:data[i].addressName});
                    }

                    console.log(sData);

                    $.get("/static/HE.json", function (geoJson) {

                        myChart.hideLoading();

                        echarts.registerMap('HE', geoJson);

                        myChart.setOption(option = {
                            title: {
                                text: '河北省太平洋保险',
                                sublink: 'http://zh.wikipedia.org/wiki/%E9%A6%99%E6%B8%AF%E8%A1%8C%E6%94%BF%E5%8D%80%E5%8A%83#cite_note-12'
                            },
                            tooltip: {
                                trigger: 'item',
                                formatter: '{b}<br/>{c} (p / km2)'
                            },
                            toolbox: {
                                show: true,
                                orient: 'vertical',
                                left: 'right',
                                top: 'center',
                                feature: {
                                    dataView: {readOnly: false},
                                    restore: {},
                                    saveAsImage: {}
                                }
                            },
                            visualMap: {
                                min: 800,
                                max: 50000,
                                text:['High','Low'],
                                realtime: false,
                                calculable: true,
                                inRange: {
                                    color: ['lightskyblue','yellow', 'orangered']
                                }
                            },
                            series: [
                                {
                                    name: '河北省太平洋保险',
                                    type: 'map',
                                    mapType: 'HE', // 自定义扩展图表类型
                                    itemStyle:{
                                        normal:{label:{show:true}},
                                        emphasis:{label:{show:true}}
                                    },
                                    data:sData,
                                }
                            ]
                        });
                    });
                }
            })
        }

    </script>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title">
        <li class="layui-this">统计图</li>
        <li>详细列表信息</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show layui-row">
            <div class="layui-col-md6" id="main" style="height: 300px;width:400px;"></div>
            <div class="layui-col-md6" id="main2" style="height: 300px;width:400px;"></div>
        </div>
        <div class="layui-tab-item">
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">信息展示表</h2>
                <div class="layui-colla-content layui-show">
                    <table id="demo" lay-filter="test"></table>
                    <button class="layui-btn layui-btn-radius layui-btn-warm" onclick="daochu()">导出数据</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    layui.use(['element','layer','table'],function () {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,url: '${pageContext.request.contextPath}/ReportingData/findAllByUserId' //数据接口
            ,methd:'post'
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
                ,{field: 'addressName', title: '机构名称', width:100}
                ,{field: 'planTables', title: '计划召开桌数', width:110, sort: true}
                ,{field: 'actualTableCount', title: '实际召开桌数', width:110}
                ,{field: 'implementationRate', title: '执行率', width:110}
                ,{field: 'newCustomers', title: '新客户', width:110}
                ,{field: 'oldCustomers', title: '老客户', width:110}
                ,{field: 'intentionalCustomers', title: '意向客户', width:110}
                ,{field: 'premium', title: '预估保费（万元）', width:110}
            ]]
        });
    })

    function daochu() {
        $.ajax({
            url:"${pageContext.request.contextPath}/ReportingData/outputExcel",
            dataType:"json",
            success:function (data) {
                if(data){
                    layer.msg("导出成功",{icon:1});
                }
            }
        })
    }
</script>
</body>
</html>
