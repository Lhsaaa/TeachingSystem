package controller;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pojo.Admin;
import pojo.Student;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Controller
public class AdminController {

    private final SqlSessionFactory sqlSessionFactory;

    public AdminController() throws IOException {
        String resource = "mybatis-config.xml";
        try (InputStream inputStream = Resources.getResourceAsStream(resource)) {
            this.sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        }
    }

    @RequestMapping("/tologin_admin")
    public String toAdminLogin() {
        return "AdminLogin";
    }

    @RequestMapping("/toAdminRegister")
    public String toRegisterAdmin() {
        return "AdminRegister";
    }

    //注册用户
    @RequestMapping("/Register_admin")
    public String toAdminRegister(Admin admin, Model model, HttpSession session) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.insert("mapper.AdminMapper.Register_admin", admin);
            sqlSession.commit();
        }
        return "redirect:/tologin_admin";
    }

    @RequestMapping("/main_admin")
    public String toMain_admin() {
        return "AdminMain";
    }

    //验证登录合法性
    @RequestMapping("/AdminLogin")
    public String AdminLogin(Admin admin, Model model, HttpSession session) {

        Admin a;
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            a = sqlSession.selectOne("mapper.AdminMapper.FindUser", admin);
        }
        if (a == null) {
            //如果用户名和密码不匹配，转发到登录页面，并进行提醒
            model.addAttribute("msg", "用户名或密码错误，请重新登录！");
            return "AdminLogin";
        } else if (a.getAdmin_ID().equals(admin.getAdmin_ID()) && a.getAdmin_pwd().equals(admin.getAdmin_pwd())) {
            session.setAttribute("user", a);
            session.setAttribute("IsAdmin", true);
            //用户登录成功，转发到系统首页
            return "AdminMain";
        }
        return "AdminLogin";
    }


    public void loadAll(HttpSession session) {
        List<Student> students;

        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            students = sqlSession.selectList("mapper.AdminMapper.loadAllStudent");
        }

        session.setAttribute("students", students);
    }

    @RequestMapping("/toManageInfo")
    public String toManageInfo(HttpSession session) {
        loadAll(session);
        return "InfoManage";
    }

    //    封禁用户
    @RequestMapping("/Ban")
    public String ban(HttpSession session, @RequestParam("studentId") String studentID) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.update("mapper.AdminMapper.ban", studentID);
            sqlSession.commit();
        }
        loadAll(session);
        return "InfoManage";
    }

    //解禁学生
    @RequestMapping("/UnBan")
    public String Unban(HttpSession session, @RequestParam("studentId") String studentID) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.update("mapper.AdminMapper.unban", studentID);
            sqlSession.commit();
        }
        loadAll(session);
        return "InfoManage";
    }

    //用户退出
    @RequestMapping("/logout_admin")
    public String logout(HttpSession session) {
        // 清除Session
        session.invalidate();

        // 退出登录后重定向到登录页面
        return "redirect:tologin_admin";
    }

}
