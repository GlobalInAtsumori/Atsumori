package service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import domain.MemberVO;
import mapper.AdminMemberMapper;

@Service
public class AdminMemberService {

    @Resource
    private AdminMemberMapper mapper;

    public Map<String,Object> getMemberList(int page, int size, String searchType, String keyword) {
        int startRow = (page-1)*size + 1;
        int endRow = page*size;
        Map<String,Object> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        params.put("searchType", searchType);
        params.put("keyword", keyword);
        List<MemberVO> list = mapper.selectMemberList(params);
        int total = mapper.countMember(params);
        Map<String,Object> res = new HashMap<>();
        res.put("list", list);
        res.put("total", total);
        return res;
    }

    public void changePermission(int memberNo, String permission) {
        Map<String,Object> p = new HashMap<>();
        p.put("memberNo", memberNo);
        p.put("permission", permission);
        mapper.updatePermission(p);
    }

    public void suspendMember(int memberNo, Date suspendUntil, String reason) {
        Map<String,Object> p = new HashMap<>();
        p.put("memberNo", memberNo);
        p.put("suspendUntil", suspendUntil);
        p.put("reason", reason);
        mapper.suspendMember(p);
    }

    public Map<String,Object> getMemberReports(int page, int size, String searchType, String keyword) {
        int startRow = (page-1)*size + 1;
        int endRow = page*size;
        Map<String,Object> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        params.put("searchType", searchType);
        params.put("keyword", keyword);
        List<Map<String,Object>> list = mapper.selectMemberReports(params);
        int total = mapper.countMemberReports(params);
        Map<String,Object> res = new HashMap<>();
        res.put("list", list);
        res.put("total", total);
        return res;
    }

    public Map<String,Object> getMemberReportDetail(int reportNo) {
        return mapper.selectMemberReportById(reportNo);
    }

    public void handleReport(int reportNo) {
        mapper.markReportHandled(reportNo);
    }
}
