package dto;

import java.util.Date;

public class PostAdminDTO {
    private int postNo;        // 글번호
    private String title;      // 제목
    private String writer;     // 작성자
    private Date createdDate;  // 작성일
    private String boardType;  // 게시판 종류 ("자유게시판", "중고거래")
    private String status;     // 게시물 상태 (옵션)

    // getter/setter
    public int getPostNo() { return postNo; }
    public void setPostNo(int postNo) { this.postNo = postNo; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getWriter() { return writer; }
    public void setWriter(String writer) { this.writer = writer; }
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
    public String getBoardType() { return boardType; }
    public void setBoardType(String boardType) { this.boardType = boardType; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
