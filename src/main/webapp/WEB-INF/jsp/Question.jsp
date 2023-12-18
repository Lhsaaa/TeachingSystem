<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/18
  Time: 21:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>题目列表</title>
    <style>
        body {
            background: url("images/bg5.png") no-repeat;
            background-size: cover;
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

        .table-container {
            width: 60%;
            margin: 50px auto;
            background-color: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-family: "微软雅黑", sans-serif;
            color: white;
        }

        table th, table td {
            padding: 10px;
            border: 1px solid white;
            text-align: center;
        }

        table th {
            background-color: rgba(160, 2, 31, 0.9);
        }

        table tr:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        form {
            margin-top: 20px;
        }

        form button[type="submit"] {
            background-color: #3498db;
            color: white;
            font-size: 16px;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        form button[type="submit"]:hover {
            background-color: rgb(160, 2, 31);
        }
    </style>
</head>
<body>
<h1 style="display: flex; justify-content: center; font-family: 'Microsoft YaHei', sans-serif; font-size: 70px; font-weight: 400;">
    试题列表</h1>
<hr>

<c:if test="${empty questions}">
    <p>暂无试题</p>
</c:if>

<c:if test="${not empty questions}">

<div class="table-container">
    <table>
        <tr>
            <th>题目</th>
            <th>选项 A</th>
            <th>选项 B</th>
            <th>选项 C</th>
            <th>选项 D</th>
            <th>正确答案</th>
            <th>操作</th>
        </tr>
        <c:forEach var="question" items="${questions}">
            <tr>
                <td>${question.question_text}
                </td>
                <td>${question.option_a}
                </td>
                <td>${question.option_b}
                </td>
                <td>${question.option_c}
                </td>
                <td>${question.option_d}
                </td>
                <td>${question.correct_answer}
                </td>
                <td>
                    <form action="${pageContext.request.contextPath}/deleteQuestion" method="post">
                        <input type="hidden" name="questionId" value=${question.id}>
                        <button type="submit">删除</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    </c:if>

    <br>
    <form action="${pageContext.request.contextPath}/toAdd" method="get">
        <button type="submit">添加试题</button>
    </form>
</div>

<br><br>


<c:if test="${IsAdmin}">
    <a class="back-button" href="${pageContext.request.contextPath}/main_admin">返回主界面</a>
    <a href="${ pageContext.request.contextPath }/logout_admin" class="logout-button">退出登录</a>
</c:if>

<c:if test="${IsStudent}">
    <a class="back-button" href="${pageContext.request.contextPath}/main_stu">返回主界面</a>
    <a href="${ pageContext.request.contextPath }/logout_stu" class="logout-button">退出登录</a>
</c:if>

<c:if test="${IsTeacher}">
    <a class="back-button" href="${pageContext.request.contextPath}/main_teacher">返回主界面</a>
    <a href="${pageContext.request.contextPath }/logout_teacher" class="logout-button">退出登录</a>
</c:if>


</body>
</html>
