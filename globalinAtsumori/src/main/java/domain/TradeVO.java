package domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TradeVO {
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
	private String thumbnailUrl;
	
	//상세페이지 이미지용
	private List<TradeImageVO> image;
	
	//status 라벨용
	public String getStatusLabel() {
		if(status == null) return "";
		switch(status) {
		case "AVAILABLE":
			return "販売中"; 
		case "TRADING":
			return "取引中";
		case "DONE":
			return "販売完了";
		default : 
			return status;
		}
	}
}