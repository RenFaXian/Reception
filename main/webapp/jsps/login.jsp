<%--
  Created by IntelliJ IDEA.
  User: Renfaxian
  Date: 2019/8/28
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<link>
    <title>登陆</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/layer/layer.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css"/>
    <script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>

    <style type="text/css">
        .container{
            width: 420px;
            height: 320px;
            min-height: 320px;
            max-height: 320px;
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            margin: auto;
            padding: 20px;
            z-index: 130;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 3px 18px rgba(100, 0, 0, .5);
            font-size: 16px;
        }
        .close{
            background-color: white;
            border: none;
            font-size: 18px;
            margin-left: 410px;
            margin-top: -10px;
        }

        .layui-input{
            border-radius: 5px;
            width: 300px;
            height: 40px;
            font-size: 15px;
        }
        .layui-form-item{
            margin-left: -20px;
        }
        #logoid{
            margin-top: -16px;
            padding-left:200px;
            padding-bottom: 15px;
        }
        .layui-btn{
            margin-left: -50px;
            border-radius: 5px;
            width: 350px;
            height: 40px;
            font-size: 15px;
        }
        .verity{
            width: 120px;
        }
        .font-set{
            font-size: 13px;
            text-decoration: none;
            margin-left: 120px;
        }
        a:hover{
            text-decoration: underline;
        }

    </style>
</head>
<body>
    <div class="layui-fluid">
        <img src="${pageContext.request.contextPath}/static/imgs/tpybx.jpg" style="width: 1262px;height: 580px">
    </div>
    <form class="layui-form" action="" method="post">
        <div class="container">
            <button class="close" title="关闭">X</button>
            <div class="layui-form-mid layui-word-aux">
                <%--<img id="logoid" src="06.png" height="35">--%>
                <i id="logoid" class="layui-icon layui-icon-auz" style="font-size: 30px;color: red;"></i>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-block">
                    <input type="text" name="codename" required  lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密 &nbsp;&nbsp;码</label>
                <div class="layui-input-inline">
                    <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
                <!-- <div class="layui-form-mid layui-word-aux">辅助文字</div> -->
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">登陆</button>
                </div>
            </div>
            <a href="" class="font-set">忘记密码?</a>  <a href="" class="font-set">立即注册</a>
        </div>
    </form>
    <script>
        layui.use(['form','layer'], function(){
            var form = layui.form
                ,layer = layui.layer;
            //监听提交
            form.on('submit(formDemo)', function(data){
                console.log(JSON.stringify(data.field));
                $.ajax({
                    url:"${pageContext.request.contextPath}/User/login1",
                    type:"post",
                    dataType:"json",
                    data:data.field,
                    success:function (data) {
                        if(data){
                            layer.msg('登陆成功！', {icon: 1});
                            window.location.href="${pageContext.request.contextPath}/jsps/index.jsp";
                        }else{
                            layer.msg('用户名或密码输入错误！', {icon: 2});
                        }
                    }
                });
                return false;
            });
        });
    </script>
</body>
</html>
