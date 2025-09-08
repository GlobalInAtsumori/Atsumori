package domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
    private int memberNo;
    private String memberId;
    private String memberName;
    private String password;
    private String email;
    private String country;
    private String permission;
    // 제재 상태 (없음, 정지, 탈퇴)
    private String sanctionStatus;
}
