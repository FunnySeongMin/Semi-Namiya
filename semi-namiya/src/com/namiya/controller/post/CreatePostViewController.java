package com.namiya.controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;

public class CreatePostViewController implements Controller {
	//글쓰는 form이 있는 createPost.jsp 페이지로 넘겨주기 위한 컨트롤러
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userVO") == null) {
			return "redirect:index.jsp";
		}
		request.setAttribute("url", "/post/createPost.jsp");
		return "home.jsp";
	}
}
