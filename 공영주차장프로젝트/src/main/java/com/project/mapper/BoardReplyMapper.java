package com.project.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import vo.BoardReplyVO;
import vo.ReplyVO;



@Mapper
public interface BoardReplyMapper {
	

	//댓글 전제조회
	public List<BoardReplyVO> reply_lsit(int idx);
	//댓글 추가
	public void reply_insert(BoardReplyVO vo);
	//댓글 삭제
	public int reply_delete(ReplyVO vo);	
	
}
