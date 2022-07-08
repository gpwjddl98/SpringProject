package com.project.controller.reply;



import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.ReplyService;


import vo.ReplyVO;

@Controller
public class ReplyController {

	@Autowired
	ReplyService replyService;
	
	
	public static final String VIEW_PATH = "/WEB-INF/views/";
	
	 
	
	//댓글 추가
	@RequestMapping("/reply_insert")
	public String insert(Model model, ReplyVO vo) {
		replyService.reply_insert(vo);
		return "redirect:view.do?idx=" + vo.getIdx();
	}

	//댓글 삭제
	@RequestMapping("/reply_delet.do")
	@ResponseBody
	public String reply_delete( ReplyVO vo) {
		int res = replyService.reply_delete(vo); 
		String result="no";
		
		if( res == 1) {
			result="yes";
		}
		
		String finRes= String.format("[{'res':'%s'}]",result);
		
		return finRes;
	}

	
}
