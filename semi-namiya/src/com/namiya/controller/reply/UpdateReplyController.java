package com.namiya.controller.reply;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaDAO;

public class UpdateReplyController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//답변 내용 수정
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("userVO")==null){
			return "redirect:index.jsp";
		}
		int pno=Integer.parseInt(request.getParameter(""));
		String aTitle=request.getParameter("");
		String aContent=request.getParameter("");
		NamiyaDAO.getInstance().updateReply(pno,aTitle,aContent);
		return "dispatcher?command=ReadReply?pno="+pno;
	}

}
