package dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDTO {
	int reviewNo;
	String reviewTitle;
	String reviewContent;
	int restNo;
	Date createDate;
	int memberNo;
	String memberName;
	String memberId;
	String country;
	String reviewImgUrl;
}
