package dto;

import org.springframework.web.multipart.MultipartFile;

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
	MultipartFile imageFile;
	
}
