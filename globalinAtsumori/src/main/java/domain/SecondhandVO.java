package domain;

import java.sql.Timestamp;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SecondhandVO {
	private int tradePostNo;
	private String tradeTitle;
	private String tradeContent;
	private int cost;
	private String status; //AVAILABLE, TRADING, DONE
	private int customer;
	private Timestamp createDate;
	//멤버번호용
	private int memberNo;
	
	//메인페이지 리스트 출력용
	private String statusLabel; //상태 표기
	private String thumbnailUrl;
}