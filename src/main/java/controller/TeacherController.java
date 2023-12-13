package controller;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pojo.Message;
import pojo.Student;
import pojo.Teacher;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Controller
public class TeacherController {


    private final SqlSessionFactory sqlSessionFactory;


    public TeacherController() throws IOException {

        String resource = "mybatis-config.xml";
        try (InputStream inputStream = Resources.getResourceAsStream(resource)) {
            this.sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        }

    }

    @RequestMapping("/main_teacher")
    public String toMainPage() {
        return "TeacherMain";
    }

    @RequestMapping("/tologin_teacher")
    public String toLoginPage() {
        return "TeacherLogin";
    }

    @RequestMapping("/toRegister_teacher")
    public String toTeacherPage() {
        return "TeacherRegister";
    }

    //注册

    @RequestMapping("Register_teacher")
    public String Register_teacher(Teacher teacher, Model model, HttpSession session) {

        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.insert("mapper.TeacherMapper.Register_teacher", teacher);
            sqlSession.commit();
        }

        return "redirect:/tologin_teacher";


    }

    //登录验证合法性
    @RequestMapping("/login_teacher")
    public String login_teacher(Teacher user, Model model, HttpSession session) {
        // 获取用户名和密码
        String ID = user.getTech_ID();
        String Password = user.getTech_pwd();

        // 从数据库中获取用户名和密码后进行判断
        if (ID != null && Password != null) {
            Teacher teacher;
            try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
                teacher = sqlSession.selectOne("mapper.TeacherMapper.FindOneTeacherByID", ID);
            }
            if (teacher == null) {
                //如果用户名和密码不匹配，转发到登录页面，并进行提醒
                model.addAttribute("msg", "用户名或密码错误，请重新登录！");
                return "TeacherLogin";
            } else if (teacher.getTech_ID().equals(ID) && teacher.getTech_pwd().equals(Password)) {
                session.setAttribute("user", teacher);
                //用户登录成功，转发到系统首页
                return "TeacherMain";
            }
        }
        return "TeacherLogin";
    }


    //用户退出
    @RequestMapping("/logout_teacher")
    public String logout(HttpSession session) {

        // 清除Session
        session.invalidate();

        // 退出登录后重定向到登录页面
        return "redirect:login_teacher";
    }

    //去留言板
    @RequestMapping("/toMessage_teacher")
    public String toMessage_stu(Model model, HttpSession session) throws Exception {
        loadMessageList(model, session);
        return "TeacherBoard";
    }

    //加载学生留言板列表
    @RequestMapping("/loadTeacherList")
    public void loadMessageList(Model model, HttpSession session) throws Exception {
        List<Message> messages;
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            messages = sqlSession.selectList("mapper.MessageMapper.SelectMessages");
        }
        //联合其他表来补充留言表中所需的内容
        for (Message message : messages) {
            Student stu;
            try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
                stu = sqlSession.selectOne("mapper.StudentMapper.FindStudentByID", message.getStu_id());
            }
            message.setStu_name(stu.getName());
            message.setStu_class(stu.getStu_class());
            if (message.getTeacher_id() != null) {
                Teacher teacher;
                try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
                    teacher = sqlSession.selectOne("mapper.TeacherMapper.FindTeacherByID", message.getTeacher_id());
                }
                message.setTeacher_name(teacher.getTech_name());
                message.setTeacher_email(teacher.getTeacher_Mail());
            }
        }
        session.setAttribute("MessageList_teacher", messages);    //添加到session中
    }

    //回复学生留言
    @RequestMapping("/reply_teacher")
    public String reply(@RequestParam("messageId") String messageId, @RequestParam("replyContent") String replyContent,
                        @RequestParam("UserID") String UserID, Teacher user, Model model, HttpSession session) throws Exception {

        Message message = new Message();
        message.setId(Integer.parseInt(messageId));
        message.setAns(replyContent);
        message.setTeacher_id(UserID);
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.update("mapper.MessageMapper.Reply", message);
            sqlSession.commit();
        }

        //重新加载留言列表
        loadMessageList(model, session);

        return "TeacherBoard";
    }

    //去往课程管理
    @RequestMapping("/toCourses")
    public String toCourses(HttpSession session) {
        boolean IsAdmin = true;
        session.setAttribute("flag", IsAdmin);
        return "Courses";
    }

}
