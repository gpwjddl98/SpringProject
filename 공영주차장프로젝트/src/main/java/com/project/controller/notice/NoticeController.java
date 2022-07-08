package com.project.controller.notice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.service.NoticeService;
import com.project.service.UserService;

import vo.NoticeVO;
import vo.UserVO;

@Controller
public class NoticeController {

	public static final String VIEW_PATH = "/WEB-INF/views/";

	@Autowired
	NoticeService noticeService;

	@Autowired
	UserService userService;

	// 전체글조회
	@RequestMapping("notice")
	public String list(Model model, HttpServletRequest request, UserVO userVO) {

		List<NoticeVO> list = noticeService.searchList();
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setContent(list.get(i).getContent().replace("\r\n", "<br>"));
			System.out.println(list.get(0));
		}
		model.addAttribute("list", list);

		request.getSession().removeAttribute("show");

		// 로그인 세션 받아오기
		// 로그인 session이 있다면 해당 정보넘겨주기
		HttpSession session;

		if (request.isRequestedSessionIdValid()) {
			session = request.getSession();

			if (session.getAttribute("login") == null) {
				System.out.println("세션없는곳으로 들어옴");
				return VIEW_PATH + "notice.jsp";
			} else {
				System.out.println("세션있는곳으로 들어옴");
				System.out.println("로그인 세션 : " + session.getAttribute("login"));
				if (((String) session.getAttribute("login")).equals("common")) {
					String userId = (String) session.getAttribute("userId");
					List<UserVO> userVo = userService.getList(userId);
					System.out.println("userId = " + (String) session.getAttribute("userId"));
					model.addAttribute("userList", userVo);

				} else if (((String) session.getAttribute("login")).equals("naver")) {
					String userNick = (String) session.getAttribute("userNick");
					String userPhotoName = (String) session.getAttribute("userPhotoName");
					userVO.setUserNick(userNick);
					userVO.setUserPhotoName(userPhotoName);
					List<UserVO> userVo = new ArrayList<UserVO>();
					userVo.add(userVO);
					model.addAttribute("userList", userVo);
				}
			}
		}

		return VIEW_PATH + "notice.jsp";
	}

	// 자세히보기 폼으로 이동
	@RequestMapping("noticeIn")
	public String select_one(Model model, int idx, HttpServletRequest request, UserVO userVO) {
		NoticeVO vo = noticeService.select_one(idx);
		vo.setContent(vo.getContent().replace("\n", "<br>"));
		System.out.println("dddd : " + vo.getContent());
		model.addAttribute("vo", vo);

		// 조회수증가
		HttpSession session2 = request.getSession();
		String show = (String) session2.getAttribute("show");
		if (show == null) {
			int res = noticeService.viewcount(idx);
			session2.setAttribute("show", "0");
		}

		// 로그인 세션 받아오기
		// 로그인 session이 있다면 해당 정보넘겨주기
		HttpSession session;

		if (request.isRequestedSessionIdValid()) {
			session = request.getSession();

			if (session.getAttribute("login") == null) {
				System.out.println("세션없는곳으로 들어옴");
				return VIEW_PATH + "notice_in.jsp";
			} else {
				System.out.println("세션있는곳으로 들어옴");
				System.out.println("로그인 세션 : " + session.getAttribute("login"));
				if (((String) session.getAttribute("login")).equals("common")) {
					String userId = (String) session.getAttribute("userId");
					List<UserVO> userVo = userService.getList(userId);
					System.out.println("userId = " + (String) session.getAttribute("userId"));
					model.addAttribute("userList", userVo);

				} else if (((String) session.getAttribute("login")).equals("naver")) {
					String userNick = (String) session.getAttribute("userNick");
					String userPhotoName = (String) session.getAttribute("userPhotoName");
					userVO.setUserNick(userNick);
					userVO.setUserPhotoName(userPhotoName);
					List<UserVO> userVo = new ArrayList<UserVO>();
					userVo.add(userVO);
					model.addAttribute("userList", userVo);
				}
			}
		}

		return VIEW_PATH + "notice_in.jsp";
	}
}
