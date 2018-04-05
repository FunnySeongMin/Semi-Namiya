package com.namiya.controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaAnswerVO;
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
		int pno=Integer.parseInt(request.getParameter("pNo"));
		if(session==null|| vo==null) {//회원 비회원 체크
			url="redirect:index.jsp";
		}else {
			NamiyaPostVO postVO = NamiyaDAO.getInstance().readPostInfo(pno);
			if(postVO == null) {
				return "accesslimit.jsp";
			}
			//댓글 
			if(postVO.getReply()==1) {
				NamiyaAnswerVO aVO=NamiyaDAO.getInstance().readReply(pno);
				postVO.setAnswerVO(aVO);
				if(postVO.getUserVO().getId().equals(vo.getId())&&aVO.getReadRe()==0) {
					//답글 읽음으로 처리
					NamiyaDAO.getInstance().readComment(pno);
					//읽지 않은 답글수 다시 담기
					int count = NamiyaDAO.getInstance().getUnreadAnswerCount(vo.getId());
					session.setAttribute("unreadCount", count);
				}
			}
			//비밀글 여부
			if(postVO.getLock().equals("y")&&vo.getId().equals(postVO.getUserVO().getId())) {
				request.setAttribute("postVO", postVO);
				request.setAttribute("url", "/post/readPostInfo.jsp");
				url="home.jsp";
			}else if(postVO.getLock().equals("y")&&vo.getGrade().equals("a")) {
				request.setAttribute("postVO", postVO);
				request.setAttribute("url", "/post/readPostInfo.jsp");
				url="home.jsp";
			}else if(postVO.getLock().equals("y")&&!vo.getGrade().equals("a")) {
				url="accesslimit.jsp";
			}else {
				request.setAttribute("postVO", postVO);
				request.setAttribute("url", "/post/readPostInfo.jsp");
				url="home.jsp";
			}
		}
		return url;
	}

}
