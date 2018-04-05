package com.namiya.controller.post;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;
import com.namiya.model.ListVO;
import com.namiya.model.NamiyaDAO;
import com.namiya.model.NamiyaPostVO;
import com.namiya.model.NamiyaUserVO;
import com.namiya.model.PagingBean;

public class ReadPostListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//화면에 보여질 게시글의 목록을 가져오는 컨트롤러
		int totalCount=NamiyaDAO.getInstance().getTotalPostCount();
		String nowPage=request.getParameter("pageNo");
		PagingBean pagingBean=null;
		if(nowPage==null) {
			pagingBean=new PagingBean(totalCount);
		}else {
			pagingBean=new PagingBean(totalCount, Integer.parseInt(nowPage));
		}
		ArrayList<NamiyaPostVO> list=NamiyaDAO.getInstance().readPostList(pagingBean);
		ListVO vo=new ListVO(list, pagingBean);
		request.setAttribute("listvo",vo);
		request.setAttribute("url", "/post/readPostList.jsp");
		
		HttpSession session = request.getSession(false);
		if(session!=null && session.getAttribute("userVO")!=null) {
			NamiyaUserVO userVO = (NamiyaUserVO)session.getAttribute("userVO");
			//읽지 않은 답글수 담기(헤더 갱신)
			int count = NamiyaDAO.getInstance().getUnreadAnswerCount(userVO.getId());
			session.setAttribute("unreadCount", count);
			//readPostInfo의 목록버튼에서 해당 페이지 목록을 불러오기 위해 nowPage정보 세션에 저장
			if(nowPage==null) 
				nowPage="1";
			session.setAttribute("nowPage", nowPage);
		}
		
		
		return "home.jsp";
	}

}
