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

        /* 共用的按钮样式 */
        .material-button {
            font-size: 16px;
            padding: 10px 20px; /* 调整按钮大小 */
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            font-family: "微软雅黑", sans-serif;
            text-decoration: none;
            color: white;
        }

        /* 查看按钮样式 */
        .material-table button.material-button.view-button {
            background-color: #3498db; /* 修改按钮背景颜色 */
        }

        /* 删除按钮样式 */
        .material-table button.material-button.delete-button {
            background-color: #e74c3c; /* 修改按钮背景颜色 */
        }

        /* 悬停时的样式 */
        .material-table button:hover {
            filter: brightness(1.2); /* 悬停时增加亮度 */
        }

        /* 调整按钮所在单元格的样式 */
        .material-table td button.material-button {
            display: block; /* 让按钮独占一行 */
            margin: 0 auto; /* 让按钮居中显示 */
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


        /* 上传课件容器样式 */
        .upload-container {
            margin: 20px;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .upload-title {
            font-size: 24px;
            font-family: "微软雅黑", sans-serif;
            margin-bottom: 20px;
            color: #3498db;
        }

        .upload-label {
            font-size: 18px;
            margin-bottom: 8px;
            display: block;
            color: #333;
        }

        .upload-input {
            font-size: 16px;
            padding: 8px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        .upload-button {
            font-size: 18px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            font-family: "微软雅黑", sans-serif;
        }

        .upload-button:hover {
            background-color: #2980b9;
        }


    </style>

    <script>
        function openNewPage(filePath) {
            // 构建真实的文件路径
            var realFilePath = "http://localhost:8086/TeachingSystem_war_exploded/upload/" + filePath;

            // 在新页面中打开指定的URL
            window.open(realFilePath, '_blank');
        }
    </script>
</head>


<body>
<c:if test="${IsTeacher}">
    <h1 class="Page_title">编辑章节 <${chapter.chapter_title}></h1>
</c:if>

<c:if test="${IsAdmin}">
    <h1 class="Page_title">编辑章节 <${chapter.chapter_title}></h1>
</c:if>

<c:if test="${IsStudent}">
    <h1 class="Page_title">查看章节 <${chapter.chapter_title}></h1>
</c:if>


<h1>所属课程: ${chapter.course_name}
</h1>
<br>
<br>
<hr>
<br>
<!-- 显示课件列表 -->
<h2 class="MaterialsList">课件列表</h2>
<c:if test="${empty materials }">
    <p>暂无课件</p>
</c:if>


<c:if test="${not empty materials}">

    <table class="material-table">
        <tr>
            <td>章节标题</td>
            <td>上传时间</td>
            <td>课件标题</td>
            <td>查看</td>
            <c:if test="${IsTeacher}">
                <td>删除</td>
            </c:if>
        </tr>
        <c:forEach var="material" items="${materials}">
            <tr>
                <td>${chapter.chapter_title}
                </td>
                <td>${material.upload_date}

                <td>${material.material_title}
                </td>
                <td>
                    <!-- 将文件路径放入 data-file-path 属性 -->
                    <button type="button" class="material-button view-button"
                            onclick="openNewPage('${material.file_path}')">查看
                    </button>
                </td>
                <c:if test="${IsAdmin||IsTeacher}">
                    <td>
                        <form action="${pageContext.request.contextPath}/delete" method="post">
                            <input hidden name="id" value=${material.material_id}>
                            <input type="hidden" name="chapterId" value=${chapter.chapter_id}>
                            <input type="hidden" name="CourseId" value=${chapter.course_id}>
                            <button type="submit" class="material-button delete-button">删除
                            </button>
                        </form>
                    </td>
                </c:if>
            </tr>
        </c:forEach>
    </table>
</c:if>


<c:if test="${IsAdmin||IsTeacher}">
    <!-- 添加上传课件表单 -->
    <div class="upload-container">
        <h2 class="upload-title">上传课件</h2>
        <form action="${pageContext.request.contextPath}/uploadMaterial" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title" class="upload-label">课件标题:</label>
                <input type="text" name="title" id="title" class="upload-input" placeholder="请输入课件标题" required>
            </div>
            <div class="form-group">
                <label for="file" class="upload-label">上传文件:</label>
                <input type="file" name="file" id="file" class="upload-input" required>
            </div>
            <input type="hidden" name="chapterId" value="${chapter.chapter_id}">
            <input type="hidden" name="CourseId" value=${chapter.course_id}>
            <input type="submit" value="上传" class="upload-button">
        </form>
    </div>
</c:if>

<c:if test="${IsTeacher}">
    <a class="back-button" href="${pageContext.request.contextPath}/main_teacher">返回主界面</a>
    <a href="${pageContext.request.contextPath }/logout_teacher" class="logout-button">退出登录</a>
</c:if>


<c:if test="${IsAdmin}">
    <a class="back-button" href="${pageContext.request.contextPath}/main_admin">返回主界面</a>
    <a href="${ pageContext.request.contextPath }/logout_admin" class="logout-button">退出登录</a>
</c:if>

<c:if test="${IsStudent}">
    <a class="back-button" href="${pageContext.request.contextPath}/main_stu">返回主界面</a>
    <a href="${ pageContext.request.contextPath }/logout_stu" class="logout-button">退出登录</a>
</c:if>


</body>
</html>
