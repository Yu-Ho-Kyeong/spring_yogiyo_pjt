package com.hk.jmt.path.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PathController {
	
	@GetMapping("/path/pathJoin")
	public String join(Model model) {
		return "/path/pathJoin.noSearchLayout";
	}

	@GetMapping("/path/pathLogin")
	public String login(Model model) {
		return "/path/pathLogin.empty";
	}
}