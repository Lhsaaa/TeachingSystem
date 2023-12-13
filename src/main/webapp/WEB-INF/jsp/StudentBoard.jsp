<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/9
  Time: 23:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<html>
<head>
    <title>学生留言板</title>

    <style>
        body {
            background: url("image/bg3.png") no-repeat;
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

        .link-container a {
            margin: 20px 0;
        }

        .button-container input[type="submit"],
        .button-container button[type="button"] {
            margin-right: 60px; /* 增加按钮之间的右侧间距，根据需要进行调整 */
        }

        /* 鼠标悬停时的样式 */
        .button-container input[type="submit"]:hover,
        .button-container button[type="button"]:hover {
            background-color: #2980b9; /* 悬停时的背景颜色 */
        }

        .button-container input[type="submit"] {
            background-color: #3498db; /* 修改按钮背景颜色 */
            color: white;
            font-size: 16px;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px; /* 添加圆角边框 */
            transition: background-color 0.3s ease; /* 添加过渡效果 */
            margin-top: 20px;
        }

        textarea {
            background-color: #f2f2f2;
            border: none;
            padding: 10px;
            border-radius: 5px;
        }

        /* 鼠标移入文本域时改变边框颜色 */
        textarea:hover {
            border: 1px solid #ccc;
        }

        /* 设置文本域中的文本字体和颜色 */
        textarea p {
            font-family: Arial, sans-serif;
            color: #333;
            font-size: 16px;
        }

        p {
            border: 1px solid #000000;
            padding: 5px;
        }

        table {
            border-spacing: 0;
            width: 80%;
        }

        table tr {
            height: 40px;
            font-size: 14px;
            color: black;
            line-height: 14px;
            font-weight: 400;
        }

        /* 添加样式到留言列表 */
        ul.message-list {
            list-style: none;
            width: 100%;
            padding: 0;
        }

        ul.message-list li {
            background-color: rgba(242, 242, 242, 0.7); /* 使用 rgba 颜色表示法设置背景 */
            border: 1px solid #ccc;
            border-radius: 5px;
            margin: 10px 0;
            padding: 10px;
            backdrop-filter: blur(5px); /* 使用 backdrop-filter 设置背景模糊 */
        }

        ul.message-list li h3 {
            margin: 0;
        }

        ul.message-list li table {
            margin: 10px 0;
        }

        ul.message-list li table td {
            padding: 5px;
            border: 1px solid #ccc;
        }

        ul.message-list li p {
            margin: 10px 0;
        }

        /* 将添加留言的文本框设置为透明的 */
        .button-container textarea {
            background-color: rgba(0, 0, 0, 0.1); /* 使用 rgba 颜色表示透明背景 */
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 5px;
            width: 50%;

            font-family: "Arial", sans-serif; /* 设置字体样式 */
            font-size: 20px; /* 设置字体大小 */
        }

        /* 鼠标移入文本域时改变边框颜色 */
        .button-container textarea:hover {
            border-color: #2980b9; /* 鼠标移入时的边框颜色 */
        }


    </style>

</head>

<%--<script>--%>
<%--    function submitForm() {--%>
<%--        var content = document.getElementById("content").value;--%>
<%--        sessionStorage.setItem("content", content);--%>
<%--        document.forms["AddMessage"].submit();--%>
<%--    }--%>
<%--</script>--%>

<body>

<h1 style="display: flex ;justify-content: center;font-family:Microsoft YaHei,
    sans-serif;font-size: 70px;font-weight: 400">学生留言板</h1>
<h2 style="color: #FFFFFF;font-family:Microsoft YaHei, sans-serif;font-weight: 300">添加留言</h2>

<div class="button-container">
    <form name="AddMessage" action="${pageContext.request.contextPath}/AddMessage" method="post">
        <textarea name="content" rows="5" cols="100" placeholder="请在此处输入留言"></textarea>
        <br>
        <input hidden name="userID" value="${user.ID}">
        <input type="submit" value="添加留言">
    </form>
</div>


<ul class="message-list">
    <c:if test="${not empty MessageList_stu}">
        <c:forEach var="message" items="${MessageList_stu}">
            <li>
                <table border="1">
                    <tr>
                        <td>留言ID</td>
                        <td>留言时间</td>
                        <td>学号</td>
                        <td>姓名</td>
                        <td>班级</td>
                    </tr>
                    <tr>
                        <td>${message.id}</td>
                        <td>${message.timestamp}</td>
                        <td>${message.stu_id}</td>
                        <td>${message.stu_name}</td>
                        <td>${message.stu_class}</td>
                    </tr>
                </table>
                留言内容:
                <p>${message.content}</p>
                <br>
                <hr>
                <br>
                <c:if test="${message.teacher_id != '20'}">
                    以下是回复老师的信息和内容：<br><br>
                    <table border="1">
                        <tr>
                            <td>老师工号</td>
                            <td>老师姓名</td>
                            <td>老师邮箱</td>
                        </tr>
                        <tr>
                            <td>${message.teacher_id}</td>
                            <td>${message.teacher_name}</td>
                            <td>${message.teacher_email}</td>
                        </tr>
                    </table>
                    老师回复:
                    <p>${message.ans}</p>
                </c:if>
                <c:if test="${message.teacher_id == '20'}">
                    暂无老师回答<br><br>
                </c:if>
                <hr>
            </li>
        </c:forEach>
    </c:if>

    <c:if test="${empty MessageList_stu}">
        <li>暂无留言</li>
    </c:if>
</ul>


<a class="back-button" href="${pageContext.request.contextPath}/main_stu">返回主界面</a>
<a href="${ pageContext.request.contextPath }/logout_stu" class="logout-button">退出登录</a>

</body>
</html>
