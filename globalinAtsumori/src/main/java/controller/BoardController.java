package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import dto.BoardUpdateDTO;
import lombok.RequiredArgsConstructor;
import service.BoardService;

@Controller
@RequiredArgsConstructor
public class BoardController {

	private final BoardService boardService;
	
	@PostMapping("updateBoard/{boardNo}")
	public String updateBoard(Model model, @PathVariable("boardNo") int boardNo) {
    	
    	BoardUpdateDTO bud = boardService.update(boardNo);
    	model.addAttribute("updateDto", bud);
    	
		return "content";
    }
}
