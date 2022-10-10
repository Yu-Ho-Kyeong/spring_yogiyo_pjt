package com.hk.jmt.menu.Dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.jmt.common.Dao.AbstractDAO;

import com.hk.jmt.menu.Vo.MenuVO;
import com.hk.jmt.util.Criteria;

@Repository
public class MenuDao extends AbstractDAO{
	
	@Autowired
	private SqlSessionTemplate sql;
	private String ns = "menuSql";
	
	// 메뉴 리스트 
	public List<MenuVO> getMenuList(Criteria cri, Integer storeNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("cri", cri);
		params.put("storeNo", storeNo);
		return sql.selectList(ns + ".getMenuList", params);
	}
	// 메뉴 카운트
	public int countMenu(Criteria cri, Integer storeNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("cri", cri);
		params.put("storeNo", storeNo);
		return sql.selectOne(ns + ".countMenu", params);
	}
	// 메뉴 등록
	public void createMenu(MenuVO menu) {
		sql.insert(ns + ".createMenu", menu);
	}
	// 메뉴 업데이트
	public void updateMenu(MenuVO menu) {
		sql.update(ns + ".updateMenu", menu);
	}
	// 메뉴 삭제
	public int deleteMenu(Integer menuNo, Integer storeNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("menuNo", menuNo);
		params.put("storeNo", storeNo);
		return sql.delete(ns + ".deleteMenu", params);
	}
	// 가게번호로  찾기
	public List<MenuVO> findAllBySno(Integer storeNo){
		return sql.selectList(ns + ".findAllBySno", storeNo);
	}
}
