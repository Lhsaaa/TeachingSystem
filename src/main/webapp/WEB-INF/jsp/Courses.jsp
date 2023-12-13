<%@ page import="pojo.Course" %><%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/10
  Time: 21:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>课程查看</title>

    <style>
        /* 模态框样式 */
        body {
            background-image: url("image/bg3.png");
            background-size: cover;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover, .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
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
        }

        /* 鼠标悬停时的样式 */
        .button-container input[type="submit"]:hover {
            background-color: #2980b9; /* 悬停时的背景颜色 */
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

        /* 将添加留言的文本框设置为透明的 */
        .button-container textarea {
            background-color: rgba(0, 0, 0, 0.1); /* 使用 rgba 颜色表示透明背景 */
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 5px;
            width: 80%;
            font-family: "Arial", sans-serif; /* 设置字体样式 */
            font-size: 20px; /* 设置字体大小 */
            overflow-y: hidden;
        }

        /* 鼠标移入文本域时改变边框颜色 */
        .button-container textarea:hover {
            border-color: #2980b9; /* 鼠标移入时的边框颜色 */
        }

        .course-list-title {
            font-size: 35px;
            font-family: "微软雅黑", sans-serif;
            margin-top: 70px;
            display: flex;
            margin-left: 200px;
            color: #000000;
            font-weight: 300;
        }

        /* 课程介绍和课程大纲按钮 */
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

        table {
            border-collapse: collapse;
            width: 80%;
            margin: 30px auto; /* 居中显示表格 */
            background-color: white; /* 表格背景颜色 */
            font-family: "微软雅黑", sans-serif;
        }

        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2; /* 表头背景颜色 */
            color: #333;
        }

        tr:nth-child(even) {
            background-color: #c2c0c0; /* 偶数行背景颜色 */
        }

        tr:hover {
            background-color: #e0e0e0; /* 鼠标悬停时的背景颜色 */
        }

        .modal-content {
            margin: 15% auto;
            padding: 20px;
            border: none; /* 去掉边框 */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* 添加阴影效果 */
            background-color: white; /* 模态框背景颜色 */
            width: 70%;
        }
    </style>

    <script>

        function showCourseIntro(introText) {
            var modal = document.getElementById("courseIntroModal");
            var introElement = document.getElementById("courseIntroText");
            introElement.textContent = introText;
            modal.style.display = "block";
        }

        function showCourseOutline(outlineText) {
            var modal = document.getElementById("courseOutlineModal");
            var outlineElement = document.getElementById("courseOutlineText");
            outlineElement.textContent = outlineText;
            modal.style.display = "block";
        }

        function showCourseIntroEditModal(courseId, introText) {
            var modal = document.getElementById("courseIntroEditModal");
            var introElement = document.getElementById("courseIntroEditText");
            var introForm = document.getElementById("courseIntroEditForm");

            introElement.value = introText;
            introForm.action = "CS_teacher_Reset?action=edit_intro&id=" + courseId;

            modal.style.display = "block";
        }

        function showCourseOutlineEditModal(courseId, outlineText) {
            var modal = document.getElementById("courseOutlineEditModal");
            var outlineElement = document.getElementById("courseOutlineEditText");
            var outlineForm = document.getElementById("courseOutlineEditForm");

            outlineElement.value = outlineText;
            outlineForm.action = "CS_teacher_Reset?action=edit_outline&id=" + courseId;

            modal.style.display = "block";
        }

        function closeCourseIntroModal() {
            var modal = document.getElementById("courseIntroModal");
            modal.style.display = "none";
        }

        function closeCourseOutlineModal() {
            var modal = document.getElementById("courseOutlineModal");
            modal.style.display = "none";
        }

        function closeCourseIntroEditModal() {
            var modal = document.getElementById("courseIntroEditModal");
            modal.style.display = "none";
        }

        function closeCourseOutlineEditModal() {
            var modal = document.getElementById("courseOutlineEditModal");
            modal.style.display = "none";
        }
    </script>

</head>
<body>

<h1 style="display: flex ;justify-content: center;font-family:Microsoft YaHei,
    sans-serif;font-size: 70px;font-weight: 400">课程查看</h1>


<h2 style="color: #FFFFFF;font-family:Microsoft YaHei, sans-serif;font-weight: 300">发布课程</h2>
<hr>
<div class="button-container">
    <c:if test="${flag}">
        <form action="${pageContext.request.contextPath}/addCourse" method="post">
            <label style="color: #FFFFFF">
                课程名称：
                <textarea name="name" rows="1" cols="100" placeholder="请在此处输入课程名称"></textarea>
            </label><br>
            <label style="color: #FFFFFF">
                课程介绍：
                <textarea name="description" rows="4" cols="100" placeholder="请在此处输入课程介绍"></textarea>
            </label><br>
            <label style="color: #FFFFFF">
                课程大纲：
                <textarea name="outline" rows="4" cols="100" placeholder="请在此处输入课程大纲"></textarea>
            </label><br>
            <input name="tech_id" type="hidden" value="${user.tech_ID}">
            <input style="margin-top: 10px" type="submit" value="发布"/>
            <hr>
        </form>
    </c:if>
</div>

<p class="course-list-title">课程列表</p>
<c:if test="${not empty CourseList}">
    <table border="1">
        <tr>
            <th>课程ID</th>
            <th>课程名称</th>
            <th>发布教师</th>
            <th>发布时间</th>
            <th>查看</th>
            <th>删除</th>
        </tr>
        <c:forEach var="course" items="${CourseList}">
            <tr>
                <td>${course.id}</td>
                <td>${course.name}</td>
                <td>${course.teacher_id}</td>
                <td><fmt:formatDate value="${course.publish_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>
                    <button class="course-button" onclick="showCourseIntro('${course.description}')">课程介绍</button>
                    <button class="course-button" onclick="showCourseOutline('${course.outline}')">课程大纲</button>
                </td>
                <td>
                    <form action="${pageContext.request.contextPath}\hiddenCourse" method="post">
                        <input type="hidden" name="CourseId" value="${course.id}">
                        <input type="submit" value="删除" class="course-button">
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    <c:if test="${empty CourseList}">
        <p>暂无课程</p>
    </c:if>
</c:if>


<!-- 课程介绍模态框 -->
<div id="courseIntroModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeCourseIntroModal()">&times;</span>
        <p id="courseIntroText"></p>
    </div>
</div>

<!-- 课程大纲模态框 -->
<div id="courseOutlineModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeCourseOutlineModal()">&times;</span>
        <p id="courseOutlineText"></p>
    </div>
</div>


<a class="back-button" href="${pageContext.request.contextPath}/main_teacher">返回主界面</a>
<a href="${ pageContext.request.contextPath }/logout_teacher" class="logout-button">退出登录</a>


</body>
</html>