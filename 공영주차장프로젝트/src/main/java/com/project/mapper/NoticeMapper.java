package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import vo.NoticeVO;

@Mapper
public interface NoticeMapper {
	public List<NoticeVO> search();

	// 자세히보기
	public NoticeVO select_one(int idx);
	
	//조회수
	public int viewcount(int idx);
}
