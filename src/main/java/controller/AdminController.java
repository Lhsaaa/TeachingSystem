package controller;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import pojo.Admin;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;

@Controller
public class AdminController {

    String resource = "mybatis-config.xml";
    InputStream inputStream = Resources.getResourceAsStream(resource);
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
    SqlSession sqlSession = sqlSessionFactory.openSession();

    public AdminController() throws IOException {
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
        sqlSession.insert("mapper.AdminMapper.Register_admin", admin);
        sqlSession.commit();
        return "redirect:/tologin_admin";
    }

    //验证登录合法性
    @RequestMapping("/AdminLogin")
    public String AdminLogin(Admin admin, Model model, HttpSession session) {

        Admin a = sqlSession.selectOne("mapper.AdminMapper.FindUser", admin);

        if (a == null) {
            //如果用户名和密码不匹配，转发到登录页面，并进行提醒
            model.addAttribute("msg", "用户名或密码错误，请重新登录！");
            return "AdminLogin";
        } else if (a.getAdmin_ID().equals(admin.getAdmin_ID()) && a.getAdmin_pwd().equals(admin.getAdmin_pwd())) {
            session.setAttribute("user", a);
            //用户登录成功，转发到系统首页
            return "AdminMain";
        }
        return "AdminLogin";
    }

    //用户退出
    @RequestMapping("/logout_admin")
    public String logout(HttpSession session) {
        // 清除Session
        session.invalidate();
//        清除缓存
        sqlSession.clearCache();
        // 退出登录后重定向到登录页面
        return "redirect:tologin_admin";
    }

}
