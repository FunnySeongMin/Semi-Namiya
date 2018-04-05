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

public class ReadMyPostListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//내가 작성한 글의 리스트를 뽑아내기 위해서 우선 내가 작성한 글의 총 개수를 구하고
		//내가 작성한 글을 리스트에 저장한다.
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("userVO")==null){
			return "redirect:index.jsp";
		}
		NamiyaUserVO vo=(NamiyaUserVO) session.getAttribute("userVO");
		if(vo.getGrade()=="a") {//관리자는 접근할 수 없음
			return "redirect:index.jsp";
		}
		String id=vo.getId();
		int myPostCount=NamiyaDAO.getInstance().readMyPostCount(id);
		String nowPage=request.getParameter("pageNo");
		PagingBean pagingBean=null;
		if(nowPage==null){
			pagingBean=new PagingBean(myPostCount);
		}else{
			pagingBean=new PagingBean(myPostCount,Integer.parseInt(nowPage));
		}
		//답변완료인 글만 답글정보(answerVO) 가져오기
		ArrayList<NamiyaPostVO> list=NamiyaDAO.getInstance().myPostList(id,pagingBean);
		for(NamiyaPostVO pvo : list) {
			if(pvo.getReply()==1) {
				pvo.setAnswerVO(NamiyaDAO.getInstance().readReply(pvo.getpNo()));
			}
		}
		ListVO lvo=new ListVO(list, pagingBean);
		request.setAttribute("listvo", lvo);
		request.setAttribute("url", "/post/readMyPost.jsp");
		
		//readPostInfo의 목록버튼에서 해당 페이지 목록을 불러오기 위해 nowPage정보 세션에 저장
		if(nowPage==null) 
			nowPage="1";
		session.setAttribute("My_nowPage", nowPage);
		
		return "home.jsp";
	}

}
