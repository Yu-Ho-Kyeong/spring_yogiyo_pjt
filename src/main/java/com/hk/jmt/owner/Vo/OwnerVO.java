package com.hk.jmt.owner.Vo;

import lombok.Data;

@Data
public class OwnerVO {

	private String ownerId;
	
	private String ownerPwd;
	
	private String newPwd;
	
	private String ownerName;
	
	private String ownerMail;
		
	private boolean ownerEnabled;

}
