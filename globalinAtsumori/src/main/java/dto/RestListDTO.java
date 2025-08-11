package dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RestListDTO {
	int restNo;
	String restName;
	String address;
	double longitude;
	double latitude;
	String reviewTitle;
	String reviewContent;
}
