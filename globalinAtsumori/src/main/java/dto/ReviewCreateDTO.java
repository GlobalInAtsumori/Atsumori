package dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewCreateDTO {
	String reviewTitle;
	String reviewContent;
	int restNo;
}
