<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/10
  Time: 13:03
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生登录</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: url("/static/08.jpg") no-repeat;
            background-size: cover;
        }

        .box {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 500px;
            height: 400px;
            border-top: 1px solid rgba(255, 255, 255, 0.5);
            border-left: 1px solid rgba(255, 255, 255, 0.5);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            border-right: 1px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
        }

        .box > h2 {
            margin-bottom: 20px;
        }

        .box .input-box {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: start;
            margin-bottom: 10px;
        }

        .box .input-box > label {
            margin-bottom: 5px;
        }

        .box .input-box > input {
            font-size: 24px;
            height: 35px;
            width: 250px;
            border: 1px solid transparent;
            background-color: rgba(0, 0, 0, 0.1);
            padding: 5px;
            transition: border-color 0.3s, background-color 0.3s;
        }

        .box .input-box > input:hover {
            border-color: #3498db; /* 鼠标悬停时的边框颜色 */
            background-color: rgba(0, 0, 0, 0.15); /* 鼠标悬停时的背景颜色 */
        }

        /* 修改注册按钮的样式 */
        .button-container input[type="submit"] {
            background-color: #3498db; /* 修改按钮背景颜色 */
            color: white;
            font-size: 16px;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px; /* 添加圆角边框 */
            transition: background-color 0.3s ease; /* 添加过渡效果 */
            margin-top: 20px;
        }

        /* 修改注册按钮的样式 */
        .register-button {
            background-color: #3498db; /* 修改按钮背景颜色 */
            color: white;
            font-size: 16px;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px; /* 添加圆角边框 */
            transition: background-color 0.3s ease; /* 添加过渡效果 */
            margin-top: 58px; /* Adjust the margin-top to move the button downward */
            position: absolute;
            top: 242px;
            left: 288px;
        }

        /* 注册按钮悬停时的样式 */
        .register-button:hover {
            background-color: #2980b9; /* 悬停时的背景颜色 */
        }

        .button-container input[type="submit"],
        .button-container button[type="button"] {
            margin-right: 60px; /* 增加按钮之间的右侧间距，根据需要进行调整 */
        }


        /* 鼠标悬停时的样式 */
        .button-container input[type="submit"]:hover,
        .button-container button[type="button"]:hover {
            background-color: #2980b9; /* 悬停时的背景颜色 */
        }

        /* 注册链接样式 */
        .register-link a {
            color: #3498db; /* 修改链接颜色 */
            text-decoration: none;
        }

        /* 链接悬停时的样式 */
        .register-link a:hover {
            text-decoration: underline; /* 添加下划线 */
        }


    </style>

</head>

<script>
    //验证输入的用户名与密码是否为空
    function validateForm() {
        const username = document.forms[0].elements["ID"].value;
        const password = document.forms[0].elements["Password"].value;

        if (username.trim() === "" || password.trim() === "") {
            alert("请输入用户名和密码");
            return false;
        }
        return true;
    }
</script>


<body>
<div class="box">
    <h1>学生登录</h1>
    <br/>
    <form action="${pageContext.request.contextPath }/login_stu" method="POST">
        <div>${msg}</div>
        <div class="input-box">
            <label style="font-size: 25px">账号:</label>
            <input name="ID" type="text"/>
        </div>
        <div class="input-box">
            <label style="font-size: 25px">密码:</label>
            <input name="password" type="password"/>
        </div>

        <div class="button-container">
            <input style="font-size: 25px" type="submit" value="登录"/>
        </div>
    </form>
    <button class="register-button" style="font-size: 25px"
            onclick="window.location.href='${pageContext.request.contextPath}/toRegister_stu'">
        注册
    </button>
</div>
<br><a style="font-size: 25px" href="${pageContext.request.contextPath}/backToWelcome">返回欢迎界面</a>
</body>

</html>