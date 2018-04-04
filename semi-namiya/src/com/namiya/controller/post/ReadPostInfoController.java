package com.namiya.controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaDAO;
import com.namiya.model.NamiyaPostVO;
import com.namiya.model.NamiyaUserVO;

public class ReadPostInfoController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//글번호에 맞는 게시글의 내용 뽑아내기
		String url=null;
		HttpSession session = request.getSession(false);
		NamiyaUserVO vo=(NamiyaUserVO) session.getAttribute("userVO");
		if(session==null|| vo==null) {
			url="redirect:index.jsp";
		}else {
			int pno=Integer.parseInt(request.getParameter("pNo"));
			NamiyaPostVO postVO = NamiyaDAO.getInstance().readPostInfo(pno);
			if(postVO.getReply()==1) {
				postVO.setAnswerVO(NamiyaDAO.getInstance().readReply(pno));
			}
			if(postVO.getLock().equals("y")&&vo.getId().equals(postVO.getUserVO().getId())) {
				request.setAttribute("postVO", postVO);
				request.setAttribute("url", "/post/readPostInfo.jsp");
				url="home.jsp";
			}else if(postVO.getLock().equals("y")&&vo.getGrade().equals("a")) {
				request.setAttribute("postVO", postVO);
				request.setAttribute("url", "/post/readPostInfo.jsp");
				url="home.jsp";
			}else if(postVO.getLock().equals("y")&&!vo.getGrade().equals("a")) {
				url="redirect:index.jsp";
			}else {
				request.setAttribute("postVO", postVO);
				request.setAttribute("url", "/post/readPostInfo.jsp");
				url="home.jsp";
			}
		}
		return url;
	}

}
