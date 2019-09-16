<%--
  Created by IntelliJ IDEA.
  User: Renfaxian
  Date: 2019/9/2
  Time: 8:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上报数据</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.2.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css"/>
    <script src="${pageContext.request.contextPath}/static/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
</head>
<body>
    <div class="layui-colla-item">
        <h2 class="layui-colla-title">信息展示表</h2>
        <div class="layui-colla-content layui-show">
            <table id="demo" lay-filter="test"></table>
        </div>
    </div>

    <div id="form" style="display: none;margin-left: 150px">
        <form class="layui-form" action="" method="post">
            <%--预报数据的ID--%>
            <input type="hidden" id="predictionid" name="predictionid"/>
            <div class="container">
                <div class="layui-form-item">
                    <label class="layui-form-label">活动名称</label>
                    <div class="layui-input-block">
                        <input style="width: 230px;" type="text" id="planName" required  lay-verify="required" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">实际桌数</label>
                    <div class="layui-input-block">
                        <input style="width: 230px;" type="text" name="actualTableCount" required  lay-verify="required" placeholder="请输入请客桌数" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">新客户</label>
                    <div class="layui-input-block">
                        <input style="width: 230px;" type="text" name="newCustomers" required  lay-verify="required" placeholder="请输入新客户人数" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">旧客户</label>
                    <div class="layui-input-block">
                        <input style="width: 230px;" type="text" name="oldCustomers" required  lay-verify="required" placeholder="请输入老客户人数" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">意向客户</label>
                    <div class="layui-input-block">
                        <input style="width: 230px;" type="text" name="intentionalCustomers" required  lay-verify="required" placeholder="请输入客户人数" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">保费</label>
                    <div class="layui-input-block">
                        <input style="width: 230px;" type="text" name="premium" required  lay-verify="required" placeholder="请输入保费" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">活动时间</label>
                    <div class="layui-input-inline">
                        <input style="width: 230px;" type="text" id="date111" name="activityTime" required lay-verify="required" placeholder="请选择活动时间" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="form3" id="insertReportingData">提交</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <input type="hidden" id="reportingid"/>
    <div id="form2" style="display: none;margin-left: 150px">
        <form class="layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">图片上传</label>
                <div class="layui-input-inline">
                    <%--<input style="width: 230px;" type="file" name="activityTime" required lay-verify="required" placeholder="请选择活动时间" autocomplete="off" class="layui-input">--%>
                    <button type="button" class="layui-btn" id="test1">
                        <i class="layui-icon">&#xe67c;</i>上传图片
                    </button>

                </div>
            </div>
            <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;width:305px">
                预览图：
                <div class="layui-upload-list" id="demo2"></div>
            </blockquote>
        </form>
    </div>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="detail">上报实际数据</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    <script>
        layui.use(['table','form','layer','jquery','laydate','upload'], function(){
            var table = layui.table;
            var form = layui.form;
            var layer = layui.layer;
            var $ = layui.$;
            var laydate = layui.laydate;
            var upload = layui.upload;

            //提交实际数据的form表单
            form.on('submit(form3)',function (data) {
                $.ajax({
                    url:"${pageContext.request.contextPath}/ReportingData/insertReportingData",
                    dataType:"json",
                    data:data.field,
                    success:function (data) {
                        if(data.flag){
                            $("#reportingid").val(data.id);
                            layer.msg("添加成功！",{icon:1});
                            layer.open({
                                type: 1,
                                skin: 'layui-layer-rim', //加上边框
                                area: ['640px', '520px'], //宽高
                                content: $("#form2")
                            });

                        }else{
                            layer.msg("添加失败！",{icon: 2});
                        }
                    }
                })
                return false;
            })

            laydate.render({
                elem:'#date111'
                ,calendar:true
            })
            //第一个实例
            table.render({
                elem: '#demo'
                ,height: 312
                ,url: '${pageContext.request.contextPath}/ForecastData/findAllForecastData' //数据接口
                ,methd:'post'
                ,page: true //开启分页
                ,cols: [[ //表头
                    {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
                    ,{field: 'planName', title: '计划名称', width:100}
                    ,{field: 'planNumberTables', title: '计划桌数', width:110, sort: true}
                    ,{field: 'startTime', title: '开始时间', width:110}
                    ,{field: 'endTime', title: '结束时间', width:110}
                    ,{field: 'entryTime', title: '录入时间', width:110}
                    ,{field: '', title: '操作', width: 177 ,toolbar:'#barDemo'}
                ]]
            });

            //监听工具条
            table.on('tool(test)', function(obj){
                var data = obj.data;
                if(obj.event === 'detail'){
                    layer.msg('ID：'+ data.id + ' 的查看操作');
                    $("#planName").val(data.planName);
                    $("#predictionid").val(data.id);
                    layer.open({
                        type: 1,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['640px', '520px'], //宽高
                        content: $("#form")
                    });
                } else if(obj.event === 'del'){
                    layer.confirm('真的删除行么', function(index){
                        obj.del();
                        layer.close(index);
                    });
                }
            });
            //多图片上传
            upload.render({
                elem: '#test1'
                ,url: '${pageContext.request.contextPath}/PictureSheet/insertImage'
                ,multiple: true
                ,data:{
                    id:function () {
                        return $("#reportingid").val();
                    }
                }
                ,number:3
                ,before: function(obj){
                    //预读本地文件示例，不支持ie8
                    obj.preview(function(index, file, result){
                        $('#demo2').append('<img src="'+ result +'" alt="'+ file.name +'" class="layui-upload-img" style="width: 120px;">')
                    });
                }
                ,done: function(res){
                    //上传完毕
                    layer.msg("上传成功",{icon:1});
                    layer.closeAll();
                    $(".layui-laypage-btn")[0].click();
                }
            });



        });
    </script>

</body>
</html>
