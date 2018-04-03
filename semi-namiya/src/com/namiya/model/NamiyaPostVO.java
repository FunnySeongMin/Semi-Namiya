package com.namiya.model;

public class NamiyaPostVO {
	private int pNo;
	private String pTitle;
	private String pContent;
	private String pDate;
	private String lock;
	private int reply;
	private NamiyaUserVO userVO;
	private NamiyaAnswerVO answerVO;
	
	//답변 등록 시 사용
	public NamiyaPostVO(String pTitle, String pContent, NamiyaUserVO userVO) {
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.userVO = userVO;
	}
	
	//게시글 등록 시 사용
	public NamiyaPostVO(String pTitle, String pContent, String lock, NamiyaUserVO userVO) {
		super();
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.lock = lock;
		this.userVO = userVO;
	}
	
	//게시글 불러올 때사용
	public NamiyaPostVO(int pNo, String pTitle, String pContent, String pDate, String lock, int reply,
			NamiyaUserVO userVO) {
		super();
		this.pNo = pNo;
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pDate = pDate;
		this.lock = lock;
		this.reply = reply;
		this.userVO = userVO;
	}
	//답변있는 글 불러오기
	public NamiyaPostVO(int pNo, String pTitle, String pContent, String pDate, String lock, int reply,
			NamiyaUserVO userVO, NamiyaAnswerVO answerVO) {
		super();
		this.pNo = pNo;
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pDate = pDate;
		this.lock = lock;
		this.reply = reply;
		this.userVO = userVO;
		this.answerVO = answerVO;
	}

	public NamiyaPostVO() {
		super();
	}
	public int getpNo() {
		return pNo;
	}
	public void setpNo(int pNo) {
		this.pNo = pNo;
	}
	public String getpTitle() {
		return pTitle;
	}
	public void setpTitle(String pTitle) {
		this.pTitle = pTitle;
	}
	public String getpContent() {
		return pContent;
	}
	public void setpContent(String pContent) {
		this.pContent = pContent;
	}
	public String getpDate() {
		return pDate;
	}
	public void setpDate(String pDate) {
		this.pDate = pDate;
	}
	public String getLock() {
		return lock;
	}
	public void setLock(String lock) {
		this.lock = lock;
	}
	public int getReply() {
		return reply;
	}
	public void setReply(int reply) {
		this.reply = reply;
	}
	public NamiyaUserVO getUserVO() {
		return userVO;
	}
	public void setUserVO(NamiyaUserVO userVO) {
		this.userVO = userVO;
	}

	public NamiyaAnswerVO getAnswerVO() {
		return answerVO;
	}

	public void setAnswerVO(NamiyaAnswerVO answerVO) {
		this.answerVO = answerVO;
	}
}
