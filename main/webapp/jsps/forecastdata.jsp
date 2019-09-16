<%--
  Created by IntelliJ IDEA.
  User: Renfaxian
  Date: 2019/8/30
  Time: 17:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>预报数据</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.2.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css"/>
    <script src="${pageContext.request.contextPath}/static/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
</head>
<body>
    <div class="layui-colla-item">
        <h2 class="layui-colla-title">信息展示表</h2>
        <div class="layui-colla-content layui-show">
            <form class="layui-form" action="" method="post" id="addform">
                <div class="container">
                    <div class="layui-form-item">
                        <label class="layui-form-label">计划名称</label>
                        <div class="layui-input-block">
                            <input type="hidden" id="Plevel" name="level">
                            <input type="hidden" id="Pid" name="pid">
                            <input style="width: 230px;" type="text" name="planName" required  lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">计划召开桌数</label>
                        <div class="layui-input-inline">
                            <input style="width: 230px;" type="text" name="planNumberTables" required lay-verify="required" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">开始时间</label>
                        <div class="layui-input-inline">
                            <input style="width: 230px;" type="text" id="date" name="startTime" required lay-verify="required" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">结束时间</label>
                        <div class="layui-input-inline">
                            <input style="width: 230px;" type="text" id="date2" name="endTime" required lay-verify="required" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit lay-filter="form2">提交</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
        layui.use(['form','layer','laydate'],function () {
            var form = layui.form;
            var layer = layui.layer;
            var laydate = layui.laydate;

            //带公历节日的用法
            laydate.render({
                elem: '#date'
                ,calendar: true
            });
            laydate.render({
                elem: '#date2'
                ,calendar: true
            });

            form.on('submit(form2)',function (data) {
                $.ajax({
                    url:"${pageContext.request.contextPath}/ForecastData/insertForecastData",
                    dataType:"json",
                    data:data.field,
                    success:function (data) {
                        if(data){
                            layer.msg("添加成功！",{icon:1});
                            $("#addform")[0].reset();
                        }else{
                            layer.msg("添加失败！",{icon: 2});
                        }
                    }
                })
                return false;
            })
        })
    </script>
</body>
</html>
