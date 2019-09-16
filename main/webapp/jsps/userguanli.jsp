<%--
  Created by IntelliJ IDEA.
  User: Renfaxian
  Date: 2019/8/30
  Time: 9:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.2.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree/css/zTreeStyle/zTreeStyle.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css"/>
    <script src="${pageContext.request.contextPath}/static/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.core.js"></script>
    <script src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.all.js"></script>
    <script>
        var addressId = 100;
        var addlevel = 100;
        var setting = {
            data:{
                simpleData:{
                    enable:true,
                    idKey:"id",
                    pIdKey:"pid",
                    rootPId:0
                }
            },callback:{
                onClick:ztreeOnClick
            },async:{
                enable:true,
                url:"${pageContext.request.contextPath}/Address/findAllAddress",
                type:"post"
            }
        }
        $(function () {
            $.fn.zTree.init($("#address"), setting);
        })

        function ztreeOnClick(event,treeId,treeNode){
            //把点击的地址ID赋值给他
            addressId = treeNode.id;
            addlevel = treeNode.level+1;
            console.log(addressId);
            layui.use('table', function(){
                var table = layui.table;

                //第一个实例
                table.render({
                    elem: '#demo'
                    ,height: 312
                    ,url: '${pageContext.request.contextPath}/Address/findUserByAddid' //数据接口
                    ,methd:'post'
                    ,where:{id:addressId}
                    ,page: true //开启分页
                    ,cols: [[ //表头
                        {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
                        ,{field: 'name', title: '名称', width:80}
                        ,{field: 'codename', title: 'code信息', width:80, sort: true}
                        ,{field: 'userlevel', title: '级别', width:80}
                        ,{field: '', title: '操作', width: 177 ,toolbar:'#barDemo'}
                    ]]
                });

            });

        }

        function insertUser() {
            if($("#userlevel").val()>=addlevel){
                layer.msg("你的权限不够！",{icon:2});
            }else{
                $("#Pid").val(addressId);
                $("#Plevel").val(addlevel);
                layer.open({
                    type: 1,
                    skin: 'layui-layer-rim', //加上边框
                    area: ['420px', '240px'], //宽高
                    content: $("#form")
                });
            }
        }
    </script>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
</head>
<body>
    <input type="hidden" id="userlevel" value="${user.userlevel}"/>
    <div class="layui-row">
        <div class="layui-col-md4">
            <ul class="ztree" id="address"></ul>
        </div>
        <div class="layui-col-md8">
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">信息展示表</h2>
                <div class="layui-colla-content layui-show">
                    <table id="demo" lay-filter="test"></table>
                </div>
                <button type="button" class="layui-btn layui-btn-warm" onclick="insertUser()">添加</button>
            </div>
        </div>
    </div>

    <div id="form" style="display: none;">
        <form class="layui-form" action="" method="post">
            <div class="container">
                <div class="layui-form-item">
                    <label class="layui-form-label">用户名称</label>
                    <div class="layui-input-block">
                        <input type="hidden" id="Plevel" name="userlevel">
                        <input type="hidden" id="Pid" name="addid">
                        <input style="width: 230px;" type="text" name="name" required  lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">code描述</label>
                    <div class="layui-input-inline">
                        <input style="width: 230px;" type="text" name="codename" required lay-verify="required" placeholder="请输入新节点名称" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密&nbsp;&nbsp;码</label>
                    <div class="layui-input-inline">
                        <input style="width: 230px;" type="password" name="password" required lay-verify="required" placeholder="请输入新节点名称" autocomplete="off" class="layui-input">
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
    <script>
        layui.use(['layer','element','form'],function () {
            var layer = layui.layer;
            var element = layui.element;
            var form = layui.form;

            form.on('submit(form2)',function (data) {
                $.ajax({
                    url:"${pageContext.request.contextPath}/User/insertUser",
                    dataType:"json",
                    data:data.field,
                    success:function (data) {
                        if(data){
                            layer.msg("添加成功！",{icon:1});
                        }else{
                            layer.msg("添加失败！",{icon: 2});
                        }
                    }
                })
            })
        })
    </script>
</body>
</html>
