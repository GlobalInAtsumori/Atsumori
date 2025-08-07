package domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
	private int memberNo;
	private String memberName;
	private String memberId;
	private String password;
	private String email;
	private String country;
	private String permission;
}
