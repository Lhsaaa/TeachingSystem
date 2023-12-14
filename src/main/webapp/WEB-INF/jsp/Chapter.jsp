<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/14
  Time: 12:52
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
    <title>课程章节和课件查看</title>
    <style>
        body {
            background-image: url("images/bg4.png");
            background-size: 100%;
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

        .CourseInfo {
            font-family: "微软雅黑", sans-serif;
            font-size: 20px;
            color: #c4BFBF;
            font-weight: 300;
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


        .BackToCourse-button {
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
            top: 120px;
            right: 115px;
        }

        .BackToCourse-button:hover {
            background-color: #2980b9;
        }


        .chapter-table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            font-family: "微软雅黑", sans-serif;
        }

        .chapter-table th, .chapter-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .chapter-table th {
            background-color: #f2f2f2;
        }

        .chapter-table tr:hover {
            background-color: #f5f5f5;
        }

        .chapter-table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            font-family: "微软雅黑", sans-serif;
            backdrop-filter: blur(10px); /* 添加背景模糊效果 */
            background-color: rgba(255, 255, 255, 0.2); /* 添加半透明背景颜色 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 添加阴影效果 */
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

        /* 添加阴影效果 */
        .chapter-table {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* 美化查看课件按钮 */
        .chapter-table button[type="submit"] {
            background-color: #3498db; /* 修改按钮背景颜色 */
            color: white;
            font-size: 16px;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            border-radius: 5px; /* 添加圆角边框 */
            transition: background-color 0.3s ease; /* 添加过渡效果 */
        }

        /* 悬停时的样式 */
        .chapter-table button[type="submit"]:hover {
            background-color: #2980b9; /* 悬停时的背景颜色 */
        }


    </style>
</head>
<body>

<h1 class="Page_title">课程章节与课件查看</h1>


<h2 style="color:#c4BFBF">课程信息</h2>
<p class="CourseInfo">课程名称: ${course.name}
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 发布教师: ${course.teacher_name}
</p>
<hr>

<c:if test="${empty chapters}">
    <h2>暂无章节</h2>
</c:if>

<c:if test="${not empty chapters}">
    <h2>章节列表</h2>
    <table class="chapter-table">
        <tr>
            <th>章节标题</th>
            <th>操作</th>
        </tr>
        <c:forEach var="chapter" items="${chapters}">
            <tr>
                <td>${chapter.chapter_title}
                </td>
                <td>
                    <form action="Chapter_Check.jsp" method="post">
<%--                        <input type="hidden" name="chapterId" value="${chapter.chapter_id}">--%>
<%--                        <input type="hidden" name="courseId" value="${course.id}">--%>
<%--                        <input type="hidden" name="chapter_title" value="<%=chapter.getTitle()%>">--%>
<%--                        <input type="hidden" name="CourseTeacher" value="<%= course.GetTeacherName() %>">--%>
<%--                        <input type="hidden" name="courseName" value="<%=course.getName()%>">--%>
                        <button type="submit" name="editButton">查看课件</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>>


<c:if test="${IsTeacher}">
    <a class="back-button" href="${pageContext.request.contextPath}/main_teacher">返回主界面</a>
    <a href="${ pageContext.request.contextPath }/logout_teacher" class="logout-button">退出登录</a>
</c:if>


<c:if test="${IsAdmin}">
    <a class="back-button" href="${pageContext.request.contextPath}/main_admin">返回主界面</a>
    <a href="${ pageContext.request.contextPath }/logout_admin" class="logout-button">退出登录</a>
</c:if>

<c:if test="${IsStudent}">
    <a class="back-button" href="${pageContext.request.contextPath}/main_stu">返回主界面</a>
    <a href="${ pageContext.request.contextPath }/logout_stu" class="logout-button">退出登录</a>
</c:if>

<a class="BackToCourse-button" href="${pageContext.request.contextPath}/toCourseToChapter">返回课程列表</a>
</body>
</html>
