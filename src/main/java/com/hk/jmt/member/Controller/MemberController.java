package com.hk.jmt.member.Controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.hk.jmt.member.Service.MemberService;

import com.hk.jmt.member.Vo.MemberVO;
import com.hk.jmt.security.Service.MemberLoginService;

/**
 * Handles requests for the application Member page.
 */

@Controller
public class MemberController {
	
	private static final Logger log = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService mservice;
	@Autowired	
	private MemberLoginService mlService; 
	@Autowired
	private Gson gson;

	// 로그인 page
	@RequestMapping(value = "/member/login", method = { RequestMethod.GET, RequestMethod.POST } )
	public String loginPage(Authentication authentication, HttpServletRequest request, Model model) {
		String uri = request.getHeader("Referer"); //이전 경로
		//이전 경로가 로그인 관련 페이지가 아닐 경우에만 저장, 속성값이 null이 되면 오류가 발생하므로 이 경우도 처리한다.
		if(uri != null && !(uri.contains("member/login"))) {
			request.getSession().setAttribute("prevPage", uri);
			return "/member/login.noSearchLayout";
		}
		
		if(authentication != null) {
			
			return "/member/logout.noSearchLayout";
			
		} else {
			
			return "/member/login.noSearchLayout";
		} 

	}
	// 로그아웃 페이지
	@GetMapping("/member/logout")
	public String logoutPage(Model model) {
		return "/member/logout.noSearchLayout";
	}
	// 회원가입 페이지
	@GetMapping("/member/join")
	public String joinPage(Model model) {
		return "/member/join.noSearchLayout";
	}
	// 아이디 찾기 페이지
	@GetMapping("/member/findId")
	public String findIdPage(Model model) {
		return "/member/findId.noSearchLayout";
	}
	// findIdView page
	@RequestMapping(value="/member/findIdView", method=RequestMethod.GET)
	public String findIdViewPage(Model model) {
		return "/member/findIdView.noSearchLayout";
	}
	// 아이디 찾기 POST
	@RequestMapping(value = "/member/findId", method = RequestMethod.POST)
	public ModelAndView findIdPOST(String memberName, String memberMail, Model model) throws Exception {
		ModelAndView mv = new ModelAndView();
		String result = mservice.memberFindId(memberName, memberMail);
		System.out.println("result: " + result);
			
		if(result == null) {
			model.addAttribute("msg", "가입된 정보를 찾을 수 없습니다.");

		} else {
			mv.setViewName("/member/findIdView.noSearchLayout");
			mv.addObject("result", result);	
		}	
		return mv;	
	}
	// 비밀번호 찾기 page
	@GetMapping("/member/findPwd")
	public String findPwdPage(Model model) {
		return "/member/findPwd.noSearchLayout";
	}	
	// 비밀번호 찾기 POST
	@RequestMapping(value="/member/findPwd", method=RequestMethod.POST)
	public String findPwdPOST(Model model, String memberId, String memberMail) throws Exception {
		String result = mservice.memberFindPwd(memberId, memberMail);
		model.addAttribute("msg", "입력하신" + result + "로  비밀번호 재설정 안내 메일이 발송되었습니다.");
		return "/member/findPwd.noSearchLayout";
	}		
	//회원가입 id 중복검사
	@RequestMapping(value = "/member/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String idCheckPOST(String memberId) throws Exception {
		int result = mservice.idCheck(memberId);
			if(result != 0) {
				return "fail";
			}else {
				return "success";
			}
	}
	//회원가입 닉네임 중복검사
	@RequestMapping(value = "/member/memberNicChk", method = RequestMethod.POST)
	@ResponseBody
	public String nameCheckPOST(String memberName) throws Exception {
		int result = mservice.nameCheck(memberName);
			if(result != 0) {
				return "fail";
			}else {
				return "success";
			}
	}
	//회원가입 이메일 인증
	@RequestMapping(value = "/member/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String meberMail) throws Exception {
		// 뷰에서 넘어온 데이터 확인
		log.info("이메일 데이터 전송 완료");
		log.info("인증메일 : " + meberMail);

		// 인증번호 생성
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		log.info("인증번호 : " + checkNum);

		String num = Integer.toString(checkNum);
		return num;
	}
	// 회원 등록
	@RequestMapping(value ="/member/join", method = RequestMethod.POST)
	public String memberJoin(HttpServletRequest request, Model model) throws Exception {
		
		//사용자가 입력한 정보를 파라미터로 넘김
		boolean isInserted = mlService.insert(request.getParameter("memberId"),
										      request.getParameter("memberPwd"),
										      request.getParameter("memberName"),
										      request.getParameter("memberAddress"),
										      request.getParameter("memberPhoneNo"),
										      request.getParameter("memberMail")
										      );
		if(isInserted) {
			return "/member/login.noSearchLayout";
		}else {
			return "/member/join.noSearchLayout";
		}
	}
	// 회원 정보 보기
	@Secured("ROLE_MEMBER")
	@RequestMapping(value="/member/memberMyPage", method=RequestMethod.GET)
	public ModelAndView myPage(Authentication authentication, Model model) throws Exception {
		ModelAndView mv = new ModelAndView();
		MemberVO member = mservice.memberMyPage(authentication.getName());
		mv.setViewName("/member/memberMyPage.noSearchLayout");
		mv.addObject("member", gson.toJson(member));
		return mv;
	}
	// 회원 정보 - 닉네임 변경
	@Secured("ROLE_MEMBER")
	@PatchMapping("/member/memberName")
	public ResponseEntity<?> memberUpdateName(Authentication authentication, String memberName) throws Exception {
		return ResponseEntity.ok(mservice.memberUpdateName(authentication.getName(), memberName));
	}
	// 회원 정보 - 비밀번호 변경
	@Secured("ROLE_MEMBER")
	@PatchMapping("/member/memberPwd")
	public ResponseEntity<?> memberUpdatePwd(String memberPwd, String newPwd, Authentication authentication) throws Exception {
		return ResponseEntity.ok(mservice.memberUpdatePwd(memberPwd, newPwd, authentication.getName()));
	}
	@Secured("ROLE_MEMBER")
	// 회원 정보 - 주소 변경
	@PatchMapping("/member/memberAddress")
	public ResponseEntity<?> memberUpdateAddr(String memberAddress, Authentication authentication) throws Exception {
		return ResponseEntity.ok(mservice.memberUpdateAddr(memberAddress, authentication.getName()));
	}
	// 회원 정보 - 전체 변경
	@RequestMapping(value="/member/memberUpdate", method=RequestMethod.POST)
	public ResponseEntity<?> memberUpdate(MemberVO member, Authentication authentication) throws Exception{
		System.out.println("asd");
		log.error("=============================================================11111");
		member.setMemberId(authentication.getName());
		return ResponseEntity.ok(mservice.memberUpdate(member));		
	}
	// 회원 탈퇴하기(MY PAGE)
	@Secured("ROLE_MEMBER")
	@RequestMapping(value="/member/memberDelete", method=RequestMethod.GET)
	public ModelAndView memberDeletePage(Authentication authentication) throws Exception {
		ModelAndView mv = new ModelAndView();
		MemberVO login = mservice.memberMyPage(authentication.getName()); 
		mv.setViewName("/member/memberDelete.noSearchLayout");
		mv.addObject("member", login);	
		return mv;
	}
	// 회원 탈퇴하기(MY PAGE)
	@Secured("ROLE_MEMBER")
	@RequestMapping(value="/member/memberDelete", method=RequestMethod.POST)
	public String memberDeletePOST(Authentication authentication, String memberPwd,
								   RedirectAttributes redirectAttr) throws Exception {
		boolean result = mservice.memberPwdCheck(authentication.getName(), memberPwd);
		if(result) {
			mservice.memberDelete(authentication.getName());
			mservice.authDelete(authentication.getName());
			SecurityContextHolder.clearContext();
			return "redirect:/member/login";	
		}else {
			redirectAttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "redirect:/member/memberDelete";
		}
			
	}
	//로그아웃 실행
	@RequestMapping(value = "/member/logoutAsk")
	public String logout(Model model, HttpSession session) throws Exception{
		System.out.println("logout 완료");
		session.invalidate();
		return "redirect:/";
	}
	
}