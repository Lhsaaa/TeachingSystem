package pojo;

public class Question {

    private int id;
    private String question_text, option_a, option_b, option_c, option_d;
    private char correct_answer;

    public void setId(int id) {
        this.id = id;
    }

    public void setQuestion_text(String question_text) {
        this.question_text = question_text;
    }

    public void setOption_a(String option_a) {
        this.option_a = option_a;
    }

    public void setOption_b(String option_b) {
        this.option_b = option_b;
    }

    public void setOption_c(String option_c) {
        this.option_c = option_c;
    }

    public void setOption_d(String option_d) {
        this.option_d = option_d;
    }

    public void setCorrect_answer(char correct_answer) {
        this.correct_answer = correct_answer;
    }


    public int getId() {
        return id;
    }

    public String getQuestion_text() {
        return question_text;
    }

    public String getOption_a() {
        return option_a;
    }

    public String getOption_b() {
        return option_b;
    }

    public String getOption_c() {
        return option_c;
    }

    public String getOption_d() {
        return option_d;
    }

    public char getCorrect_answer() {
        return correct_answer;
    }
}
