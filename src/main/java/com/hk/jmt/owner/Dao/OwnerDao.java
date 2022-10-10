package com.hk.jmt.owner.Dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.jmt.common.Dao.AbstractDAO;

import com.hk.jmt.owner.Vo.OwnerVO;
import com.hk.jmt.store.Vo.StoreVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class OwnerDao extends AbstractDAO{
	
	@Autowired
	private SqlSessionTemplate sql;
	
	private String ns = "ownerSql";
	
	// id 중복 체크
	public int idCheck(String ownerId) throws Exception {
		return sql.selectOne(ns + ".idCheck", ownerId);
	} 
	// 회원 id로 비밀번호 확인 (myPage)
	public String findPwdById(String ownerId) {
		return sql.selectOne(ns + ".findPwdById", ownerId);
	}
	// 회원 비밀변호 변경(myPage)
	public int ownerChangePwd(String ownerId, String ownerPwd) {
		Map<String, Object> params = new HashMap<>();
		params.put("ownerId", ownerId);
		params.put("ownerPwd", ownerPwd);
		return sql.update(ns + ".ownerChangePwd", params);
	}
	// 회원 정보 조회(myPage)
	public OwnerVO ownerMyPage(String ownerId) {
		OwnerVO myPage = sql.selectOne(ns + ".ownerMyPage", ownerId);
		return myPage;	
	}
	// 회원정보 - 닉네임 변경(myPage)
	public int ownerUpdateName(String ownerId, String ownerName) {
		Map<String, Object> params = new HashMap<>();
		params.put("ownerId", ownerId);
		params.put("ownerName", ownerName);
		return sql.update(ns + ".ownerUpdateName", params);
	}
	// 회원 정보 변경(myPage)
	public int ownerUpdate(OwnerVO owner) {
		log.info("owner", owner);
		return sql.update(ns + ".ownerUpdate", owner);
	}
	// 회원 탈퇴하기(myPage)
	public void ownerDelete(String ownerId) {
		sql.delete(ns + ".ownerDelete", ownerId);
	}
	// 회원 탈퇴하기(myPage)
	public void authDelete(String ownerId) {
		sql.delete(ns + ".authDelete", ownerId);
	}
	// 내 가게 전체보기(myStore)
	public List<StoreVO> myStoreList(String name) {
		return sql.selectList(ns + ".myStoreList", name);
	}
	// 내 가게 상세보기(myStore)
	public StoreVO ownerMyStoreDetail(Integer storeNo) {
		return sql.selectOne(ns + ".ownerMyStoreDetail", storeNo);
	}
	// 가게 정보변경
	public int updateOwnerMyStore(StoreVO store) {
		return sql.update(ns + ".updateOwnerMyStore", store);
	}
}

