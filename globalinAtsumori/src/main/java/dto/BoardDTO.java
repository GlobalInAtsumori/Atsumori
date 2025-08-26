package dto;

import java.sql.Timestamp;

// Controller와 View(JSP) 사이에서 데이터를 전달하는 그릇입니다.
public class BoardDTO {
    private int boardno;
    private String title;
    private String content;
    private int memberno;
    private Timestamp createdate;

    public int getBoardno() {
        return boardno;
    }
    public void setBoardno(int boardno) {
        this.boardno = boardno;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public int getMemberno() {
        return memberno;
    }
    public void setMemberno(int memberno) {
        this.memberno = memberno;
    }
    public Timestamp getCreatedate() {
        return createdate;
    }
    public void setCreatedate(Timestamp createdate) {
        this.createdate = createdate;
    }
}
