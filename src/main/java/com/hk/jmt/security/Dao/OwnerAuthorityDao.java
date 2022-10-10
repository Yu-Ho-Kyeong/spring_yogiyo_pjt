package com.hk.jmt.security.Dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jboss.logging.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.jmt.security.Vo.OwnerDetailsVO;

@Repository
public class OwnerAuthorityDao {
	
	@Autowired
	private SqlSessionTemplate sql;
	private Logger log = Logger.getLogger(this.getClass());
	private String ns = "ownerAuthoritySql";
	
	// 오너 권한 부여
	public void insertAuth(String username, String authorityName) {
		Map<String, Object> params = new HashMap<>();
		params.put("ownerId", username);
		params.put("authorityName", authorityName);
		sql.insert(ns + ".insertAuth", params);
	}
		 
	// 오너 정보 등록
	public void insertOwner(String username, String password, String ownerName, String ownerMail, char ownerEnabled) {
		Map<String, Object> params = new HashMap<>();
		params.put("ownerId", username);
		params.put("ownerPwd", password);
		params.put("ownerName", ownerName);
		params.put("ownerMail", ownerMail);
		params.put("ownerEnabled", ownerEnabled);
		sql.insert(ns + ".insertOwner", params);
	}
		 
	// 오너 권한 조회
	public List<String> findAuth(String username){
		List<String> findAuth = null;
		findAuth = sql.selectList(ns + ".findAuth", username); 
		return findAuth;
	}
			
	// 오너 로그인
	public OwnerDetailsVO findOwner(String username) {
		OwnerDetailsVO detailsVo = null;
		detailsVo = sql.selectOne(ns + ".findOwner", username);
		return detailsVo;	
		}
	
}
