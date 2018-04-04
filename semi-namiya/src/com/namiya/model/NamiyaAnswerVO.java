package com.namiya.model;

public class NamiyaAnswerVO {
	private int pNo;
	private String aTitle;
	private String aContent;
	private String aDate;
	private int readRe;
	
	//등록시 사용하는 생성자
	public NamiyaAnswerVO(int pNo ,String aTitle, String aContent) {
		super();
		this.pNo = pNo;
		this.aTitle = aTitle;
		this.aContent = aContent;
	}
	//view에 구현할때 사용하는 생성자
	public NamiyaAnswerVO(int pNo, String aTitle, String aContent, String aDate, int readRe) {
		super();
		this.pNo = pNo;
		this.aTitle = aTitle;
		this.aContent = aContent;
		this.aDate = aDate;
		this.setReadRe(readRe);
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
	public int getReadRe() {
		return readRe;
	}
	public void setReadRe(int readRe) {
		this.readRe = readRe;
	}
}
