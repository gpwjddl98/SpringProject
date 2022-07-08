package com.project.exception;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomError {
	public static final String VIEW_PATH = "/WEB-INF/views/";
	@RequestMapping("/error")
	public String goErrorPage() {
		return VIEW_PATH + "error/error.jsp";
	}
}