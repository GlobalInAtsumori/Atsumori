package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import domain.RestaurantVO;
import dto.RestDetailDTO;
import dto.RestListDTO;

@Mapper
public interface RestaurantMapper {
	List<RestListDTO> findInBounds(
            @Param("neLat") double neLat,
            @Param("neLng") double neLng,
            @Param("swLat") double swLat,
            @Param("swLng") double swLng
    );
	
	void insertRestuarant(RestaurantVO restaurantVO);
	
	RestaurantVO findRestaurantByNo(int restNo);
}
