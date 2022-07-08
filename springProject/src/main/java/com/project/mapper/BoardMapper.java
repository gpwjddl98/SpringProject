package com.project.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import vo.BoardVO;
import vo.ParkingVO;

@Mapper
public interface BoardMapper {
	
	//페이지별로 전체글조회
	public List<BoardVO> list(HashMap<String, Integer> map);
	
	public int list_count();
	//글추가
	public void insert(BoardVO boardvo);
	//자세히보기
	public BoardVO select_one(int idx);
	//수정하기
	public int update(BoardVO vo);
	//삭제하기
	public int delet(BoardVO vo);
	//조회수
	public int viewcount(int idx);
	//검색
	public List<BoardVO> count_search(BoardVO boardVO);
	
}
