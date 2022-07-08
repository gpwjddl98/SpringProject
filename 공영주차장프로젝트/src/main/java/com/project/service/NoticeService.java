package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.NoticeMapper;

import vo.BoardVO;
import vo.NoticeVO;

@Service
public class NoticeService {

	@Autowired
	NoticeMapper noticeMapper;

	public List<NoticeVO> searchList() {

		return noticeMapper.search();
	}

	// 자세히보기
	public NoticeVO select_one(int idx) {
		return noticeMapper.select_one(idx);
	}
	
	//조회수
	public int viewcount(int idx) {
		return noticeMapper.viewcount(idx);
	}
}
