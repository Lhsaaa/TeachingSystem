<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/11
  Time: 23:08
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>管理员主页</title>
    <script src="${ pageContext.request.contextPath }/js/jquery-3.6.0.js" type="text/javascript"></script>

    <style>
        body {
            background: url("image/bg3.png") no-repeat;
            background-size: cover;
        }

        .model-button {
            background-color: #3498db;
            color: white;
            font-size: 30px;
            font-weight: 300;
            width: 280px;
            height: 70px;
            text-align: center;
            line-height: 70px; /* 与按钮高度相同，使文本垂直居中 */
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            font-family: "微软雅黑", sans-serif;
            text-decoration: none;
        }

        .model-button:hover {
            background-color: #2980b9;
        }

        .model-button::before {
            content: '\2192'; /* Unicode 编码表示向右箭头 */
            display: inline-block;
            opacity: 0; /* 默认不显示 */
            transition: opacity 0.3s ease; /* 平滑过渡 */
        }

        /* 悬停时显示箭头 */
        .model-button:hover::before {
            opacity: 1; /* 悬停时显示 */
            margin-right: 5px; /* 调整箭头与文本之间的距离 */
        }


        .edit-button-container {
            position: absolute;
            top: 165px;
            left: 400px;
            margin: 20px;
        }


        .edit-button {
            background-color: #3498db;
            color: white;
            font-size: 15px;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            font-family: "微软雅黑", sans-serif;
            text-decoration: none;
        }

        .edit-button:hover {
            background-color: #2980b9;
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

        .welcome-title {
            font-size: 50px;
            font-family: "微软雅黑", sans-serif;
            margin-top: 50px;
            display: flex;
            justify-content: center;
            color: #000000;
            font-weight: 500;
        }

        .container {
            display: flex;
            flex-direction: row;
            align-items: flex-start;
            width: 1800px;

            margin-top: 30px;
            margin-left: 20px;
        }

        table {
            width: 60%;
            font-size: 20px;
            font-family: "微软雅黑", sans-serif;
            border-collapse: collapse;
            border-spacing: 0;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border: 1px solid #dddddd;
            padding: 12px 15px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: rgba(242, 242, 242, 0.7);
        }

        tr:hover {
            background-color: #e5e5e5;
        }

        .link-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-top: -25px;
            margin-left: 150px;
        }

        .link-container a {
            margin: 20px 0;
        }


    </style>

</head>

<body>

<p class="welcome-title">欢迎进入网上教学系统管理员端</p>
<hr>
<h2>亲爱的 ${user.admin_name} 以下是您的个人信息：</h2>

<div class="container">
    <table border="1">
        <tr>
            <td>工号:</td>
            <td>${user.admin_ID}
            </td>
        </tr>
        <tr>
            <td>密码:</td>
            <td>${user.admin_pwd}
            </td>
        </tr>

        <tr>
            <td>姓名:</td>
            <td>${user.admin_name}
            </td>
        </tr>
    </table>

    <div class="link-container">
        <a href="${pageContext.request.contextPath}/toMessage_admin" class="model-button">去往留言板</a>
        <a href="${pageContext.request.contextPath}/toCourse" class="model-button">查看课程介绍</a>
        <%--        <a href="CourseToChapter_stu.jsp" class="model-button">章节课件查看</a>--%>
        <%--        <a href="Question.jsp" class="model-button">模拟答题</a>--%>
    </div>
</div>


<%--<div class="edit-button-container">--%>
<%--    <form action="edit_stu.jsp" method="post">--%>
<%--        <input type="hidden" name="studentId" value="<%= request.getSession().getAttribute("stu_ID") %>">--%>
<%--        <button type="submit" class="edit-button">修改个人信息</button>--%>
<%--    </form>--%>
<%--</div>--%>

<a href="${ pageContext.request.contextPath }/logout_admin" class="logout-button">退出登录</a>

</body>

</html>

