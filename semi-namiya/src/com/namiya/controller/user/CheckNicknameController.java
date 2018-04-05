package com.namiya.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaUserDAO;

public class CheckNicknameController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nickName=request.getParameter("nickname");
		String check=NamiyaUserDAO.getInstance().checkNickname(nickName);
		JSONObject json=new JSONObject();
		if(check!=null) {
			json.put("nick","false");
		}else {
			json.put("nick", "true");
		}
		request.setAttribute("responseBody", json);
		return "AjaxView";
	}

}
