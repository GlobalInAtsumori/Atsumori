package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import domain.SecondhandVO;

@Mapper
public interface SecondhandMapper {
	//전체 글
	List<SecondhandVO> selectAll();
	
	//글쓰기
	void insert(SecondhandVO vo);
	
	//상세페이지
	SecondhandVO selectById(int tradePostNo);
	
	//상태
	void updateStatus(int tradePostNo, String status);
}
