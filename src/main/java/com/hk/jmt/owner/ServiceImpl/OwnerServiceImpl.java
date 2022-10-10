package com.hk.jmt.owner.ServiceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.hk.jmt.constant.JOB;
import com.hk.jmt.exception.JobFailException;

import com.hk.jmt.owner.Dao.OwnerDao;
import com.hk.jmt.owner.Service.OwnerService;
import com.hk.jmt.owner.Vo.OwnerVO;

import com.hk.jmt.store.Vo.StoreVO;
import com.hk.jmt.util.MailUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OwnerServiceImpl implements OwnerService{

	@Autowired
	private OwnerDao dao;
	@Autowired
	private PasswordEncoder pwdEncoder;
	@Autowired
	private MailUtil mailUtil;
	
	// id 중복 체크
	@Override
	public int idCheck(String ownerId) throws Exception {
		int result = dao.idCheck(ownerId);
		return result; 
	}
	// 회원 id로 비밀번호 확인 (myPage)
	@Override
	public boolean ownerPwdCheck(String ownerId, String ownerPwd) throws Exception {
		String encodedPwd = dao.findPwdById(ownerId);
		System.out.println("encodedPwd: " + encodedPwd);
		System.out.println("memberPwd: " + ownerPwd);
		return pwdEncoder.matches(ownerPwd, encodedPwd);
	}
	// 회원 정보 조회(myPage)
	@Override
	public OwnerVO ownerMyPage(String ownerId) throws Exception{
		return dao.ownerMyPage(ownerId);
	}
	// 회원 정보 조회(myPage)
	public int ownerChangePwd(String ownerId, String ownerPwd) throws Exception {
		return dao.ownerChangePwd(ownerId, pwdEncoder.encode(ownerPwd));
	}
	// 회원정보 - 닉네임 변경(myPage)
	@Override
	public int ownerUpdateName(String ownerId, String ownerName) throws Exception{
		return dao.ownerUpdateName(ownerId, ownerName);
	}
	// 회원 비밀변호 변경(myPage)
	@Override
	public int ownerUpdatePwd(String ownerPwd, String newPwd, String ownerId) throws Exception {
		String encodedPwd = dao.findPwdById(ownerId);
		if (!pwdEncoder.matches(ownerPwd, encodedPwd)) {
			throw new JobFailException(JOB.PASSWORD_CHCEK_FAILURE);
		}
		dao.ownerChangePwd(ownerId, pwdEncoder.encode(newPwd));
		return dao.ownerChangePwd(ownerId, pwdEncoder.encode(newPwd));
	}
	// 회원 탈퇴하기(myPage)
	@Override
	public int ownerUpdate(OwnerVO owner) throws Exception {
		// 비번을 변경할 경우 ChagnePwd()를 호출해 처리
		if(owner.getOwnerPwd() != null && owner.getNewPwd() != null) {
			ownerChangePwd(owner.getOwnerPwd(), owner.getNewPwd());
		}
		log.info("owner : " + owner);
		return dao.ownerUpdate(owner);
	}
	// 회원 탈퇴하기(myPage)
	@Override
	public void ownerDelete(String ownerId) throws Exception {
		dao.ownerDelete(ownerId);
	}
	// 회원 탈퇴하기(myPage)
	@Override
	public void authDelete(String ownerId) throws Exception {
		dao.authDelete(ownerId);
	}
	// 내 가게 전체보기(myStore)
	@Override
	public Object myStoreList(String name) throws Exception {
		List<StoreVO> list = dao.myStoreList(name);
		Map<String , Object> map = new HashMap<>();
		map.put("list", list);
		return map;
	}
	// 내 가게 상세보기(myStore)
	@Override
	public StoreVO ownerMyStoreDetail(Integer storeNo) throws Exception {
		StoreVO store = dao.ownerMyStoreDetail(storeNo);
		System.out.println("서비스 store : " + store);
		return store;
	}
	// 가게 정보변경
	@Override
	public int updateOwnerMyStore(StoreVO store) throws Exception {
		return dao.updateOwnerMyStore(store);
	}

}
