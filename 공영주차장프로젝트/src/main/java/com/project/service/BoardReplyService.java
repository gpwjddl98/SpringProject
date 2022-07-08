package com.project.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.BoardReplyMapper;


import vo.BoardReplyVO;
import vo.ReplyVO;

@Service
public class BoardReplyService {
	
	
	@Autowired
	BoardReplyMapper boardReplyMapper;
	
	//댓글 전체조회
	public List<BoardReplyVO> reply_list(int idx){
		return boardReplyMapper.reply_lsit(idx);
	}
	
	
	//댓글 추가
	public void reply_insert(BoardReplyVO vo){
		 boardReplyMapper.reply_insert(vo); 
	}
	//댓글 삭제
	public int reply_delete(ReplyVO vo) {
		
		return boardReplyMapper.reply_delete(vo);
	}
}
