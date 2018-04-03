package com.namiya.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaDAO;

public class CheckIdController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("id");
		String check=NamiyaDAO.getInstance().checkId(id);
		JSONObject json=null;
		if(check!=null) {
			json=new JSONObject();
			json.put("flag","false");
		}else {
			json=new JSONObject();
			json.put("flag", "true");
		}
		request.setAttribute("responseBody", json);
		return "AjaxView";
	}

}
