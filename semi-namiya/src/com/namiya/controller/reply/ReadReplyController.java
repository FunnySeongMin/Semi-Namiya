package com.namiya.controller.reply;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.namiya.controller.Controller;
import com.namiya.model.NamiyaAnswerVO;
import com.namiya.model.NamiyaDAO;

public class ReadReplyController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//번호에 해당하는 답변에 내용 가져오기
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("userVO")==null){
			return "redirect:index.jsp";
		}
		int pno=Integer.parseInt(request.getParameter("pno"));
		NamiyaAnswerVO vo=NamiyaDAO.getInstance().readReply(pno);
		JSONObject json = new JSONObject();
		json.put("aTitle", vo.getaTitle());
		json.put("aContent", vo.getaContent());
		json.put("aDate", vo.getaDate());
		request.setAttribute("responseBody", json);
		return "AjaxView";
	}

}
