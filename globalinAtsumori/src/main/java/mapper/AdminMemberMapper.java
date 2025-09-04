package mapper;

import java.util.List;
import java.util.Map;
import domain.MemberVO;

public interface AdminMemberMapper {

    List<MemberVO> selectMemberList(Map<String,Object> params);
    int countMember(Map<String,Object> params);

    void updatePermission(Map<String,Object> params);
    void suspendMember(Map<String,Object> params);

    List<Map<String,Object>> selectMemberReports(Map<String,Object> params);
    int countMemberReports(Map<String,Object> params);
    Map<String,Object> selectMemberReportById(int reportNo);
    void markReportHandled(int reportNo);
    
    
}
