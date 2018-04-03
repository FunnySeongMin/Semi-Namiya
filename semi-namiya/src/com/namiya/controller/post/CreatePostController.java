package com.namiya.controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaDAO;
import com.namiya.model.NamiyaPostVO;
import com.namiya.model.NamiyaUserVO;

public class CreatePostController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//게시글을 등록시키고 그 글의 번호를 반환받아 보여주는 컨트롤러
		HttpSession session=request.getSession(false);
		if(session == null || session.getAttribute("userVO") == null){
			return "redirect:index.jsp";
		}
		String pTitle=request.getParameter("pTitle");
		String pContent=request.getParameter("pContent");
		String lock=request.getParameter("p_lock");
		NamiyaUserVO userVO=(NamiyaUserVO)session.getAttribute("userVO");
		NamiyaPostVO postVO=new NamiyaPostVO(pTitle, pContent, lock, userVO);
		NamiyaDAO.getInstance().createPost(postVO);
		String url = "redirect:dispatcher?command=ReadPostInfo&pNo="+postVO.getpNo(); 
		return url;
	}
}
