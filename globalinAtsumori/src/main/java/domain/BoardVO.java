package domain;

import java.sql.Timestamp;

public class BoardVO {
    // 기본 게시글 정보
    private int boardno;
    private String title;
    private String content;
    private Timestamp createdate;
    private int memberno;

    // 작성자 정보
    private String memberId;
    private String memberName;

    // 관리자 페이지용 추가 필드
    private String status;       // "게시됨", "숨김", "삭제"
    private boolean reported;    // 신고 여부
    private String boardType;    // 게시판 종류 (자유게시판, 중고거래 등)

    // Getter & Setter
    public int getBoardno() { return boardno; }
    public void setBoardno(int boardno) { this.boardno = boardno; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Timestamp getCreatedate() { return createdate; }
    public void setCreatedate(Timestamp createdate) { this.createdate = createdate; }

    public int getMemberno() { return memberno; }
    public void setMemberno(int memberno) { this.memberno = memberno; }

    public String getMemberId() { return memberId; }
    public void setMemberId(String memberId) { this.memberId = memberId; }

    public String getMemberName() { return memberName; }
    public void setMemberName(String memberName) { this.memberName = memberName; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public boolean isReported() { return reported; }
    public void setReported(boolean reported) { this.reported = reported; }

    public String getBoardType() { return boardType; }
    public void setBoardType(String boardType) { this.boardType = boardType; }
}
