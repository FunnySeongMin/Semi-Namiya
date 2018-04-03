package com.namiya.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaUserDAO;
import com.namiya.model.NamiyaUserVO;

public class UpdateUserController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 회원정보 수정 컨트롤러
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userVO")==null) {
			return "redirect:index.jsp";
		}else {
			System.out.println(session.getAttribute("userVO"));
			NamiyaUserVO userVO = (NamiyaUserVO) session.getAttribute("userVO"); // 로그인한 세션정보 가져오기 
			String nickName = request.getParameter("nickName"); // 수정폼에서 수정한 닉네임
			String password = request.getParameter("password"); // 수정폼에서 수정한 패스워드
			userVO = new NamiyaUserVO(userVO.getId(), nickName, password, userVO.getGrade()); //수정한정보로 UserVO 객체생성 
			NamiyaUserDAO.getInstance().updateUser(userVO); // 수정한정보 DB 반영
			session.setAttribute("userVO", userVO); // 수정한정보로 세션 저장
			return "redirect:result/updateUser_result.jsp";
		}
		
	}
}
