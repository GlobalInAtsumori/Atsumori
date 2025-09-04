package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.MemberDAO;
import domain.MemberVO;

@WebServlet("/memberone/login")
public class LoginServlet extends HttpServlet {

    private MemberDAO dao = new MemberDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String memberId = request.getParameter("memberId");
        String password = request.getParameter("password");

        int check = dao.loginCheck(memberId, password);

        if (check == 1) {
            // 로그인 성공
            MemberVO member = dao.getMember(memberId);

            HttpSession session = request.getSession();
            session.setAttribute("loginID", member.getMemberId());
            session.setAttribute("loginPermission", member.getPermission()); // admin / user

            response.sendRedirect(request.getContextPath() + "/mainPage.jsp"); // 로그인 후 메인페이지
        } else {
            // 로그인 실패
            request.setAttribute("error", "아이디 또는 비밀번호가 틀렸습니다.");
            request.getRequestDispatcher("/memberone/login.jsp").forward(request, response);
        }
    }
}
