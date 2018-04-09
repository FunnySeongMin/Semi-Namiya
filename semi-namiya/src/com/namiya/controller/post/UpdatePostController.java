package com.namiya.controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaDAO;
import com.namiya.model.NamiyaPostVO;
import com.namiya.model.NamiyaUserVO;

public class UpdatePostController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//게시글 내용 수정
		HttpSession session=request.getSession(false);
		NamiyaUserVO userVO = (NamiyaUserVO)session.getAttribute("userVO");
		if(session == null || userVO == null){
			return "redirect:index.jsp";
		}
		int pno=Integer.parseInt(request.getParameter("pNo"));
		String pTitle=request.getParameter("pTitle");
		String pContent=request.getParameter("pContent");
		String lock=request.getParameter("p_lock");
		String id = userVO.getId();
		NamiyaPostVO postVO = NamiyaDAO.getInstance().readPostInfo(pno);
		if(!postVO.getUserVO().getId().equals(userVO.getId())) {
			return "accesslimit.jsp";
		}
		NamiyaDAO.getInstance().updatePost(pno, pTitle, pContent, lock, id);
		String url = "redirect:dispatcher?command=ReadPostInfo&pNo="+pno; 
		return url;
	}

}
