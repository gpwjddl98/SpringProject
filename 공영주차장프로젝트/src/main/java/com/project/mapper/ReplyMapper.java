package com.project.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import vo.ReplyVO;



@Mapper
public interface ReplyMapper {
	

	//댓글 전제조회
	public List<ReplyVO> reply_lsit(int idx);
	//댓글 추가
	public void reply_insert(ReplyVO vo);
	//댓글 수정
	public void reply_modify(ReplyVO vo);
	//댓글 삭제
	public int reply_delete(ReplyVO vo);
	
	
}
