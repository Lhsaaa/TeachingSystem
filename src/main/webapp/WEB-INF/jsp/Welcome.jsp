<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/10
  Time: 12:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>网上教学系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        html, body {
            overflow: hidden; /* 隐藏页面的滚动条 */
        }

        body {
            background-image: url("images/bg1.png");
            background-size: cover;
            min-height: 100vh; /* 设置body的最小高度为视口高度的100% */
            margin: 0; /* 去除body的默认边距 */
        }

        .box {
            text-align: center;
            /* 让盒子水平居中 */
            margin: 300px auto;
            backdrop-filter: blur(10px); /* 添加背景模糊效果 */
            background-color: rgba(255, 255, 255, 0.05); /* 添加半透明背景颜色 */
            padding: 20px; /* 添加内边距以提升可读性 */
            border-radius: 10px; /* 添加圆角效果 */
            width: 1350px;
            height: 250px;
        }

        .box > a {
            font-size: 24px;
            letter-spacing: 2px;
            background-color: #b01d23;
            color: #FFFFFF;
            width: 250px;
            height: 65px;
            border: none;
            border-radius: 8px;
            font-family: "Microsoft YaHei", sans-serif;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            margin-left: 15px;
            margin-right: 15px;
            margin-top: 50px;
            display: inline-block; /* Change display property */
            text-align: center; /* Center text horizontally */
            line-height: 65px; /* Center text vertically */
            text-decoration: none; /* Remove underlines from links */
            padding: 5px; /* Increase padding */
        }


        .box > a:hover {
            background-color: #e0383e;
            transform: scale(1.05);
        }


        h1 {
            font-size: 80px;
            font-family: "Microsoft YaHei", sans-serif;
            font-weight: 300;
            color: #FFffff;
        }

        .wasd {
            text-align: center;
            margin: 300px auto;
        }

        .wasd > a {
            font-size: 25px;
            margin-top: 30px;
            letter-spacing: 2px;
            color: #FFFFFF;
            width: 250px;
            height: 50px;
            border: none;
            border-radius: 8px;
            font-family: "Microsoft YaHei", sans-serif;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s, color 0.3s; /* 添加颜色变化的过渡效果 */
            margin-left: 15px;
            margin-right: 15px;
        }

        .wasd > a:hover {
            color: #e0383e; /* 鼠标悬停时的文字颜色 */
            transform: scale(1.05);
        }
    </style>
</head>
<body>
<div class="box">
    <h1>网上教学系统</h1>
    <a href="${pageContext.request.contextPath}/tologin_stu">学生登录</a>
    <a href="${pageContext.request.contextPath}/tologin_teacher">教师登录</a>
    <a href="${pageContext.request.contextPath}/tologin_admin">管理员登录</a>
</div>
<div class="wasd">
    <a style="font-size: 25px" href="https://www.dhu.edu.cn/">东华主页</a>
    <a style="font-size: 25px" href="http://webmail.dhu.edu.cn/">东华邮件</a>
    <a style="font-size: 25px"
       href="https://webproxy.dhu.edu.cn/https/446a50612140233230323231314468551c396b0a0faca42deda1bb464c2c/authserver/login?service=https%3A%2F%2Fwebproxy.dhu.edu.cn%3A443%2Flogin%3Fcas_login%3Dtrue">vpn服务</a>
    <a style="font-size: 25px" href="https://cst.dhu.edu.cn/">计算机学院</a>
</div>
</body>
</html>
