package pojo;

import java.security.PublicKey;
import java.sql.Timestamp;

public class Course {
    private int id, deleted;
    private String name, description, outline, teacher_id, teacher_name;
    private Timestamp publish_time;

    public Course() {

    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public String getOutline() {
        return outline;
    }

    public String getTeacher_id() {
        return teacher_id;
    }

    public Timestamp getPublish_time() {
        return publish_time;
    }

    public int getDeleted() {
        return deleted;
    }

    public String getTeacher_name() {
        return teacher_name;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setOutline(String outline) {
        this.outline = outline;
    }

    public void setTeacher_id(String teacher_id) {
        this.teacher_id = teacher_id;
    }

    public void setPublish_time(Timestamp publish_time) {
        this.publish_time = publish_time;
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }

    public void setTeacher_name(String teacher_name) {
        this.teacher_name = teacher_name;
    }
}
