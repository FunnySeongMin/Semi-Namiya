package com.namiya.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaUserDAO;
import com.namiya.model.NamiyaUserVO;

public class DeleteUserController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//회원탈퇴
		HttpSession session = request.getSession(false);
		if(session == null) {
			return "redirect:index.jsp";
		}
		NamiyaUserVO userVO = (NamiyaUserVO)session.getAttribute("userVO"); // 로그인한 세션정보 가져오기
		NamiyaUserDAO.getInstance().deleteUser(userVO.getId()); // 세션정보에 저장된 id로 DB반영
		session.invalidate();
		return "redirect:result/deleteUser_result.jsp";
	}

}
