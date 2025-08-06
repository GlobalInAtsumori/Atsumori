package domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewVO {
	int reviewNo;
	String reviewTitle;
	String reviewContent;
	int memberNo;
	int restNo;
	Date createDate;
}
