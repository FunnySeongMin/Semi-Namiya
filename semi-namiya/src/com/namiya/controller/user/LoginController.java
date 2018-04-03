package com.namiya.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaUserDAO;
import com.namiya.model.NamiyaUserVO;

public class LoginController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 처리 컨트롤러
				String id = request.getParameter("id");
				String password = request.getParameter("password");
				NamiyaUserVO vo = NamiyaUserDAO.getInstance().login(id, password);
				JSONObject json = null;
				if (vo == null || vo.getGrade().equals("d")) {//아이디-비밀번호 불일치 또는 탈퇴한 회원일 경우  fail 전달
					json = new JSONObject();
					json.put("flag", "fail");
					request.setAttribute("responseBody", json);
				} else {//아이디-비밀번호 일치시 success 전달
					HttpSession session = request.getSession();
					session.setAttribute("userVO", vo);
					json = new JSONObject();
					json.put("flag", "success");
					request.setAttribute("responseBody", json);
					
				}
				return "AjaxView";
	}

}
