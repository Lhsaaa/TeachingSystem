package controller;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pojo.Course;
import pojo.Message;
import pojo.Student;
import pojo.Teacher;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Controller
public class CoursesController {

    private final SqlSessionFactory sqlSessionFactory;

    public CoursesController() throws IOException {
        String resource = "mybatis-config.xml";
        try (InputStream inputStream = Resources.getResourceAsStream(resource)) {
            this.sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        }
    }

    @RequestMapping("/toCourse")
    public String toCourse(HttpSession session) {
        loadCourses(session);
        return "Courses";
    }

    //加载未被删除的课程
    @RequestMapping("/loadCourses")
    public void loadCourses(HttpSession session) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            List<Course> courses = sqlSession.selectList("mapper.CourseMapper.SelectCourses");
            session.setAttribute("CourseList", courses);
        }
    }

    //添加课程
    @RequestMapping("/addCourse")
    public String addCourse(@RequestParam("name") String name, @RequestParam("description") String description,
                            @RequestParam("outline") String outline, @RequestParam("tech_id") String tech_id,
                            HttpSession session) {
        Course course = new Course();
        course.setName(name);
        course.setDescription(description);
        course.setOutline(outline);
        course.setTeacher_id(tech_id);

        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.insert("mapper.CourseMapper.AddCourse", course);
            sqlSession.commit();
        }

        return "redirect:/toCourse";  //重定向回课程列表
    }

    //隐藏课程(教师端删除课程)
    @RequestMapping("hiddenCourse")
    public String hiddenCourse(@RequestParam("CourseId") String CourseID) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            int CourseId = Integer.parseInt(CourseID);
            sqlSession.update("mapper.CourseMapper.hiddenCourse", CourseId);
            sqlSession.commit();
        }
        return "redirect:/toCourse";  //重定向回课程列表
    }
}

