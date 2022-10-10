package com.hk.jmt.menu.Controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hk.jmt.exception.JobFailException;
import com.hk.jmt.menu.Service.MenuService;
import com.hk.jmt.menu.Vo.MenuVO;
import com.hk.jmt.owner.Vo.OwnerVO;
import com.hk.jmt.store.Vo.StoreVO;
import com.hk.jmt.util.Criteria;
import com.hk.jmt.util.MediaUtils;
import com.hk.jmt.util.PageMaker;

@Controller
public class MenuController {
	
	@Autowired
	private MenuService mservice;
	private static final Logger log = LoggerFactory.getLogger(MenuController.class);
	
	// 회원 메뉴 관리
	@Secured("ROLE_OWNER")
	@GetMapping("/owner/ownerMyMenu")
	public ModelAndView myMenu(MenuVO menu) {
		ModelAndView mv = new ModelAndView();
		menu.getStoreNo();
		menu.setStoreNo(menu.getStoreNo());
		mv.setViewName("/owner/ownerMyMenu.noSearchLayout");
		mv.addObject("menu", menu);
		return mv;
	}
	// 메뉴 등록 GET
	@Secured("ROLE_OWNER")
	@GetMapping("/menu/createMenu")
	public String createMenu(Integer storeNo) {
		return "/menu/createMenu";
	}
	// 메뉴 등록 POST
	@Secured("ROLE_OWNER")
	@PostMapping("/menu/createMenu")
	public ResponseEntity<String> createMenu(MenuVO menu, BindingResult result, Integer storeNo, HttpSession session) throws IllegalStateException, IOException {
		log.info("넘어옴...");
		String ownerId = (String)session.getAttribute("ownerId");
		log.info("ownerId : " + ownerId);
		menu.setOwnerId(ownerId);
		menu.setStoreNo(storeNo);
		
		System.out.println("가게 사장 아이디(ownerId) :" + ownerId);
		System.out.println("컨트롤러 : " + storeNo);

		mservice.createMenu(menu, ownerId);
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	// 가게 삭제하기(myStore)
	@Secured("ROLE_OWNER")
	@ResponseBody
	@GetMapping("/menu/deleteMenu")
	public ModelAndView deleteMenuGET(Criteria cri, Integer storeNo, Integer menuNo) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<MenuVO> getMenuList = mservice.getMenuList(cri, storeNo);
		mv.setViewName("/menu/deleteMenu.noSearchLayout");
		mv.addObject("getMenuList", getMenuList);
		return mv;
	}
	// 가게 삭제하기(myStore)
	@Secured("ROLE_OWNER")
	@PostMapping("/menu/deleteMenu")
	public ResponseEntity<?> deleteMenuPOST(Integer storeNo, Integer menuNo){
		return ResponseEntity.ok(mservice.deleteMenu(menuNo, storeNo));
	}
	// 로고 썸네일 보여주기
	// 썸네일 보여주기
	@ResponseBody
	@RequestMapping("/menu/img")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
			
		log.info("FILE NAME: " + fileName);
			
		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			log.info("FILE FORMAT: " + formatName);
				
			MediaType mType = MediaUtils.getMediaType(formatName);
				
			HttpHeaders headers = new HttpHeaders();
				
			in = new FileInputStream(fileName);
				
			if( mType != null) {
				headers.setContentType(mType);
			} else {
				fileName = fileName.substring(fileName.lastIndexOf("_") + 1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859") + "\"");
			}
				
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
				
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		return entity;
	}
	
}
