package com.hk.jmt.ownerReply.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hk.jmt.ownerReply.Service.OwnerReplyService;
import com.hk.jmt.ownerReply.Vo.OwnerReplyVO;

@Controller
public class OwnerRplyController {
	
	@Autowired
	private OwnerReplyService orservice;
	
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public @ResponseBody String test() {
		
		return "running";
	}
	
	// 사장 댓글달기 GET
	@Secured("ROLE_OWNER")
	@RequestMapping(value = "/ownerReply/createReply", method = RequestMethod.GET)
	public ModelAndView createReplyPage(OwnerReplyVO reply) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/ownerReply/createReply.noSearchLayout");
		mv.addObject("reply", reply);
		
		return mv;	
	}
	// 사장 댓글달기 POST
	@Secured("ROLE_OWNER")
	@PostMapping("/ownerReply/createReply")
	public String createReply(OwnerReplyVO reply, Integer storeNo, Integer reviewNo, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String ownerId = (String)session.getAttribute("ownerId");
		
		reply.setOwnerId(ownerId);
		reply.setReviewNo(reviewNo);
		reply.setStoreNo(storeNo);
	
		orservice.createReply(reply, ownerId);

		return "redirect:/";
	}
}
