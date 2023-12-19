<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/19
  Time: 19:10
  To change this template use File | Settings | File Templates.
--%>

<!DOCTYPE html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>修改学生信息</title>
    <style>
        /* 样式 */
        * {
            margin: 0;
            padding: 0;
        }


        .back-button {
            background-color: #3498db;
            color: white;
            font-size: 20px;
            padding: 15px 30px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            font-family: "微软雅黑", sans-serif;
            text-decoration: none;
            position: absolute;
            top: 25px;
            right: 200px;
        }

        .back-button:hover {
            background-color: #2980b9;
        }

        /* 按钮样式 */
        .edit-button {
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
        .edit-button:hover {
            background-color: #2980b9; /* 悬停时的背景颜色 */
        }

        .button-container {
            margin-top: 30px; /* 调整按钮容器的上边距 */
        }

        /* 第一个按钮往左移 */
        .edit-button:nth-child(1) {
            margin-right: 30px; /* 调整右边距以实现往左移 */
        }

        /* 第二个按钮往右移 */
        .edit-button:nth-child(2) {
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
            background: url("images/09.jpg") no-repeat;
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

        .edit-caption {
            font-size: 30px;
            font-family: "微软雅黑", sans-serif; /* 使用微软雅黑字体 */
        }

        .logout-button {
            background-color: #e2353e;
            color: white;
            font-size: 20px;
            padding: 15px 30px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            font-family: "微软雅黑", sans-serif;
            text-decoration: none;
            position: absolute;
            top: 25px;
            right: 20px;
        }

        .logout-button:hover {
            background-color: #b01d23;
        }
    </style>
</head>
<body>

<c:if test="${not empty student}">
    <div class="box">
        <form action="${pageContext.request.contextPath}/UpdateStudent_admin" method="post">
            <table>
                <caption class="edit-caption" style="font-size: 50px; margin-bottom: 20px">修改个人信息</caption>
                <tr>
                    <td><label style="font-size: 30px;">学号: </label><input style="font-size: 24px;" class="text-input"
                                                                             type="text" name="ID"
                                                                             value="${student.ID}" readonly>
                    </td>
                </tr>
                <tr>
                    <td><label style="font-size: 30px;">密码: </label><input type="text" name="password"
                                                                             value="${student.password}"
                                                                             style="font-size: 24px;"
                                                                             class="text-input"></td>
                </tr>
                <tr>
                    <td><label style="font-size: 30px;">姓名: </label><input type="text" name="name"
                                                                             value="${student.name}"
                                                                             style="font-size: 24px;"
                                                                             class="text-input"></td>
                </tr>
                <tr>
                    <td><label style="font-size: 30px;">专业: </label><input type="text" name="major"
                                                                             value="${student.major}"
                                                                             style="font-size: 24px;"
                                                                             class="text-input"></td>
                </tr>
                <tr>
                    <td><label style="font-size: 30px;">班级: </label><input type="text" name="stu_class"
                                                                             value="${student.stu_class}"
                                                                             style="font-size: 24px;"
                                                                             class="text-input"></td>
                </tr>
                <tr>
                    <td><label style="font-size: 30px;">邮箱: </label><input type="text" name="mail"
                                                                             value="${student.mail}"
                                                                             style="font-size: 24px;"
                                                                             class="text-input"></td>
                </tr>
            </table>
            <div class="button-container">
                <input style="font-size: 25px" type="submit" value="保存" class="edit-button"/>
            </div>
        </form>
    </div>

</c:if>


<c:if test="${empty student}">
    <p>未找到该学生信息。</p>
</c:if>

<hr>

<a class="back-button" href="${pageContext.request.contextPath}/main_admin">返回主界面</a>
<a href="${pageContext.request.contextPath}/logout_admin" class="logout-button">退出登录</a>

</body>
</html>