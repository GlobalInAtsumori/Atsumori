package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import domain.BoardVO;
import service.AdminBoardService;

@WebServlet("/admin/board")
public class AdminBoardController extends HttpServlet {

    private AdminBoardService service = new AdminBoardService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1;
        int pageSize = 10;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");

        List<BoardVO> boardList = service.getBoardList(page, pageSize, searchType, searchValue);
        int totalCount = service.getBoardCount(searchType, searchValue);

        request.setAttribute("boardList", boardList);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("page", page);
        request.setAttribute("pageSize", pageSize);

        request.getRequestDispatcher("/admin/adminBoardList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 상태 변경 요청 처리 (숨김/삭제)
        int boardno = Integer.parseInt(request.getParameter("boardno"));
        String status = request.getParameter("status");

        service.updateBoardStatus(boardno, status);
        response.sendRedirect(request.getContextPath() + "/admin/board");
    }
}
