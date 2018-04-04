package com.namiya.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IntroController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String url = "import/intro.jsp";
		request.setAttribute("url", url);
		return "home.jsp";
	}
}
