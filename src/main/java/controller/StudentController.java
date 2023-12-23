package controller;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import pojo.Message;
import pojo.Student;
import pojo.Teacher;
import sun.security.timestamp.HttpTimestamper;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Objects;

@Controller
public class StudentController {

    String resource = "mybatis-config.xml";

    private final SqlSessionFactory sqlSessionFactory;

    public StudentController() throws IOException {
        String resource = "mybatis-config.xml";
        try (InputStream inputStream = Resources.getResourceAsStream(resource)) {
            this.sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        }
    }

    @RequestMapping("/main_stu")
    public String toMainPage() {
        return "StudentMain";
    }

    @RequestMapping("/tologin_stu")
    public String toLoginPage() {
        return "StudentLogin";
    }

    @RequestMapping("toRegister_stu")
    public String toRegister_stu() {
        return "StudentRegister";
    }

    @RequestMapping("Register_stu")
    public String Register_stu(Student stu, Model model, HttpSession session) {

        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.insert("mapper.StudentMapper.Register_stu", stu);
            sqlSession.commit();
            model.addAttribute("register_success","注册成功正在前往登录");
        }
        return "redirect:/tologin_stu";

    }


    //登录验证合法性
    @RequestMapping("/login_stu")
    public String login_stu(Student user, Model model, HttpSession session) {
        // 获取用户名和密码
        String ID = user.getID();
        String Password = user.getPassword();
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            // 从数据库中获取用户名和密码后进行判断
            if (ID != null && Password != null) {
                Student u = sqlSession.selectOne("mapper.StudentMapper.findUserByID", ID);

                if (u == null) {
                    //如果用户名和密码不匹配，转发到登录页面，并进行提醒
                    model.addAttribute("msg", "该用户不存在！");
                    return "StudentLogin";
                } else if (u.getID().equals(ID) && u.getPassword().equals(Password)) {
                    if (u.getBanned() == 1) {
                        model.addAttribute("banMsg", "该用户已被封禁，请联系管理员");
                        return "StudentLogin";
                    }
                    session.setAttribute("user", u);
                    session.setAttribute("IsStudent", true);
                    //用户登录成功，转发到系统首页
                    return "StudentMain";
                }else if(u.getID().equals(ID) && (!Objects.equals(u.getPassword(), Password))){
                    model.addAttribute("msg", "密码错误，请重试！");
                    return "StudentLogin";
                }
            }
        }
        return "StudentLogin";
    }

    //用户退出
    @RequestMapping("/logout_stu")
    public String logout(HttpSession session) {
        // 清除Session
        session.invalidate();

        // 退出登录后重定向到登录页面
        return "redirect:login_stu";
    }

    @RequestMapping("backToWelcome")
    public String backToWelcome(HttpSession session) {
        //清除Session
        session.invalidate();

        return "Welcome";
    }

    //去留言板
    @RequestMapping("/toMessage_stu")
    public String toMessage_stu(Model model, HttpSession session) throws Exception {
        loadMessageList(model, session);
        return "StudentBoard";
    }

    //加载学生留言板列表
    @RequestMapping("/loadMessageList")
    public void loadMessageList(Model model, HttpSession session) throws Exception {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            List<Message> sl = sqlSession.selectList("mapper.MessageMapper.SelectMessages");
            //联合其他表来补充留言表中所需的内容
            for (Message message : sl) {
                Student stu = sqlSession.selectOne("mapper.StudentMapper.FindStudentByID", message.getStu_id());
                message.setStu_name(stu.getName());
                message.setStu_class(stu.getStu_class());

                if (!message.getTeacher_id().equals("20")) {
                    Teacher teacher = sqlSession.selectOne("mapper.TeacherMapper.FindTeacherByID", message.getTeacher_id());
                    message.setTeacher_name(teacher.getTech_name());
                    message.setTeacher_email(teacher.getTeacher_Mail());
                    message.setTeacher_id(message.getTeacher_id());
                }
            }

            session.setAttribute("MessageList_stu", sl);     //添加到session中
        }
    }

    @RequestMapping(value = "/AddMessage", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String AddMessage(@RequestParam("userID") String userID,
                             @RequestParam("content") String content,
                             Model model, HttpSession session) throws Exception {

        if (userID != null) {
            Message message = new Message();
            message.setContent(content);
            message.setStu_id(userID);

            try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
                sqlSession.insert("mapper.MessageMapper.AddMessage", message);
                sqlSession.commit();
            }

            // 插入数据后重新加载留言列表
            loadMessageList(model, session);
        }

        return "StudentBoard";
    }

    @RequestMapping("/toEditInfo")
    public String toEditInfo(HttpSession session) {
        Student student = (Student) session.getAttribute("user");

        return "EditInfo";
    }

    @RequestMapping("/UpdateStudent")
    public String UpdateStudent(Student student, HttpSession session) {

        System.out.println(student.getMajor());
        System.out.println(student.getID());

        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.update("mapper.StudentMapper.UpdateStudent", student);
            sqlSession.commit();
        }

        session.invalidate();
        return "redirect:login_stu";
    }


}
