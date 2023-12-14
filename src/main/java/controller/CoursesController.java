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

    @RequestMapping("/toCourse_admin")
    public String toCourses_admin(HttpSession session) {
        loadAllCourses(session);
        return "Courses";
    }

    @RequestMapping("/toCourse")
    public String toCourses(HttpSession session) {
        loadCourses(session);
        return "Courses";
    }

    //加载未被删除的课程
    @RequestMapping("/loadCourses")
    public void loadCourses(HttpSession session) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            List<Course> courses = sqlSession.selectList("mapper.CourseMapper.SelectCourses");
            for (Course course : courses) {
                course.setTeacher_name((String) sqlSession.selectOne
                        ("mapper.CourseMapper.FindCourseTeacher", course.getTeacher_id()));
            }
            session.setAttribute("CourseList", courses);
        }
    }

    //加载所有的课程
    @RequestMapping("/loadAllCourses")
    public void loadAllCourses(HttpSession session) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            List<Course> courses = sqlSession.selectList("mapper.CourseMapper.AllCourses");
            for (Course course : courses) {
                course.setTeacher_name((String) sqlSession.selectOne
                        ("mapper.CourseMapper.FindCourseTeacher", course.getTeacher_id()));
            }
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
    @RequestMapping("/hiddenCourse")
    public String hiddenCourse(@RequestParam("CourseId") String CourseID, HttpSession session) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            int CourseId = Integer.parseInt(CourseID);
            sqlSession.update("mapper.CourseMapper.hiddenCourse", CourseId);
            sqlSession.commit();
        }

        if (session.getAttribute("IsAdmin") != null && (Boolean) session.getAttribute("IsAdmin")) {
            return "redirect:/toCourse_admin";  //重定向回课程列表
        }

        return "redirect:/toCourse";  //重定向回课程列表
    }

    //显示课程
    @RequestMapping("/releaseCourse")
    public String releaseCourse(@RequestParam("CourseId") String CourseID) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            int CourseId = Integer.parseInt(CourseID);
            sqlSession.update("mapper.CourseMapper.releaseCourse", CourseId);
            sqlSession.commit();
        }
        return "redirect:/toCourse_admin";  //重定向回课程列表
    }

    //删除课程
    @RequestMapping("/deleteCourse")
    public String deleteCourse(@RequestParam("CourseId") String CourseID) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            int CourseId = Integer.parseInt(CourseID);
            sqlSession.update("mapper.CourseMapper.deleteCourse", CourseId);
            sqlSession.commit();
        }
        return "redirect:/toCourse_admin";  //重定向回课程列表
    }

}

