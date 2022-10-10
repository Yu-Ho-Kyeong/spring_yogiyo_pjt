package com.hk.jmt.owner.Controller;

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

import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import com.hk.jmt.owner.Service.OwnerService;
import com.hk.jmt.owner.Vo.OwnerVO;
import com.hk.jmt.security.Service.OwnerLoginService;
import com.hk.jmt.store.Vo.StoreVO;

@Controller
public class OwnerController {
	
	@Autowired
	private OwnerService oservice;
	@Autowired
	private OwnerLoginService olService;
	@Autowired
	private Gson gson;
	private static final Logger log = LoggerFactory.getLogger(OwnerController.class);
	
	// 로그인 
	@RequestMapping(value = "/owner/ownerLogin", method = { RequestMethod.GET, RequestMethod.POST } )
	public String loginPage(Authentication authentication, HttpServletRequest request) {
		String uri = request.getHeader("Referer"); //이전 경로
		
		//이전 경로가 로그인 관련 페이지가 아닐 경우에만 저장, 속성값이 null이 되면 오류가 발생하므로 이 경우도 처리한다.
		if(uri != null && !(uri.contains("owner/ownerLogin"))) {
			request.getSession().setAttribute("prevPage", uri);
			return "/owner/ownerLogin.noSearchLayout";
		}
		
		if(authentication != null) {
			
			return "/owner/ownerLogout.noSearchLayout";
			
		} else {
			
			return "/owner/ownerLogin.noSearchLayout";
		} 

	}
	// 회원가입 페이지
	@RequestMapping(value= "/owner/ownerJoin", method = RequestMethod.GET)
	public String joinPage(Model model) {
		return "/owner/ownerJoin.noSearchLayout";
	}
	// 로그아웃 페이지
	@RequestMapping(value= "/owner/ownerLogout", method = RequestMethod.GET)
	public String logoutPage(Model model) {
		return "/owner/ownerLogout.noSearchLayout";
	}
	// id 중복검사
	@RequestMapping(value = "/owner/ownerIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String idCheckPOST(String ownerId) throws Exception {
		int result = oservice.idCheck(ownerId);
			if(result != 0) {
				return "fail";
			}else {
				return "success";
			}
	}
	// 이메일인증
	@RequestMapping(value = "/owner/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String OwnerMail) throws Exception {
		// 뷰에서 넘어온 데이터 확인
		log.info("이메일 데이터 전송 완료");
		log.info("인증메일 : " + OwnerMail);

		// 인증번호 생성
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		log.info("인증번호 : " + checkNum);

		String num = Integer.toString(checkNum);

		return num;
	}
	// 회원 등록
	@RequestMapping(value ="/owner/ownerJoin", method = RequestMethod.POST)
	public String ownerJoin(HttpServletRequest request, Model model, Authentication authentication) throws Exception {
			
		//사용자가 입력한 정보를 파라미터로 넘김
		boolean isInserted = olService.insert(request.getParameter("ownerId"),
											  request.getParameter("ownerPwd"),
											  request.getParameter("ownerName"),
											  request.getParameter("ownerMail")
											  );
		if(isInserted) {
			return "/owner/ownerLogin.noSearchLayout";
		}else {
			return "/owner/ownerJoin.noSearchLayout";
		}
	}
	// 회원 정보 조회
	@Secured("ROLE_OWNER")
	@RequestMapping(value="/owner/ownerMyPage", method=RequestMethod.GET)
	public ModelAndView myPage(Authentication authentication) throws Exception {
		ModelAndView mv = new ModelAndView();
		OwnerVO owner = oservice.ownerMyPage(authentication.getName());
		mv.setViewName("/owner/ownerMyPage.noSearchLayout");
		mv.addObject("owner", gson.toJson(owner));
		return mv;
	}
	// 회원 정보 조회 - 닉네임 변경
	@Secured("ROLE_OWNER")
	@PatchMapping("/owner/ownerName")
	public ResponseEntity<?> ownerUpdateName(Authentication authentication, String ownerName) throws Exception {
		return ResponseEntity.ok(oservice.ownerUpdateName(authentication.getName(), ownerName));
	}
	// 회원 정보 조회 - 비밀번호 변경
	@Secured("ROLE_OWNER")
	@PatchMapping("/owner/ownerPwd")
	public ResponseEntity<?> ownerUpdatePwd(String ownerPwd, String newPwd, Authentication authentication) throws Exception {
		return ResponseEntity.ok(oservice.ownerUpdatePwd(ownerPwd, newPwd, authentication.getName()));
	}
	// 회원 정보 조회 - 전체 변경
	@Secured("ROLE_OWNER")
	@RequestMapping(value="/owner/ownerUpdate", method=RequestMethod.POST)
	public ResponseEntity<?> ownerUpdate(OwnerVO owner, Authentication authentication) throws Exception{
		log.error("------------" + owner);
		log.info("owner : " + owner);
		owner.setOwnerId(authentication.getName());
		return ResponseEntity.ok(oservice.ownerUpdate(owner));		
	}
	// 회원 탈퇴하기(myPage)
	@Secured("ROLE_OWNER")
	@RequestMapping(value="/owner/ownerDelete", method=RequestMethod.GET)
	public ModelAndView ownerDeletePage(Authentication authentication) throws Exception {
		ModelAndView mv = new ModelAndView();
		OwnerVO loginOwner = oservice.ownerMyPage(authentication.getName()); 
		mv.setViewName("/owner/ownerDelete.noSearchLayout");
		mv.addObject("owner", loginOwner);	
		return mv;
	}
	// 회원 탈퇴하기(myPage)
	@Secured("ROLE_OWNER")
//	@ResponseBody    :  Object 를 JSON 으로 변환하여 HTTp body 에 담아서 전송한다
	@RequestMapping(value="/owner/ownerDelete", method=RequestMethod.POST)
	public String ownerDeletePOST(Authentication authentication, String ownerPwd,
								  RedirectAttributes redirectAttr) throws Exception {
		
		boolean checkResult = oservice.ownerPwdCheck(authentication.getName(), ownerPwd);
		
		if(checkResult) {
			oservice.ownerDelete(authentication.getName());
			oservice.authDelete(authentication.getName());
			SecurityContextHolder.clearContext();
			return "redirect:/owner/ownerLogin";	
		}else {
			redirectAttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "redirect:/owner/ownerPwdDelete";
		}
				
	}
	// 내 가게 전체보기 (myStoreList)
	@Secured("ROLE_OWNER")
	@RequestMapping(value="/owner/ownerMyStoreList", method=RequestMethod.GET)
	public ModelAndView myStoreList(Authentication authentication) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.addObject("map", oservice.myStoreList(authentication.getName()));
		mv.setViewName("/owner/ownerMyStoreList.slimSearchLayout");
		return mv;
	}
	// 내 가게 상세보기 (myStore)
	@Secured("ROLE_OWNER")
	@RequestMapping(value="/owner/ownerMyStore", method=RequestMethod.GET)
	public ModelAndView ownerMyStore(Integer storeNo) throws Exception {
		ModelAndView mv = new ModelAndView();
		StoreVO myStore = oservice.ownerMyStoreDetail(storeNo);
		mv.setViewName("/owner/ownerMyStore.noSearchLayout");
		mv.addObject("myStore", myStore);
		return mv;
	} 
	// 회원 로그아웃
	@Secured("ROLE_OWNER")
	@RequestMapping(value = "/owner/logoutAsk")
	public String logout(Model model, HttpSession session) throws Exception{
		System.out.println("logout 완료");
		session.invalidate();
		return "redirect:/";
	}
}
