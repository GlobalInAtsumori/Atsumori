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
	private String status;
	private int cutomer;
	private Timestamp createDate;
}
