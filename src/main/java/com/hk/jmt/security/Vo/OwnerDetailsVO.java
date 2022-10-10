package com.hk.jmt.security.Vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class OwnerDetailsVO implements UserDetails {

	private static final long serialVersionUID = 174726374856727L;
	private String ownerId;
	private String ownerPwd;
	private String ownerName;
	private String ownerMail;
	private boolean ownerEnabled;
	private List<GrantedAuthority> authority;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authority;
	}
	
	public void setAuthority(List<String> authList) {
		List<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
		for(int i=0;i<authList.size();i++) {
			auth.add(new SimpleGrantedAuthority(authList.get(i)));
		}
		this.authority=auth;
	}
	
	@Override
	public String getUsername() {
		return ownerId;
	}
	
	@Override
	public String getPassword() {
		return ownerPwd;
	}

	public void setPassword(String password) {
		ownerPwd = password;
	}
	
	public void setUsername(String username) {
		ownerId = username;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	

	@Override
	public boolean isEnabled() {
		return ownerEnabled;
	}
	
	public String getOwnerName() {
		return ownerName;
	}
	
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}

	public String getOwnerMail() {
		return ownerMail;
	}

	public void setOwnerMail(String ownerMail) {
		this.ownerMail = ownerMail;
	}
}