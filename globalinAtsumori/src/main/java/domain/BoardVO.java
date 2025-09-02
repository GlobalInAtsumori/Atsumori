package domain;

import java.sql.Timestamp;

// 데이터베이스의 'board2' 테이블과 직접 연결되는 실제 데이터 모델입니다.
public class BoardVO {
    private int boardno;
    private String title;
    private String content;
    private Timestamp createdate;
    private int memberno;
    private String memberId; // 추가
    private String memberName; // 추가
    
    // Getter와 Setter 추가
    public String getMemberId() {
        return memberId;
    }
    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }
    public String getMemberName() {
        return memberName;
    }
    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }
    
    

    // Getter와 Setter 메소드들
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
    public Timestamp getCreatedate() {
        return createdate;
    }
    public void setCreatedate(Timestamp createdate) {
        this.createdate = createdate;
    }
    public int getMemberno() {
        return memberno;
    }
    public void setMemberno(int memberno) {
        this.memberno = memberno;
    }
}
