package com.hk.jmt.common.Vo;

import lombok.Builder;
import lombok.Data;

@Data
@Builder // 스트링을 여러개 넣을때 순서가 바뀌면 문제되서 불안하면 Builder
public class Mail {
	private String sender;
	private String receiver;
	private String title;
	private String content;
}
