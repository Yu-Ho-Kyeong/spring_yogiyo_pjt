package com.hk.jmt.menu.Service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.hk.jmt.menu.Vo.MenuCategoryVO;
import com.hk.jmt.menu.Vo.MenuVO;
import com.hk.jmt.util.Criteria;

public interface MenuService {
	
	// 메뉴 리스트
	public List<MenuVO> getMenuList(Criteria cri, Integer storeNo);
	// 메뉴 카운트
	public int countMenu(Criteria cri, Integer storeNo);
	// 메뉴 등록
	public void createMenu(MenuVO menu, String ownerId) throws IllegalStateException, IOException;
	// 메뉴 삭제
	public int deleteMenu(Integer menuNo, Integer storeNo);
}
