package com.namiya.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaUserDAO;

public class TotalUserCountController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전체 회원수를 검색해주는 컨트롤러
		int count=NamiyaUserDAO.getInstance().totalUserCount();
		request.setAttribute("userCount", count);
		request.setAttribute("url", "/totalCount.jsp");
		return "/template/layout.jsp";
	}

}
