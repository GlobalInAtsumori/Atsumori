package controller;

import dto.PostAdminDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import service.AdminBoardService;

import java.util.List;

@Controller
public class AdminBoardController {

    private final AdminBoardService adminBoardService;

    public AdminBoardController(AdminBoardService adminBoardService) {
        this.adminBoardService = adminBoardService;
    }

    @GetMapping("/admin/posts")
    public String getAllPosts(@RequestParam(defaultValue = "1") int page,
                              @RequestParam(defaultValue = "10") int pageSize,
                              Model model) {
        List<PostAdminDTO> allPosts = adminBoardService.getAllPosts(page, pageSize);
        model.addAttribute("allPosts", allPosts);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);
        return "adminBoard"; // adminBoard.jsp
    }
}
