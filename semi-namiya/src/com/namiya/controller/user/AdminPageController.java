package com.namiya.controller.user;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaDAO;
import com.namiya.model.NamiyaUserDAO;
import com.namiya.model.NamiyaUserVO;
import com.namiya.model.PagingBean;

public class AdminPageController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전체 회원수를 검색해주는 컨트롤러
		int totalCount=NamiyaUserDAO.getInstance().totalUserCount();
		String nowPage=request.getParameter("pageNo");
		PagingBean pagingBean=null;
		if(nowPage==null) {
			pagingBean=new PagingBean(totalCount);
		}else {
			pagingBean=new PagingBean(totalCount, Integer.parseInt(nowPage));
		}
		int usercount=NamiyaDAO.getInstance().getUserCount();
		ArrayList<NamiyaUserVO> list=NamiyaUserDAO.getInstance().searchUser();
		request.setAttribute("pb", pagingBean);
		request.setAttribute("userCount", usercount);
		request.setAttribute("list", list);
		request.setAttribute("url", "/reply/adminPage.jsp");
		return "home.jsp";
	}

}
