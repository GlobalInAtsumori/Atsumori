package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;

@Controller
public class SecondhandController {
	
	@GetMapping("/secondhandMain")
	public String shMainPage() {
		return "secondhandMain";
	}
	
	@GetMapping("/secondhandWrite")
	public String reviewWritePage() {
    	
		return "secondhandWrite";
    }
	
	
	
}