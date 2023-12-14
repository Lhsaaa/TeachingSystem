package controller;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import pojo.Course;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Controller
public class ChapterController {

    private final SqlSessionFactory sqlSessionFactory;

    public ChapterController() throws IOException {
        String resource = "mybatis-config.xml";
        try (InputStream inputStream = Resources.getResourceAsStream(resource)) {
            this.sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        }
    }

    @RequestMapping("/toCourseToChapter")
    public String toChapter(HttpSession session) {
        loadCourse(session);
        return "CourseToChapter";
    }


    @RequestMapping("/loadCourse")
    public void loadCourse(HttpSession session) {
        List<Course> courses;
        try (SqlSession sqlsession = sqlSessionFactory.openSession()) {
            courses = sqlsession.selectList("mapper.ChapterMapper.loadCourses");

            for (Course course : courses) {
                course.setTeacher_name(sqlsession.<String>selectOne
                        ("mapper.CourseMapper.FindCourseTeacher", course.getTeacher_id()));
            }

        }
        session.setAttribute("courses", courses);
    }

    @RequestMapping("/loadAllCourse")
    public void loadAllCourse(HttpSession session) {
        List<Course> courses;
        try (SqlSession sqlsession = sqlSessionFactory.openSession()) {
            courses = sqlsession.selectList("mapper.ChapterMapper.loadCourses");
            for (Course course : courses) {
                course.setTeacher_name(sqlsession.<String>selectOne
                        ("mapper.CourseMapper.FindCourseTeacher", course.getTeacher_id()));
            }
        }
        session.setAttribute("courses", courses);
    }

}
