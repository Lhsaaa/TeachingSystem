<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/18
  Time: 22:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息管理</title>
    <style>
        body {
            background-image: url("images/bg4.png");
            background-size: 100%;
        }

        .logout-button, .back-button {
            font-family: "微软雅黑", sans-serif;
            font-size: 20px;
            padding: 15px 30px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            text-decoration: none;
            position: absolute;
            top: 25px;
        }

        .logout-button {
            background-color: #e2353e;
            right: 20px;
            color: white;
        }

        .back-button {
            background-color: #3498db;
            right: 200px;
            color: white;
        }

        .title_course {
            font-size: 50px;
            font-family: "微软雅黑", sans-serif;
            margin-top: 90px;
            margin-bottom: 100px;
            display: flex;
            justify-content: center;
            color: #000000;
            font-weight: 500;
        }

        .chapter-table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            font-family: "微软雅黑", sans-serif;
            backdrop-filter: blur(10px);
            background-color: rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .chapter-table th, .chapter-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .chapter-table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        .chapter-table tr:hover {
            background-color: #f5f5f5;
        }

        .edit-button, .ban-unban-button {
            background-color: #3498db;
            color: white;
            font-size: 16px;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        .edit-button:hover, .ban-unban-button:hover {
            background-color: #e2353e;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>

<p class="title_course">学生信息管理</p>
<hr>
<br>

<table class="chapter-table">
    <thead>
    <tr>
        <th>学号</th>
        <th>密码</th>
        <th>姓名</th>
        <th>专业</th>
        <th>班级</th>
        <th>邮箱</th>
        <th>账户状态</th>
        <th>操作</th>
        <th>账户操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="student" items="${students}">
        <tr>
            <td>${student.ID}</td>
            <td>${student.password}</td>
            <td>${student.name}</td>
            <td>${student.major}</td>
            <td>${student.stu_class}</td>
            <td>${student.mail}</td>
            <td>
                <c:if test="${student.banned == 0}">正常</c:if>
                <c:if test="${student.banned == 1}">被封禁</c:if>
            </td>
            <td>
                <form action="${pageContext.request.contextPath}/toEditStudent" method="post">
                    <input type="hidden" name="stu_ID" value="${student.ID}">
                    <button class="edit-button" type="submit">编辑</button>
                </form>
            </td>
            <td>
                <div class="button-group">
                    <form action="${pageContext.request.contextPath}/Ban" method="post">
                        <input type="hidden" name="studentId" value="${student.ID}">
                        <button class="ban-unban-button" type="submit">禁用</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/UnBan" method="post">

                        <input type="hidden" name="studentId" value="${student.ID}">
                        <button class="ban-unban-button" type="submit">解禁</button>
                    </form>
                </div>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<hr>

<a class="back-button" href="${pageContext.request.contextPath}/main_admin">返回主界面</a>
<a href="${pageContext.request.contextPath}/logout_admin" class="logout-button">退出登录</a>

</body>
</html>
