package dto;

import java.util.List;

import domain.ReviewVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MyReviewDTO {
	List<ReviewDTO> reviewList;
	int totalReviews;
	int totalPages;
	int currentPage;
}
