package com.project.mapper;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import vo.ReviewVO;

@Mapper
public interface ReviewMapper {
	
	//전체조회
	//public List<ReviewVO> list();
	//페이지수만큼 조회
	public List<ReviewVO> count(HashMap<String, Integer> map);
	//전체 게시물 개수 조회
	public int count_list();
	//검색
	public List<ReviewVO> count_search(ReviewVO reviewvo);
	//조회수증가
	public int update(int idx);
	
	//글추가
	public void insert(ReviewVO reviewvo);
	//특정 글 조회
	public ReviewVO list_one(int idx);
	//수정하기
	public int update_modi(ReviewVO vo);
	//삭제하기
	public int delet(ReviewVO vo);
	

	

	
	
	
	
	
}
