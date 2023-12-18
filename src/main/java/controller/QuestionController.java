package controller;


import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pojo.Question;
import sun.security.timestamp.HttpTimestamper;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Controller
public class QuestionController {

    private final SqlSessionFactory sqlSessionFactory;

    public QuestionController() throws IOException {
        String resource = "mybatis-config.xml";
        try (InputStream inputStream = Resources.getResourceAsStream(resource)) {
            this.sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        }
    }

    //    加载题目
    public void loadQuestion(HttpSession session) {
        List<Question> questions;
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            questions = sqlSession.selectList("mapper.QuestionMapper.loadQuestion");
        }
        session.setAttribute("questions", questions);
        session.setAttribute("totalQuestions", questions.size());
    }

    @RequestMapping("/toTest")
    public String toTest(HttpSession session) {

        loadQuestion(session);

        return "Test";
    }


    @RequestMapping("/deleteQuestion")
    public String deleteQuestion(@RequestParam("questionId") int id, HttpSession session) {

        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.delete("mapper.QuestionMapper.delete", id);
            sqlSession.commit();
        }

        loadQuestion(session);
        return "Question";

    }

    @RequestMapping("/addQuestion")
    public String addQuestion(Question question, HttpSession session) {

        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.delete("mapper.QuestionMapper.add", question);
            sqlSession.commit();
        }

        loadQuestion(session);
        return "Question";

    }

    @RequestMapping("/toAdd")
    public String toAdd() {

        return "AddQuestion";
    }


    @RequestMapping("/toQuestion")
    public String toQuestion(HttpSession session) {

        loadQuestion(session);

        return "Question";
    }


}
