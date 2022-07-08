package com.project.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.ReplyMapper;

import vo.ReplyVO;

@Service
public class ReplyService {
	
	
	@Autowired
	ReplyMapper replyMapper;
	
	//댓글 전체조회
	public List<ReplyVO> reply_list(int idx){
		return replyMapper.reply_lsit(idx);
	}
	//댓글 추가
	public void reply_insert(ReplyVO vo) {	
		replyMapper.reply_insert(vo);
	}
	//댓글 수정
	//public void reply_modify(ReplyVO vo) {
	//	replyMapper.reply_modify(vo);
	//}
	
	//댓글 삭제
	public int reply_delete(ReplyVO vo) {
		
		return replyMapper.reply_delete(vo);
	}
	
}
