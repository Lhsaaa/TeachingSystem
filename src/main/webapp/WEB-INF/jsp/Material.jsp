<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/14
  Time: 23:20
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
    <title>章节查看
    </title>
    <style>
        body {
            background-image: url("images/bg5.png");
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


        .BackToChapter-button {
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

        .BackToChapter-button:hover {
            background-color: #2980b9;
        }

        .material-table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            font-family: "微软雅黑", sans-serif;
            backdrop-filter: blur(10px);
            background-color: rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .material-table th, .material-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .material-table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        .material-table tr:hover {
            background-color: #f5f5f5;
        }

        .MaterialsList {
            margin-left: 200px;
        }


        /* 美化查看按钮 */
        .material-table button[type="submit"] {
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
        .material-table button[type="submit"]:hover {
            background-color: #2980b9; /* 悬停时的背景颜色 */
        }


    </style>
</head>


<body>


<h1 class="Page_title">${chapter.chapter_title} 章节课件查看</h1>

<h1>所属课程: ${chapter.course_id}
</h1>
<hr>
<br>
<!-- 显示课件列表 -->
<h2 class="MaterialsList">课件列表</h2>
<c:if test="${ empty materials}">
    <p>暂无课件</p>
</c:if>

<c:if test="${not empty materials}">
    <table class="material-table">
        <tr>
            <th>课件标题</th>
            <th>上传教师</th>
            <th>上传时间</th>
            <th>操作</th>
        </tr>
        <c:forEach var="material" items="${materials}">
            <tr>
                <td>${material.material}
                </td>
                <td>
                    ${material.course_id}
                </td>

                <td>${material.upload_time}
                </td>

                <td>
                    <form action="fileServlet" method="get" target="_blank">
                        <input type="hidden" name="filePath"
                               value="<%= URLEncoder.encode(material.getFilePath(), "UTF-8") %>">
                        <button type="submit">查看</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<a class="back-button" href="main_stu.jsp">返回主界面</a>
<a class="logout-button" href="login_stu.jsp">退出登录</a>

<a class="BackToChapter-button" href="Chapter_stu.jsp?courseId=<%=courseId%>">返回章节列表</a>

</body>
</html>
