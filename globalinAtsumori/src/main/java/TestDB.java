import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import config.RootConfig;
import domain.MemberVO;
import mapper.MemberMapper;

public class TestDB {
    public static void main(String[] args) {
        // 설정 클래스 기반으로 스프링 컨테이너 생성
        AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext(RootConfig.class);

        // SqlSession 빈 가져오기
        SqlSession sqlSession = ctx.getBean(SqlSession.class);

        // Mapper 인터페이스 가져오기
        MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);

        // 테스트: 게시글 1개 조회 (id = 1)
        List<MemberVO> mList = memberMapper.findAll();
        for(MemberVO m : mList) {
        	System.out.println(m.getMemberNo());
        }

        ctx.close();
    }
}
