<%--
  Created by IntelliJ IDEA.
  User: singer
  Date: 2023/12/18
  Time: 23:53
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
    <title>学生答题</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #85C1E9;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            padding: 20px;
        }

        form {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        fieldset {
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        legend {
            font-weight: bold;
        }

        label {
            display: block;
            margin: 10px 0;
        }

        input[type="radio"] {
            margin-right: 5px;
        }

        p {
            font-size: 18px;
            margin-top: 10px;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 20px;
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

        .submit-button {
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
            display: block;
            margin: 20px auto;
            width: 200px; /* 控制按钮的宽度 */
            text-align: center;
        }

        .submit-button:hover {
            background-color: #2980b9;
        }


    </style>
</head>
<body>
<h1>学生答题</h1>

<c:if test="${empty questions}">
    <p>当前无试题发布</p>
</c:if>

<c:if test="${not empty questions}">
    <form id="quizForm" action="javascript:void(0);" onsubmit="submitAnswers()">
        <c:forEach var="question" items="${questions}">
            <fieldset>
                <legend>${question.question_text}</legend>
                <label><input type="radio" name="question_${question.id}" value="A"> A. ${question.option_a}</label>
                <label><input type="radio" name="question_${question.id}" value="B"> B. ${question.option_b}</label>
                <label><input type="radio" name="question_${question.id}" value="C"> C. ${question.option_c}</label>
                <label><input type="radio" name="question_${question.id}" value="D"> D. ${question.option_d}</label>
                <!-- 隐藏正确答案，通过 JavaScript 显示 -->
                <label class="correct-answer" id="correct_answer_${question.id}" style="display: none;">正确答案：${question.correct_answer}</label>
            </fieldset>
        </c:forEach>

        <input type="submit" value="提交答案" class="submit-button">
    </form>
</c:if>

<c:if test="${showAnswers}">
    <h2>答题结果：</h2>
    <c:if test="${not empty questions}">
        <c:forEach var="question" items="${questions}">
            <p>问题：${question.question_text}</p>
            <p>你的答案：${param['question_' + question.id]}</p>
            <p>正确答案：${question.correct_answer}</p>
            <hr>
        </c:forEach>

        <!-- 统计正确答案数量 -->
        <c:set var="correctCount" value="0"/>
        <c:forEach var="question" items="${questions}">
            <c:if test="${param['question_' + question.id] == question.correct_answer}">
                <c:set var="correctCount" value="${correctCount + 1}"/>
            </c:if>
        </c:forEach>

        <!-- 显示正确率 -->
        <p style="margin-top: 20px;">共 ${totalQuestions} 题，正确答案数： ${correctCount}题，正确率为 <span style="color: red;">${((correctCount / totalQuestions) * 100).toFixed(2)}%</span></p>
    </c:if>
</c:if>

<a href="${pageContext.request.contextPath}/main_stu" class="back-button">返回主界面</a>
<a href="${pageContext.request.contextPath}/logout_stu" class="logout-button">退出登录</a>

<script>
    var correctAnswers = [];
    <c:forEach var="question" items="${questions}">
    correctAnswers[${question.id}] = "${question.correct_answer}";
    </c:forEach>

    function submitAnswers() {
        // 获取所有选中的选项
        var selectedOptions = document.querySelectorAll('input[type="radio"]:checked');

        // 初始化正确答案数量
        var correctCount = 0;

        // 遍历每个选中的选项
        selectedOptions.forEach(function (option) {
            var questionId = option.name.replace('question_', '');
            var selectedAnswer = option.value;
            var correctAnswer = correctAnswers[questionId]; // 正确的答案

            // 判断答案是否正确
            if (selectedAnswer === correctAnswer) {
                correctCount++;
            }

            // 显示正确答案
            var correctAnswerLabel = document.getElementById('correct_answer_' + questionId);
            correctAnswerLabel.style.display = 'block';
        });

        // 计算正确率
        var totalQuestions = ${totalQuestions};
        var accuracy = (correctCount / totalQuestions) * 100;

        // 显示结果
        alert("答题结果：\n共 " + totalQuestions + " 题，正确答案数：" + correctCount + " 题，正确率为 " + accuracy.toFixed(2) + "%");

        // 显示正确率
        var accuracyDisplay = document.createElement('p');
        accuracyDisplay.innerHTML = "答题结果：\n共 " + totalQuestions + " 题，正确答案数：" + correctCount + " 题，正确率为 <span style='color: red;'>" + accuracy.toFixed(2) + "%</span>";
        document.body.appendChild(accuracyDisplay);
    }
</script>
</body>

</html>