package com.namiya.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DispatcherServlet
 */
@WebServlet("/dispatcher")
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DispatcherServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestProcess(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		requestProcess(request,response);
	}

	private void requestProcess(HttpServletRequest request, HttpServletResponse response) {
		//view가 보내는 요청을 제일 처음 받는 곳으로 보낸 정보에서 필요한 정보만을 담아
		//HandlerMapping으로 전달한다.
		try {
		String command=request.getParameter("command");
		Controller c=HandlerMapping.getInstance().create(command);
		String url=c.execute(request, response);
		if(url.startsWith("redirect:"))
			response.sendRedirect(url.substring(9));
		else
			request.getRequestDispatcher(url).forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
