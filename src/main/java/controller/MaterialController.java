package controller;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pojo.Chapter;
import pojo.Material;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Controller
public class MaterialController {

    private final SqlSessionFactory sqlSessionFactory;

    public MaterialController() throws IOException {
        String resource = "mybatis-config.xml";
        try (InputStream inputStream = Resources.getResourceAsStream(resource)) {
            this.sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        }
    }

    @RequestMapping("/toMaterial")
    public String toMaterial(@RequestParam("chapterId") int chapterId, HttpSession session) {
        loadMaterial(chapterId, session);
        return "Material";
    }

    @RequestMapping("loadMaterial")
    public void loadMaterial(int chapterId, HttpSession session) {
        List<Material> materials;
        Chapter chapter;
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            materials = sqlSession.selectList("mapper.MaterialMapper.loadMaterial", chapterId);
            chapter = sqlSession.selectOne("mapper.ChapterMapper.FindChapterByChapterId", chapterId);
        }
        session.setAttribute("chapter", chapter);
        session.setAttribute("materials", materials);
    }


}
