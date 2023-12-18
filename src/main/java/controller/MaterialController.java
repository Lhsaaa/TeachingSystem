package controller;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pojo.Chapter;
import pojo.Material;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

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

    @RequestMapping("/loadMaterial")
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


    @PostMapping("/uploadMaterial")
    public String handleMaterialUpload(@RequestParam("title") String title, MultipartFile file,
                                       @RequestParam("chapterId") String chapterId, HttpServletRequest request,
                                       HttpSession session) throws Exception {

        // 获取章节ID
        int id = Integer.parseInt(chapterId);
        // 生成唯一的文件名，包括文件拓展名
        String originalFilename = file.getOriginalFilename();
        String fileExtension = FilenameUtils.getExtension(originalFilename);
        String uniqueFilename = UUID.randomUUID() + "_" + title + "." + fileExtension;

        // 存储文件到服务器
        String uploadPath = request.getSession().getServletContext().getRealPath("/upload");
        File dir = new File(uploadPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        File newFile = new File(dir, uniqueFilename);
        file.transferTo(newFile);

        title = title + "." + fileExtension;
        Material material = new Material(id, title, uniqueFilename);
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.insert("mapper.MaterialMapper.Upload", material);
            sqlSession.commit();
        }

        loadMaterial(id, session);
        return "Material";
    }


    @PostMapping("/viewMaterial")
    public void viewMaterial(@RequestParam("filePath") String filePath, HttpServletResponse response) {
        // 处理文件路径，获取文件的实际路径
        String realFilePath = "http://localhost:8086/TeachingSystem_war_exploded/upload/" + filePath;

        try {
            // 使用 HttpServletResponse 发送重定向
            response.sendRedirect(realFilePath);
        } catch (IOException e) {
            // 处理重定向时可能出现的异常
            e.printStackTrace();
        }
    }

    @RequestMapping("/delete")
    public String delete(@RequestParam("id") int id, @RequestParam("chapterId") int chapterId, HttpSession session) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            sqlSession.delete("mapper.MaterialMapper.Delete", id);
            sqlSession.commit();
        }

        loadMaterial(chapterId, session);
        return "Material";
    }


}
