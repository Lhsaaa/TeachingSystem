package pojo;

public class Chapter {

    private int chapter_id, course_id;
    private String chapter_title, course;

    public Chapter() {

    }

    public Chapter(int chapter_id, int course_id, String chapter_title) {
        this.chapter_id = chapter_id;
        this.course_id = course_id;
        this.chapter_title = chapter_title;
    }


    public void setChapter_id(int chapter_id) {
        this.chapter_id = chapter_id;
    }

    public void setCourse_id(int course_id) {
        this.course_id = course_id;
    }

    public void setChapter_title(String chapter_title) {
        this.chapter_title = chapter_title;
    }


    public int getChapter_id() {
        return chapter_id;
    }

    public int getCourse_id() {
        return course_id;
    }

    public String getChapter_title() {
        return chapter_title;
    }
}
