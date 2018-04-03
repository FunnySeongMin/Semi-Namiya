package com.namiya.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaUserDAO;

public class TempPasswordController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		int result = NamiyaUserDAO.getInstance().tempPassword(id, password);
		if (result == 0) {
			return "redirect:result/tempPassword_fail.jsp";
		}
		return "redirect:result/tempPassword_success.jsp?id="+id+"&password="+password;
	}

}
