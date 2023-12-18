package controller;

import com.mysql.cj.util.DnsSrv;
import com.mysql.cj.util.StringInspector;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pojo.Chapter;
import pojo.Course;

import javax.servlet.http.HttpSession;
import java.beans.Introspector;
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
    public String toCourseToChapter(HttpSession session) {
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

    @GetMapping("/loadChapter")
    public void loadChapter(String courseId, HttpSession session) {

        int CourseId = Integer.parseInt(courseId);
        List<Chapter> chapters;
        Course course;

        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            chapters = sqlSession.selectList("mapper.ChapterMapper.ChapterInfo", CourseId);
            course = sqlSession.selectOne("mapper.ChapterMapper.CourseInfo", CourseId);
            course.setTeacher_name(sqlSession.<String>selectOne
                    ("mapper.CourseMapper.FindCourseTeacher", course.getTeacher_id()));
            session.setAttribute("chapters", chapters);
            session.setAttribute("course", course);
        }
    }

    @RequestMapping("/toChapter")
    public String toChapter(@RequestParam("courseId") String courseId, HttpSession session) {
        loadChapter(courseId, session);

        return "Chapter";
    }


    @RequestMapping("/AddChapter")
    public String AddChapter(@RequestParam("chapterId") String id, @RequestParam("chapterTitle") String title,
                             @RequestParam("CourseId") String CourseId, HttpSession session) {
        int chapter_id = Integer.parseInt(id);
        int course_id = Integer.parseInt(CourseId);

        Chapter chapter = new Chapter(chapter_id, course_id, title);

        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.update("mapper.ChapterMapper.AddChapter", chapter);
            sqlSession.commit();
        }
        loadChapter(CourseId, session);
        return "Chapter";
    }

}
