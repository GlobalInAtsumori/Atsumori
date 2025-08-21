package domain;

import java.util.Date;
import java.util.List;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TradeVO {
	private int tradePostNo;
	private String tradeTitle;
	private String tradeContent;
	private int cost;
	private String status = "AVAILABLE"; //AVAILABLE, TRADING, DONE
	private Integer customer;
	private Date createDate;
	//멤버번호용
	private int memberNo;
	//메인페이지 리스트 출력용
	private String thumbnailUrl;
	//상세페이지 이미지용
	private List<TradeImageVO> image;
	//날짜 출력용
	public String getDateFormat() {
		LocalDateTime ldt = createDate.toInstant()
				.atZone(ZoneId.systemDefault())
				.toLocalDateTime();
		return ldt.format(DateTimeFormatter.ofPattern("yy/MM/dd"));
	}
	//status 라벨용
	public String getStatusLabel() {
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