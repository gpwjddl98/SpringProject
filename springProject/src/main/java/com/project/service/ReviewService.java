package com.project.service;

import java.util.HashMap;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.ReviewMapper;

import vo.ReviewVO;
import vo.ReplyVO;

@Service
public class ReviewService {
	
	@Autowired
	ReviewMapper reviewMapper;
	
	//전체글조회
	//public List<ReviewVO> list(){
	//	return reviewMapper.list();
	//}
	
	//페이지별로 게시글 조회
	public List<ReviewVO> count(HashMap<String, Integer> map) {
		return reviewMapper.count(map);
	}
	//전체게시물 수 조회
	public int getRowTotal() {
		return reviewMapper.count_list();
	}
	
	//검색
	public List<ReviewVO> count_search(ReviewVO reviewvo){
		return reviewMapper.count_search(reviewvo);
	}
	
	//글작성
	public void insert(ReviewVO reviewvo) {
		reviewMapper.insert(reviewvo);
	}
	
	//수정하기 위한 특정 글 조회
	public ReviewVO list_one(int idx){
		return reviewMapper.list_one(idx);
	}
	//조회수증가
	public int update(int idx){
		return reviewMapper.update(idx);
	}

	
	//수정하기
	
	public int update_modi(ReviewVO vo) {
		return reviewMapper.update_modi(vo);
	}
	//삭제하기
	
	public int delet(ReviewVO vo) {
		return reviewMapper.delet(vo);
	}

	

	
	
	
}
