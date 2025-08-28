package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import domain.MemberVO;

@Mapper
public interface MemberMapper {
	List<MemberVO> findAll();	
}
