<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/18
  Time: 22:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>试题编辑与发布</title>
    <style>
        body {
            background: url("images/bg1.png") no-repeat;
            background-size: cover;
            font-family: Arial, sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .box {
            width: 50%;
            margin: auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label {
            font-size: 16px;
            font-weight: bold;
            margin-right: 10px;
        }

        input[type="text"] {
            font-size: 14px;
            height: 30px;
            width: 300px;
            padding: 5px;
            margin-bottom: 10px;
            border: 1px solid #9ac4e3; /* 淡蓝色边框 */
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.4); /* 背景模糊透明 */
            backdrop-filter: blur(5px);
            transition: border-color 0.3s ease, background-color 0.3s ease; /* 过渡效果 */
        }

        input[type="text"]:hover {
            border-color: #3498db; /* 鼠标悬停时的边框颜色 */
            background-color: rgba(255, 255, 255, 0.9); /* 鼠标悬停时的背景颜色 */
        }

        input[type="submit"] {
            background-color: #3498db;
            color: white;
            font-size: 16px;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        hr {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h1 style="display: flex; justify-content: center; font-family: 'Microsoft YaHei', sans-serif; font-size: 70px; font-weight: 400;">
    试题编辑与发布</h1>
<hr>
<br>

<div class="box">
    <form action="${pageContext.request.contextPath}/addQuestion" method="post">

        <label>题干:</label>
        <input type="text" name="question_text">
        <br>
        <label>选项A:</label>
        <input type="text" name="option_a">
        <label>选项B:</label>
        <input type="text" name="option_b">
        <br>
        <label>选项C:</label>
        <input type="text" name="option_c">
        <label>选项D:</label>
        <input type="text" name="option_d">
        <br>
        <br>
        <label>正确答案:</label>
        <input type="text" name="correct_answer">
        <br>
        <hr>
        <input type="submit" value="发布试题">
    </form>
</div>
</body>
</html>
