package com.namiya.model;

public class NamiyaAnswerVO {
	private int pNo;
	private String aTitle;
	private String aContent;
	private String aDate;
	
	//등록시 사용하는 생성자
	public NamiyaAnswerVO(int pNo ,String aTitle, String aContent) {
		super();
		this.pNo = pNo;
		this.aTitle = aTitle;
		this.aContent = aContent;
	}
	//view에 구현할때 사용하는 생성자
	public NamiyaAnswerVO(int pNo, String aTitle, String aContent, String aDate) {
		super();
		this.pNo = pNo;
		this.aTitle = aTitle;
		this.aContent = aContent;
		this.aDate = aDate;
	}

	public NamiyaAnswerVO() {
		super();
	}
	public int getpNo() {
		return pNo;
	}
	public void setpNo(int pNo) {
		this.pNo = pNo;
	}
	public String getaTitle() {
		return aTitle;
	}
	public void setaTitle(String aTitle) {
		this.aTitle = aTitle;
	}
	public String getaContent() {
		return aContent;
	}
	public void setaContent(String aContent) {
		this.aContent = aContent;
	}
	public String getaDate() {
		return aDate;
	}
	public void setaDate(String aDate) {
		this.aDate = aDate;
	}
}
