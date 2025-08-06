package domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RestaurantVO {
	int restNo;
	String restName;
	String address;
	int longitude;
	int latitude;
}
