package com.namiya.controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaDAO;
import com.namiya.model.NamiyaPostVO;
import com.namiya.model.NamiyaUserVO;

public class UpdatePostViewController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		NamiyaPostVO postVO = null;
		HttpSession session = request.getSession(false);
		//String id=request.getParameter("uid");
		//NamiyaUserVO vo=(NamiyaUserVO) session.getAttribute("userVO");
		/*if (session == null || vo == null||vo.getId()!=id) {
			return "redirect:index.jsp";
		}*/
		NamiyaUserVO userVO = (NamiyaUserVO)session.getAttribute("userVO");
		int pNo = Integer.parseInt(request.getParameter("pNo"));
		postVO = NamiyaDAO.getInstance().readPostInfo(pNo);

		
		if(!postVO.getUserVO().getId().equals(userVO.getId())) {
			return "accesslimit.jsp";
		}
		request.setAttribute("postVO", postVO);
		request.setAttribute("url", "/post/updatePost.jsp");
		return "home.jsp";
	}

}