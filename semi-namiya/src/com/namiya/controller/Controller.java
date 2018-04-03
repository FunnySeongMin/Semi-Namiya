package com.namiya.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Controller {
	//다중상속기능을 만들어 효과적으로 HandlerMapping를 사용하기 위한 인터페이스
	public String execute(HttpServletRequest request,HttpServletResponse response)throws Exception;
}
