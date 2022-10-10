package com.hk.jmt.main.Controller;


import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.hk.jmt.main.Service.MainService;
import com.hk.jmt.main.Vo.mainCategoryVo;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	
	private static final Logger log = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private MainService service;
	
	//main page
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView main(Locale locale, Model model) {
		ModelAndView mv = new ModelAndView("main.tiles");
	  
		List<mainCategoryVo> category = service.getCategory();
	  
		mv.addObject("viewName", "/main.jsp");
		mv.addObject("category" , category);
		  
		return mv; 
	}
	 
	
	
}
