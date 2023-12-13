package pojo;

public class Teacher {
    private String tech_ID, tech_name, tech_pwd, teacher_Mail;

    public Teacher() {
    }


    public void setTech_ID(String ID) {
        tech_ID = ID;
    }

    public void setTech_name(String name) {
        tech_name = name;
    }

    public void setTech_pwd(String pwd) {
        tech_pwd =pwd;
    }

    public void setTeacher_Mail(String teacher_Mail) {
        this.teacher_Mail = teacher_Mail;
    }

    public String getTech_name() {
        return tech_name;
    }

    public String getTeacher_Mail() {
        return teacher_Mail;
    }

    public String getTech_ID() {
        return tech_ID;
    }

    public String getTech_pwd() {
        return tech_pwd;
    }
}
