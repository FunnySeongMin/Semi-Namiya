package com.namiya.model;

public class NamiyaUserVO {
	private String id;
	private String nickName;
	private String password;
	private String grade;
	
	//회원 정보 조회용 생성자(추후에 사용 예정)
	public NamiyaUserVO(String id, String nickName, String password, String grade) {
		super();
		this.id = id;
		this.nickName = nickName;
		this.password = password;
		this.grade = grade;
	}
	
	//회원가입시 사용하는 생성자
	public NamiyaUserVO(String id, String nickName, String password) {
		super();
		this.id = id;
		this.nickName = nickName;
		this.password = password;
	}

	public NamiyaUserVO() {
		super();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

}
