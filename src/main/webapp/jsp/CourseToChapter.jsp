<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/13
  Time: 21:42
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>教学课件查看</title>
    <style>
        body {
            background: url("image/07.jpg") no-repeat;
            background-size: cover;
        }

        .Page_title {
            font-size: 50px;
            font-family: "微软雅黑", sans-serif;
            margin-top: 90px;
            margin-bottom: 100px;
            display: flex;
            justify-content: center;
            color: #000000;
            font-weight: 500;
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


        .container {
            text-align: center;
            padding: 20px 0;
        }

        .table-container {
            margin: 20px auto;
            width: 70%;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid #000000;
        }

        .course-table {
            width: 100%;
            border-collapse: collapse;
        }

        .course-table th,
        .course-table td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #000000;
        }

        .course-table th {
            background: rgba(255, 255, 255, 0.1);
            color: #333;
        }

        .course-table tr:hover {
            background-color: #f5f5f5;
        }

        .course-button {
            background-color: #3498db;
            color: white;
            font-size: 16px;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            font-family: "微软雅黑", sans-serif;
            text-decoration: none;
            margin: 0 5px;
        }

        .course-button:hover {
            background-color: #2980b9;
        }

        .table-title {
            font-size: 30px;
            font-family: "微软雅黑", sans-serif;
            margin-top: 70px;
            display: flex;
            margin-left: 300px;
            color: #000000;
            font-weight: 400;
        }


    </style>
</head>
<body>
<h1 class="Page_title">教学课件查看</h1>

<h2 class="table-title">· 课程列表</h2>
<hr>
<c:if test="${not empty courses}">
<div class="container">
    <div class="table-container">
        <table class="course-table">
            <tr>
                <th>课程ID</th>
                <th>课程名称</th>
                <th>任课老师</th>
                <th>查看课件</th>
            </tr>

            <c:forEach var="course" items="${courses}">

                <tr>
                    <td>${course.id}
                    </td>
                    <td>${course.name}
                    </td>
                    <td>${course.teacher_name}
                    </td>
                    <td>
                        <c:if test="${IsStudent}">
                            <form action="toChapter_stu" method="get">
                                <input type="hidden" name="courseId" value="  ">
                                <button class="course-button" type="submit">查看
                                </button>
                            </form>
                        </c:if>

                        <c:if test="${IsAdmin||IsTeacher}">
                            <form action="toChapter_admin" method="get">
                                <input type="hidden" name="courseId" value="  ">
                                <button class="course-button" type="submit">查看
                                </button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    </c:if>

    <c:if test="${empty courses}">
    <p>暂无课程</p>
    </c:if>

    <a class="back-button" href="${pageContext.request.contextPath}/main_stu">返回主界面</a>
    <a href="${ pageContext.request.contextPath }/logout_stu" class="logout-button">退出登录</a>
</body>
</html>