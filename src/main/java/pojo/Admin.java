package pojo;

public class Admin {
    private String admin_ID, admin_name, admin_pwd;

    public Admin() {
    }

    public Admin(String ID, String name, String pwd) {
        this.admin_ID = ID;
        this.admin_name = name;
        this.admin_pwd = pwd;
    }

    public void setAdmin_ID(String admin_ID) {
        this.admin_ID = admin_ID;
    }

    public void setAdmin_name(String name) {
        this.admin_name = name;
    }

    public void setAdmin_pwd(String pwd) {
        this.admin_pwd = pwd;
    }

    public String getAdmin_ID() {
        return admin_ID;
    }

    public String getAdmin_name() {
        return admin_name;
    }

    public String getAdmin_pwd() {
        return admin_pwd;
    }
}
