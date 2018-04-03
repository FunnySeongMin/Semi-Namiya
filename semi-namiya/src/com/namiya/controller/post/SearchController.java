package com.namiya.controller.post;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.namiya.controller.Controller;
import com.namiya.model.ListVO;
import com.namiya.model.NamiyaDAO;
import com.namiya.model.NamiyaPostVO;
import com.namiya.model.PagingBean;

public class SearchController implements Controller {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//게시글을 검색하기 위한 컨트롤러
		String category=request.getParameter("category");
		String keyword = request.getParameter("keyword");
		String nowPage=request.getParameter("pageNo");
		int totalCount=NamiyaDAO.getInstance().getSearchPostCount(category,keyword);
		PagingBean pagingBean=null;
		if(nowPage==null) {
			pagingBean=new PagingBean(totalCount);
		}else {
			pagingBean=new PagingBean(totalCount, Integer.parseInt(nowPage));
		}
		ArrayList<NamiyaPostVO> list = new ArrayList<>();
		if(category.equals("제목")) {
			list = NamiyaDAO.getInstance().readPostByTitle(keyword, pagingBean);
		}else if(category.equals("작성자")) {
			list = NamiyaDAO.getInstance().readPostByNickName(keyword, pagingBean);
		}else{
			list = NamiyaDAO.getInstance().readPostByContent(keyword, pagingBean);
		}
		ListVO vo=new ListVO(list, pagingBean);
		request.setAttribute("category", category);
		request.setAttribute("keyword", keyword);
		request.setAttribute("listvo",vo);
		request.setAttribute("url", "/post/searchList.jsp");
		return "home.jsp";
	}

}
