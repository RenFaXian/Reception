<%--
  Created by IntelliJ IDEA.
  User: Renfaxian
  Date: 2019/8/28
  Time: 19:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>主页面</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.2.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree/css/zTreeStyle/zTreeStyle.css"/>

    <script src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.core.js"></script>
    <script src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.all.js"></script>
    <script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
</head>
<body>
<input class="layui-hide" id="level" value="${user.userlevel}"/>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">太平洋保险</div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    欢迎${user.name}登陆
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                    <dd><a href="${pageContext.request.contextPath}/User/signout">退出</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                    <li class="layui-nav-item"><a href="javascript:;" onclick="show(this)"><i class="layui-icon layui-icon-ok" style="color: #00FF00"></i><span>查看数据</span></a></li>
                <c:if test="${user.userlevel==1}">
                    <li class="layui-nav-item"><a href="javascript:;" onclick="jigou(this)"><i class="layui-icon layui-icon-add-circle" style="color: #00FF00"></i><span>机构管理</span></a></li>
                </c:if>
                <c:if test="${user.userlevel==1||user.userlevel==2}">
                    <li class="layui-nav-item"><a href="javascript:;" onclick="guanli(this)"><i class="layui-icon layui-icon-add-circle" style="color: #00FF00"></i><span>用户管理</span></a></li>
                </c:if>
                <c:if test="${user.userlevel==2||user.userlevel==3}">
                <li class="layui-nav-item"><a href="javascript:;" onclick="yubao(this)"><i class="layui-icon layui-icon-table" style="color: #009E94"></i><span>预报数据</span></a></li>
                <li class="layui-nav-item"><a href="javascript:;" onclick="shangbao(this)"><i class="layui-icon layui-icon-upload-circle" style="color: #009E94"></i><span>上报数据</span></a></li>
                </c:if>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div class="layui-card" style="padding: 15px;height: 400px" >
            <div class="layui-colla-item">
                <h2 class="layui-colla-title"></h2>
                <div class="layui-colla-content layui-show" style="height: 100%">
                    <%--<iframe style="width: 100%; min-height: 100%;" scrolling="no" frameborder="no" id="iframe" src=""></iframe>--%>
                </div>
            </div>

        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        @ CopyRight 2019 太平洋保险河北分公司
    </div>
</div>
<script>
    //JavaScript代码区域
    layui.use(['element','jquery','tree','layer'], function(){
        var element = layui.element;
        var $ = layui.jquery;
        var tre = layui.tree;
        var layer = layui.layer;
        //判断是否有值或者判断是否session销毁，如果有就返回登陆页面
        $("#level").val()==""?window.location.href="${pageContext.request.contextPath}/jsps/login.jsp":""

    });
    //查看数据
    function show(obj) {
        $(".layui-colla-title").html($(obj).children("span").text());
        layer.open({
            type: 2,
            title: false,
            closeBtn: 0, //不显示关闭按钮
            shade: [0],
            area: ['340px', '215px'],
            offset: 'rb', //右下角弹出
            time: 2000, //2秒后自动关闭
            anim: 2,
            content: ['${pageContext.request.contextPath}/jsps/show.jsp', 'no'], //iframe的url，no代表不显示滚动条
            end: function(){ //此处用于演示
                layer.open({
                    type: 2,
                    title: $(obj).children("span").text(),
                    shadeClose: true,
                    shade: false,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['1000px', '600px'],
                    content: '${pageContext.request.contextPath}/jsps/show.jsp'
                });
            }
        });
    }
    //机构管理
    function jigou(obj) {
        $(".layui-colla-title").html($(obj).children("span").text());
        //$("#iframe").attr("src","${pageContext.request.contextPath}/jsps/jigou.jsp");
        layer.open({
            type: 2,
            title: false,
            closeBtn: 0, //不显示关闭按钮
            shade: [0],
            area: ['340px', '215px'],
            offset: 'rb', //右下角弹出
            time: 2000, //2秒后自动关闭
            anim: 2,
            content: ['${pageContext.request.contextPath}/jsps/jigou.jsp', 'no'], //iframe的url，no代表不显示滚动条
            end: function(){ //此处用于演示
                layer.open({
                    type: 2,
                    title: $(obj).children("span").text(),
                    shadeClose: true,
                    shade: false,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['893px', '600px'],
                    content: '${pageContext.request.contextPath}/jsps/jigou.jsp'
                });
            }
        });
    }
    //用户管理,javascript不能带对象
    function guanli(a) {
        $(".layui-colla-title").html($(a).children("span").text());
        layer.open({
            type: 2,
            title: false,
            closeBtn: 0, //不显示关闭按钮
            shade: [0],
            area: ['340px', '215px'],
            offset: 'rb', //右下角弹出
            time: 2000, //2秒后自动关闭
            anim: 2,
            content: ['${pageContext.request.contextPath}/jsps/userguanli.jsp', 'no'], //iframe的url，no代表不显示滚动条
            end: function(){ //此处用于演示
                layer.open({
                    type: 2,
                    title: $(a).children("span").text(),
                    shadeClose: true,
                    shade: false,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['1000px', '600px'],
                    content: '${pageContext.request.contextPath}/jsps/userguanli.jsp'
                });
            }
        });
    }
    //预报数据
    function yubao(obj) {
        $(".layui-colla-title").html($(obj).children("span").text());
        layer.open({
            type: 2,
            title: false,
            closeBtn: 0, //不显示关闭按钮
            shade: [0],
            area: ['340px', '215px'],
            offset: 'rb', //右下角弹出
            time: 2000, //2秒后自动关闭
            anim: 2,
            content: ['${pageContext.request.contextPath}/jsps/forecastdata.jsp', 'no'], //iframe的url，no代表不显示滚动条
            end: function(){ //此处用于演示
                layer.open({
                    type: 2,
                    title: $(obj).children("span").text(),
                    shadeClose: true,
                    shade: false,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['1000px', '600px'],
                    content: '${pageContext.request.contextPath}/jsps/forecastdata.jsp'
                });
            }
        });
    }
    //上报数据
    function shangbao(obj) {
        $(".layui-colla-title").html($(obj).children("span").text());
        layer.open({
            type: 2,
            title: false,
            closeBtn: 0, //不显示关闭按钮
            shade: [0],
            area: ['340px', '215px'],
            offset: 'rb', //右下角弹出
            time: 2000, //2秒后自动关闭
            anim: 2,
            content: ['${pageContext.request.contextPath}/jsps/reportingdata.jsp', 'no'], //iframe的url，no代表不显示滚动条
            end: function(){ //此处用于演示
                layer.open({
                    type: 2,
                    title: $(obj).children("span").text(),
                    shadeClose: true,
                    shade: false,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['1000px', '600px'],
                    content: '${pageContext.request.contextPath}/jsps/reportingdata.jsp'
                });
            }
        });
    }
</script>
</body>
</html>
