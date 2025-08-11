package dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewCreateDTO {
	String restName;
	String address;
	String longitude;
	String latitude;
	String reviewTitle;
	String reviewContent;
}
