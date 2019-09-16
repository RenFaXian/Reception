<%--
  Created by IntelliJ IDEA.
  User: Renfaxian
  Date: 2019/8/29
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>机构管理</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.2.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree/css/zTreeStyle/zTreeStyle.css"/>
    <script src="${pageContext.request.contextPath}/static/layer/layer.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css"/>
    <script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.core.js"></script>
    <script src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.all.js"></script>
    <script>
        var setting = {
            data:{
                simpleData:{
                    enable:true,
                    idKey:"id",
                    pIdKey:"pid",
                    rootPId:0
                }
            },view:{
                addHoverDom: addHoverDom,//自定义添加节点信息
                removeHoverDom: removeHoverDom,//自定义删除节点
                selectedMulti: false //禁止多选
            },

            edit:{
                enable:true,//开启可编辑
                editNameSelectAll: true,//点击修改默认全选
                removeTitle: "删除节点",
                renameTitle: "编辑节点名称"
            },

            callback:{
                beforeRemove: zTreeBeforeRemove,//删除之前的回调判断
                beforeRename: zTreeBeforeRename,//改名之前的回调判断
                onRemove: zTreeOnRemove,//删除之后操作后台
                onRename: zTreeOnRename,//改名之后，操作后台
                beforeDrag: zTreeBeforeDrag//禁止拖拽
            },async:{
                enable:true,
                url:"${pageContext.request.contextPath}/Address/findAllAddress",
                type:"post"
            }
        }
        $(function () {
            $.fn.zTree.init($("#address"), setting);
        })
        //自定义添加节点
        function addHoverDom(treeId, treeNode) {
            var aObj = $("#" + treeNode.tId + "_a");
            if ($("#diyBtn_"+treeNode.id).length>0)
                return;
            var editStr = "<span type='button' class='button add' id='diyBtn_" +treeNode.id
                + "' title='添加节点' onfocus='this.blur();'></span>";
            aObj.append(editStr);
            var btn = $("#diyBtn_"+treeNode.id);
            if (btn) btn.bind("click", function(){
                alert("diy Button for " + treeNode.name+treeNode.id);
                $("#p1i1d").val(treeNode.id);

                /*$("#myModalinserteqmcategory").modal('show');*/
                $("#parentName").val(treeNode.name);
                $("#Pid").val(treeNode.id);
                $("#Plevel").val(treeNode.level+2);
                console.log(treeNode);
                layer.open({
                    type: 1,
                    skin: 'layui-layer-rim', //加上边框
                    area: ['420px', '240px'], //宽高
                    content: $("#form")
                });
                /* zTreeObj.addNodes(treeNode,{id:100000,pId:treeNode.id,name:'新节点'}); */

            });


        };
        //自定义删除节点信息
        function removeHoverDom(treeId, treeNode) {
            $("#diyBtn_"+treeNode.id).unbind().remove();
        };
        //删除之前的回调函数
        function zTreeBeforeRemove(treeId, treeNode) {

            if(treeNode.isParent){
                layer.msg("这是一个父节点，不可以删除");
                return false;
            }else{
                return window.confirm("是否删除这个节点?");
            }
        }
        //编辑节点之前的回调函数
        function zTreeBeforeRename(treeId, treeNode, newName, isCancel) {
            return newName.length > 1;
        }
        //捕获，删除节点之后的回调函数
        function zTreeOnRemove(event, treeId, treeNode) {
            //后台发送ajax请求 进行更改
            $.ajax({
                url:"${pageContext.request.contextPath}/Address/delAddress",
                type:"post",
                dataType:"text",
                data:{id:treeNode.id},
                success:function(data){
                    if(data){
                        layer.msg("删除成功");
                    }
                },error:function(){
                    layer.msg("删除失败");
                }
            })

            alert(treeNode.tId + ", " + treeNode.name + ", " + treeNode.id);
        }
        //捕获，节点名称编辑之后的回调函数
        function zTreeOnRename(event, treeId, treeNode, isCancel) {
            //后台发送ajax 进行更改
            $.ajax({
                url:"${pageContext.request.contextPath}/Address/updateAddress",
                type:"post",
                dataType:"json",
                data:{id:treeNode.id,name:treeNode.name},
                success:function(data){
                    if(data){
                        layer.msg("修改成功");
                    }
                },error:function(){
                    layer.msg("修改失败");
                }
            })
            alert(treeNode.tId + ", " + treeNode.name + ", " + treeNode.id);
        }
        //禁止拖拽
        function zTreeBeforeDrag(treeId, treeNodes) {
            return false;
        };
    </script>
</head>
<body>

    <ul class="ztree" id="address"></ul>


    <div id="form" style="display: none;">
        <form class="layui-form" action="" method="post">
            <div class="container">
                <div class="layui-form-item">
                    <label class="layui-form-label">父节点</label>
                    <div class="layui-input-block">
                        <input type="hidden" id="Plevel" name="level">
                        <input type="hidden" id="Pid" name="pid">
                        <input style="width: 230px;" type="text" id="parentName" required  lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">名 &nbsp;&nbsp;称</label>
                    <div class="layui-input-inline">
                        <input style="width: 230px;" type="text" name="name" required lay-verify="required" placeholder="请输入新节点名称" autocomplete="off" class="layui-input">
                    </div>
                    <!-- <div class="layui-form-mid layui-word-aux">辅助文字</div> -->
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="form1">提交</button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script>
        layui.use(['form','layer'],function () {
            var form = layui.form;
            var layer = layui.layer;

            form.on('submit(form1)',function (data) {
                $.ajax({
                    url:"${pageContext.request.contextPath}/Address/myModalinsertAddress",
                    dataType:"json",
                    data:data.field,
                    success:function (data) {
                        if(data){
                            layer.msg('添加成功',{icon:1});
                        }else{
                            layer.msg('添加失败',{icon:2});
                        }
                    }
                });
            })
        })
    </script>
</body>
</html>
