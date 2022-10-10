package com.hk.jmt.util;

public class Criteria {
	
	private int page;				// 현재 페이지
	private int perPageNum;			// 페이지당 게시물 수
	private int rowStart;			// 시작 행
	private int rowEnd;				// 마지막 행
	private String keyword; 		// 검색어 키워드
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
		this.rowStart = ( page - 1 ) * perPageNum + 1;
		this.rowEnd = page * perPageNum;
	}	
	public Criteria(int page) {
		this.page = page;
		this.perPageNum = 10;
		this.rowStart = ( page - 1 ) * perPageNum + 1;
		this.rowEnd = page * perPageNum;
	}	
	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	public int getPage() {
		return page;
	}
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}	
	public int getPerPageNum() {
		return this.perPageNum;
	}	
	public int getRowStart() {
		rowStart = ((page - 1) * perPageNum) + 1;
		return rowStart;
	}	
	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ ", keyword=" + keyword + "]";
	}
	
	
}