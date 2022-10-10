package com.hk.jmt.exception;

public class JobFailException extends RuntimeException{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String cause;
	
	public JobFailException(String cause) {
		this.cause = cause;
	}
	
	@Override
	public String getMessage() {
		return this.cause;
	}
}