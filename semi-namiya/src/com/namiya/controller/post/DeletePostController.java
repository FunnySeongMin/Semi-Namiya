package com.namiya.controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaDAO;
import com.namiya.model.NamiyaPostVO;
import com.namiya.model.NamiyaUserVO;

public class DeletePostController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//게시글 삭제를 위한 컨트롤러
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("userVO")==null){
			return "redirect:index.jsp";
		}
		
		int pno=Integer.parseInt(request.getParameter("pNo"));
		NamiyaPostVO postVO = NamiyaDAO.getInstance().readPostInfo(pno);
		NamiyaUserVO userVO = (NamiyaUserVO)session.getAttribute("userVO");
		if(!postVO.getUserVO().getId().equals(userVO.getId())) {
			System.out.println(postVO.getUserVO().getId());
			System.out.println(userVO.getId());
			return "accesslimit.jsp";
		}
		NamiyaDAO.getInstance().deletePost(pno, userVO.getId());
		return "redirect:dispatcher?command=ReadPostList";
	}

}
