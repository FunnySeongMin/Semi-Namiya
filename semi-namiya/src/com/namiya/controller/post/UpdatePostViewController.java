package com.namiya.controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaDAO;
import com.namiya.model.NamiyaPostVO;

public class UpdatePostViewController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//게시글 수정 form에 postVO의 내용을 넘겨주기 위한 컨트롤러
		NamiyaPostVO postVO = null;
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userVO") == null) {
			return "redirect:index.jsp";
		}
		int pNo = Integer.parseInt(request.getParameter("pNo"));
		postVO = NamiyaDAO.getInstance().readPostInfo(pNo);
		request.setAttribute("postVO", postVO);
		request.setAttribute("url", "/post/updatePost.jsp");
		return "home.jsp";
	}

}
