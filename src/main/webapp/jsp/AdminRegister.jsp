<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/11
  Time: 23:10
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员注册</title>
    <style>
        /* 样式 */
        * {
            margin: 0;
            padding: 0;
        }

        /* 按钮样式 */
        .register-button {
            background-color: #3498db; /* 按钮背景颜色 */
            color: white;
            font-size: 16px;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px; /* 圆角边框 */
            transition: background-color 0.3s ease; /* 过渡效果 */
            margin-right: 20px;
            font-family: "微软雅黑", sans-serif;
        }

        /* 鼠标悬停时的样式 */
        .register-button:hover {
            background-color: #2980b9; /* 悬停时的背景颜色 */
        }

        .button-container {
            margin-top: 30px; /* 调整按钮容器的上边距 */
        }

        /* 第一个按钮往左移 */
        .register-button:nth-child(1) {
            margin-right: 30px; /* 调整右边距以实现往左移 */
        }

        /* 第二个按钮往右移 */
        .register-button:nth-child(2) {
            margin-left: 70px; /* 调整左边距以实现往右移 */
        }

        /* 文本框样式 */
        .text-input {
            font-size: 24px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
            box-sizing: border-box;
            background-color: transparent; /* 将背景色设置为透明 */
            transition: border-color 0.3s, background-color 0.3s;
        }


        .text-input:hover {
            border-color: #2980B9; /* 鼠标悬停时的边框颜色 */
            background-color: rgba(0, 0, 0, 0.15); /* 鼠标悬停时的背景颜色 */
        }


        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: url("image/09.jpg") no-repeat;
            background-size: cover;
        }

        .box {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 500px;
            height: 800px;
            border-top: 1px solid rgba(255, 255, 255, 0.5);
            border-left: 1px solid rgba(255, 255, 255, 0.5);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            border-right: 1px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
        }

        .box .input-box {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: start;
            margin-bottom: 10px;
        }

        .box .input-box > label {
            margin-bottom: 10px;
            font-size: 24px; /* 调整标签字体大小 */
            font-family: "微软雅黑", sans-serif; /* 使用微软雅黑字体 */
        }

        .box .input-box > input {
            font-size: 24px; /* 调整输入框字体大小 */
            height: 35px;
            width: 250px;
        }

        .register-caption {
            font-size: 30px;
            font-family: "微软雅黑", sans-serif; /* 使用微软雅黑字体 */
        }
    </style>
    <script>
        // 注册失败时触发弹窗
        <% if (session.getAttribute("registrationSuccess") != null && !(Boolean) session.getAttribute("registrationSuccess")) { %>
        alert("注册失败，请重试!");
        <% } %>
        // 清除 session 中的属性
        <% session.removeAttribute("registrationSuccess"); %>
    </script>
</head>
<body>
<div class="box">
    <form action="${pageContext.request.contextPath}/Register_admin" method="post">
        <table>
            <caption class="register-caption" style="font-size: 50px">管理员注册</caption>
            <tr>
                <td><label style="font-size: 30px;">账号: </label><input type="text" name="admin_ID"
                                                                         style="font-size: 24px;"
                                                                         class="text-input">
                </td>
            </tr>
            <tr>
                <td><label style="font-size: 30px;">密码: </label><input type="password" name="admin_pwd"
                                                                         style="font-size: 24px;" class="text-input">
                </td>
            </tr>
            <tr>
                <td><label style="font-size: 30px;">姓名: </label><input type="text" name="admin_name"
                                                                         style="font-size: 24px;" class="text-input">
                </td>
            </tr>

        </table>
        <div class="button-container">
            <input style="font-size: 25px" type="submit" value="注册" class="register-button"/>
            <input style="font-size: 25px" type="reset" value="清除" class="register-button"/>
        </div>
    </form>
</div>
</body>
</html>