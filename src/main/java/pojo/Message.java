package pojo;

import java.sql.Timestamp;

public class Message {
    private int id;
    private String stu_id, content, teacher_id, ans, stu_name, teacher_name, stu_class, teacher_email;
    private Timestamp timestamp;

    public Message() {

    }

    public Message(int id, String userId, String content, Timestamp timestamp, String teacher_id, String ans) {
        this.id = id;
        this.stu_id = userId;
        this.content = content;
        this.timestamp = timestamp;
        this.teacher_id = teacher_id;
        this.ans = ans;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setStu_name(String stu_name) {
        this.stu_name = stu_name;
    }

    public void setAns(String ans) {
        this.ans = ans;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setTeacher_id(String teacher_id) {
        this.teacher_id = teacher_id;
    }

    public void setTeacher_name(String teacher_name) {
        this.teacher_name = teacher_name;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public void setStu_id(String stu_id) {
        this.stu_id = stu_id;
    }


    public String getStu_id() {
        return stu_id;
    }

    public int getId() {
        return id;
    }

    public String getAns() {
        return ans;
    }

    public String getContent() {
        return content;
    }

    public String getStu_name() {
        return stu_name;
    }

    public String getTeacher_id() {
        return teacher_id;
    }

    public String getTeacher_name() {
        return teacher_name;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setStu_class(String stu_class) {
        this.stu_class = stu_class;
    }

    public String getStu_class() {
        return stu_class;
    }

    public String getTeacher_email() {
        return teacher_email;
    }

    public void setTeacher_email(String teacher_email) {
        this.teacher_email = teacher_email;
    }
}
