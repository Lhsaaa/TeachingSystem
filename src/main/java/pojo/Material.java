package pojo;

import java.sql.Timestamp;

public class Material {
    private int material_id, chapter_id;
    private String material_title, file_path;
    private Timestamp upload_time;

    public int getMaterial_id() {
        return material_id;
    }

    public int getChapter_id() {
        return chapter_id;
    }

    public Timestamp getUpload_time() {
        return upload_time;
    }

    public String getFile_path() {
        return file_path;
    }

    public String getMaterial_title() {
        return material_title;
    }


    public void setMaterial_id(int material_id) {
        this.material_id = material_id;
    }

    public void setChapter_id(int chapter_id) {
        this.chapter_id = chapter_id;
    }

    public void setMaterial_title(String material_title) {
        this.material_title = material_title;
    }

    public void setFile_path(String file_path) {
        this.file_path = file_path;
    }

    public void setUpload_time(Timestamp upload_time) {
        this.upload_time = upload_time;
    }
}
