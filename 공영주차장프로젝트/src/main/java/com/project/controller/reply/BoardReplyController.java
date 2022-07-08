package com.project.controller.reply;



import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.BoardReplyService;
import com.project.service.ReplyService;

import vo.BoardReplyVO;
import vo.ReplyVO;

@Controller
public class BoardReplyController {

	@Autowired
	BoardReplyService boardReplyService;
	
	//자유게시판 댓글추가
	@RequestMapping("/b_reply_insert")
	public String insert(Model model, BoardReplyVO vo) {
		boardReplyService.reply_insert(vo);
		return "redirect:b_view.do?idx="+vo.getIdx();
	}

	//자유게시판 댓글삭제
	@RequestMapping("/b_reply_delet.do")
	@ResponseBody
	public String reply_delete( ReplyVO vo) {
		int res = boardReplyService.reply_delete(vo);  
		String result="no";
		
		if( res == 1) {
			result="yes";
		}
		
		String finRes= String.format("[{'res':'%s'}]",result);
		
		return finRes;
	}
	
	
	
}
