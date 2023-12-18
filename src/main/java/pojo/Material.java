package pojo;

import java.sql.Timestamp;

public class Material {
    private int material_id, chapter_id;
    private String material_title, file_path;
    private Timestamp upload_date;


    public Material() {
    }

    public Material(int chapter_id, String material_title, String file_path) {
        this.chapter_id = chapter_id;
        this.material_title = material_title;
        this.file_path = file_path;
    }

    public int getMaterial_id() {
        return material_id;
    }

    public int getChapter_id() {
        return chapter_id;
    }

    public Timestamp getUpload_date() {
        return upload_date;
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

    public void setUpload_date(Timestamp upload_date) {
        this.upload_date = upload_date;
    }
}
