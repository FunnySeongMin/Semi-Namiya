package com.namiya.controller.reply;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;
import com.namiya.model.ListVO;
import com.namiya.model.NamiyaDAO;
import com.namiya.model.NamiyaPostVO;
import com.namiya.model.PagingBean;

public class UnAnsweredListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//답변이 달리지 않은 목록을 뽑아낸다. 설명은 겹치는 부분이 많아 생략!
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("userVO")==null){
			return "redirect:index.jsp";
		}
		int totalCount=NamiyaDAO.getInstance().getUnAnsweredPostCount();
		String nowPage=request.getParameter("pageNo");
		PagingBean pagingBean=null;
		if(nowPage==null){
			pagingBean=new PagingBean(totalCount);
		}else{
			pagingBean=new PagingBean(totalCount,Integer.parseInt(nowPage));
		}
		ArrayList<NamiyaPostVO> list=NamiyaDAO.getInstance().unAnsweredList(pagingBean);
		ListVO vo=new ListVO(list, pagingBean);
		System.out.println(list.size());
		request.setAttribute("listvo", vo);
		request.setAttribute("url", "/post/unAnsweredList.jsp");
		return "home.jsp";
	}

}
