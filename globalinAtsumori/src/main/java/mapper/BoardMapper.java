package mapper;

import org.apache.ibatis.annotations.Mapper;

import dto.BoardUpdateDTO;

@Mapper
public interface BoardMapper {
	BoardUpdateDTO boardUpdate(int boardNo);
}
