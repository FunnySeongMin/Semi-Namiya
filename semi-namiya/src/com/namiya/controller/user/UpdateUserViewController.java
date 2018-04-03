package com.namiya.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;

public class UpdateUserViewController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 회원정보 수정뷰로 이동하는 컨트롤러
		HttpSession session = request.getSession(false);
		if (session == null) {
			return "redirect:index.jsp";
		}
		request.setAttribute("url", "user/updateUser.jsp");
		return "home.jsp";
	}

}
