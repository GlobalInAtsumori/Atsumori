package dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RestDetailDTO {
	int restNo;
	String restName;
	String address;
	double longitude;
	double latitude;
	List<ReviewDTO> reviewList;
}
