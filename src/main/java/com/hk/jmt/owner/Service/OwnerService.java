package com.hk.jmt.owner.Service;

import com.hk.jmt.owner.Vo.OwnerVO;

import com.hk.jmt.store.Vo.StoreVO;

public interface OwnerService {
	
	public int idCheck(String ownerId) throws Exception;
	// 회원 비밀번호 체크
	public boolean ownerPwdCheck(String ownerId, String ownerPwd) throws Exception;
	// 회원 정보 조회(myPage)
	public OwnerVO ownerMyPage(String ownerId) throws Exception;
	// 회원정보 - 닉네임 변경(myPage)
	public int ownerUpdateName(String ownerId, String ownerName) throws Exception;
	// 회원 비밀변호 변경
	public int ownerChangePwd(String ownerId, String ownerPwd) throws Exception;
	// 회원 정보 변경(myPage)
	public int ownerUpdate(OwnerVO owner) throws Exception;
	// 회원 비밀번호 변경
	public int ownerUpdatePwd(String ownerPwd, String newPwd, String ownerId) throws Exception;	
	// 회원 탈퇴
	public void ownerDelete(String ownerId) throws Exception;
	// 회원 탈퇴
	public void authDelete(String ownerId) throws Exception;
	// 내 가게 전체보기(myStore)
	public Object myStoreList(String name) throws Exception;
	// 내 가게 보기(myStore)
	public StoreVO ownerMyStoreDetail(Integer storeNo) throws Exception;
	// 가게 정보변경
	public int updateOwnerMyStore(StoreVO store) throws Exception;

}
