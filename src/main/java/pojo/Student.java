package pojo;

public class Student {
    private String stu_ID, stu_name, stu_pwd, major, stu_class, mail;
    private int banned = 0;


    public void setID(String ID) {
        stu_ID = ID;
    }

    public void setName(String Name) {
        stu_name = Name;
    }

    public void setPassword(String Password) {
        stu_pwd = Password;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public void setStu_class(String stu_class) {
        this.stu_class = stu_class;
    }

    public void setBanned(int banned) {
        this.banned = banned;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }


    public String getMail() {
        return mail;
    }

    public String getID() {
        return stu_ID;
    }

    public String getName() {
        return stu_name;
    }

    public int getBanned() {
        return banned;
    }

    public String getMajor() {
        return major;
    }

    public String getPassword() {
        return stu_pwd;
    }

    public String getStu_class() {
        return stu_class;
    }

}
