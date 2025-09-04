package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import domain.BoardVO;
import mapper.AdminBoardMapper;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import utils.MyBatisUtil;

public class AdminBoardService {

    private SqlSessionFactory sqlSessionFactory = MyBatisUtil.getSqlSessionFactory();

    public List<BoardVO> getBoardList(int page, int pageSize, String searchType, String searchValue) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            AdminBoardMapper mapper = session.getMapper(AdminBoardMapper.class);
            int start = (page - 1) * pageSize + 1;
            int end = page * pageSize;

            Map<String, Object> params = new HashMap<>();
            params.put("start", start);
            params.put("end", end);
            params.put("searchType", searchType);
            params.put("searchValue", searchValue);

            return mapper.getBoardList(params);
        }
    }

    public int getBoardCount(String searchType, String searchValue) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            AdminBoardMapper mapper = session.getMapper(AdminBoardMapper.class);
            Map<String, Object> params = new HashMap<>();
            params.put("searchType", searchType);
            params.put("searchValue", searchValue);
            return mapper.getBoardCount(params);
        }
    }

    public void updateBoardStatus(int boardno, String status) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            AdminBoardMapper mapper = session.getMapper(AdminBoardMapper.class);
            Map<String, Object> params = new HashMap<>();
            params.put("boardno", boardno);
            params.put("status", status);
            mapper.updateBoardStatus(params);
            session.commit();
        }
    }
}
