package com.hk.jmt.ownerReply.Vo;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class OwnerReplyVO {
	private Integer ownerReplyNo;
	private String ownerReplyContent;
	private LocalDateTime ownerReplyDate;
	private String ownerId;
	private Integer reviewNo;
	private Integer storeNo;
}