package com.project.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.BoardMapper;

import vo.BoardVO;


@Service
public class BoardService {
	
	@Autowired
	BoardMapper boardMapper;

	//페이지별로 게시글 조회
	public List<BoardVO> list(HashMap<String, Integer> map){
		return boardMapper.list(map);
	}
	//
	public int getRowTotal() {
		return boardMapper.list_count(); 
	}
	//검색
	public List<BoardVO> count_search(BoardVO boardvo){
		return boardMapper.count_search(boardvo); 
	}
	
	//조회수
	public int viewcount(int idx) {
		return boardMapper.viewcount(idx);
	}
	
	//글추가
	public void insert(BoardVO boardvo) {
		boardMapper.insert(boardvo);
	}
	//자세히보기
	public BoardVO select_one(int idx) {
		return boardMapper.select_one(idx);
	}
	//수정하기 위한 특정글 조회
	public BoardVO list_one(int idx) {
		return boardMapper.select_one(idx);
	}
	//수정하기
	public int update(BoardVO vo) {
		return boardMapper.update(vo);
	}
	//삭제하기
	public int delet(BoardVO vo) {
		return boardMapper.delet(vo);
	}
	

	
}
