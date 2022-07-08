package com.project.controller.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.BoardReplyService;
import com.project.service.BoardService;
import com.project.service.UserService;

import vo.BoardReplyVO;
import vo.BoardVO;
import vo.UserVO;
import util.Common;
import util.Paging;

@Controller
public class BoardController {
	
	public static final String VIEW_PATH = "/WEB-INF/views/";
	@Autowired
	BoardService boardService;
	
	@Autowired
	BoardReplyService boardreplyService;
	
	@Autowired
	UserService userService;
	
	
	//전체글조회
	@RequestMapping("b_list")
	public String list(Model model,HttpServletRequest request,  BoardVO boardvo, UserVO userVO) {
		
		//페이징 시작
		int nowPage = 1;
		String page = request.getParameter("page");
		if(page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
			}
		int start = (nowPage-1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST -1;
		//쿼리문으로 묶어서 보내기
		HashMap<String , Integer> map = new HashMap<String , Integer>();
		map.put("start",start);
		map.put("end",end);
		List<BoardVO> list = boardService.list(map);
		model.addAttribute("list",list);
		//페이징 끝
				
		//전체게시글의 수
		int rowTotal = boardService.getRowTotal();
				
		String pageMenu = Paging.getPaging //util안에있는 page
				("b_list.do", nowPage, rowTotal, Common.Board.BLOCKLIST , Common.Board.BLOCKPAGE);
		model.addAttribute("pageMenu",pageMenu);
				
		request.getSession().removeAttribute("show");

		//로그인 세션 받아오기
				//로그인 session이 있다면 해당 정보넘겨주기
				HttpSession session;		
				
				if(request.isRequestedSessionIdValid()) {			
					session = request.getSession();
					
					if(session.getAttribute("login")==null) {
						System.out.println("세션없는곳으로 들어옴");
						return "parking";
					} else {
						System.out.println("세션있는곳으로 들어옴");
						System.out.println("로그인 세션 : "+session.getAttribute("login"));
						if(((String)session.getAttribute("login")).equals("common")) {
							String userId=(String)session.getAttribute("userId");
							List<UserVO> userVo =userService.getList(userId);
							System.out.println("userId = "+(String)session.getAttribute("userId"));
							model.addAttribute("userList", userVo);	
							
						}
						else if(((String)session.getAttribute("login")).equals("naver")) {
							String userNick=(String)session.getAttribute("userNick");
							String userPhotoName=(String)session.getAttribute("userPhotoName");
							userVO.setUserNick(userNick);
							userVO.setUserPhotoName(userPhotoName);
							List<UserVO> userVo = new ArrayList<UserVO>();
							userVo.add(userVO);
							model.addAttribute("userList", userVo);	
							
						}				
					}
				}		
		
		return VIEW_PATH+"board/b_list.jsp";
	}

	
	
	
	//새글추가 폼으로 이동
	@RequestMapping("/b_insert_form")
	public String insert_form(HttpServletRequest request, UserVO userVO,Model model) {
		
		//로그인 세션 받아오기
		//로그인 session이 있다면 해당 정보넘겨주기
		HttpSession session;		
		
		if(request.isRequestedSessionIdValid()) {			
			session = request.getSession();
			
			if(session.getAttribute("login")==null) {
				System.out.println("세션없는곳으로 들어옴");
				return VIEW_PATH + "main.jsp";
			} else {
				System.out.println("세션있는곳으로 들어옴");
				System.out.println("로그인 세션 : "+session.getAttribute("login"));
				if(((String)session.getAttribute("login")).equals("common")) {
					String userId=(String)session.getAttribute("userId");
					List<UserVO> userVo =userService.getList(userId);
					System.out.println("userId = "+(String)session.getAttribute("userId"));
					model.addAttribute("userList", userVo);	
					
				}
				else if(((String)session.getAttribute("login")).equals("naver")) {
					String userNick=(String)session.getAttribute("userNick");
					String userPhotoName=(String)session.getAttribute("userPhotoName");
					userVO.setUserNick(userNick);
					userVO.setUserPhotoName(userPhotoName);
					List<UserVO> userVo = new ArrayList<UserVO>();
					userVo.add(userVO);
					model.addAttribute("userList", userVo);	
					
				}				
			}
		}		
		
		return VIEW_PATH+"board/b_insert_form.jsp";
	}
	//새글작성
	@RequestMapping("/b_insert")
	public String insert(BoardVO vo) {
		boardService.insert(vo);
		
		
		return "redirect:b_list.do";
	}
	//자세히보기 폼으로 이동
	@RequestMapping("/b_view")
	public String select_one(Model model, int idx,HttpServletRequest request, UserVO userVO) {
		model.addAttribute("bo",boardService.select_one(idx));
		
		List<BoardReplyVO> reply = null;
		 reply = boardreplyService.reply_list(idx);
		 model.addAttribute("reply",reply);
		
		 //조회수증가
		 HttpSession session2 = request.getSession();
			String show = (String)session2.getAttribute("show");
			if(show == null) {
				int res = boardService.viewcount(idx);
				session2.setAttribute("show", "0");
			}
			
			//로그인 세션 받아오기
			//로그인 session이 있다면 해당 정보넘겨주기
			HttpSession session;		
			
			if(request.isRequestedSessionIdValid()) {			
				session = request.getSession();
				
				if(session.getAttribute("login")==null) {
					System.out.println("세션없는곳으로 들어옴");
					return VIEW_PATH + "main.jsp";
				} else {
					System.out.println("세션있는곳으로 들어옴");
					System.out.println("로그인 세션 : "+session.getAttribute("login"));
					if(((String)session.getAttribute("login")).equals("common")) {
						String userId=(String)session.getAttribute("userId");
						List<UserVO> userVo =userService.getList(userId);
						System.out.println("userId = "+(String)session.getAttribute("userId"));
						model.addAttribute("userList", userVo);	
						
					}
					else if(((String)session.getAttribute("login")).equals("naver")) {
						String userNick=(String)session.getAttribute("userNick");
						String userPhotoName=(String)session.getAttribute("userPhotoName");
						userVO.setUserNick(userNick);
						userVO.setUserPhotoName(userPhotoName);
						List<UserVO> userVo = new ArrayList<UserVO>();
						userVo.add(userVO);
						model.addAttribute("userList", userVo);	
						
					}				
				}
			}		
	
		 
		
		return VIEW_PATH+"board/b_view.jsp";
	}
	//수정하기폼으로이동
	@RequestMapping("/b_modi_form.do")
	public String modi_form(Model model, int idx , HttpServletRequest request, UserVO userVO) {
		model.addAttribute("vo",boardService.list_one(idx)); 
		
		
		//로그인 세션 받아오기
		//로그인 session이 있다면 해당 정보넘겨주기
		HttpSession session;		
		
		if(request.isRequestedSessionIdValid()) {			
			session = request.getSession();
			
			if(session.getAttribute("login")==null) {
				System.out.println("세션없는곳으로 들어옴");
				return VIEW_PATH + "main.jsp";
			} else {
				System.out.println("세션있는곳으로 들어옴");
				System.out.println("로그인 세션 : "+session.getAttribute("login"));
				if(((String)session.getAttribute("login")).equals("common")) {
					String userId=(String)session.getAttribute("userId");
					List<UserVO> userVo =userService.getList(userId);
					System.out.println("userId = "+(String)session.getAttribute("userId"));
					model.addAttribute("userList", userVo);	
					
				}
				else if(((String)session.getAttribute("login")).equals("naver")) {
					String userNick=(String)session.getAttribute("userNick");
					String userPhotoName=(String)session.getAttribute("userPhotoName");
					userVO.setUserNick(userNick);
					userVO.setUserPhotoName(userPhotoName);
					List<UserVO> userVo = new ArrayList<UserVO>();
					userVo.add(userVO);
					model.addAttribute("userList", userVo);	
					
				}				
			}
		}		
		return VIEW_PATH+"board/b_modi_form.jsp";
	}
	//수정하기
	@RequestMapping("/b_modify.do")
	public String update(Model model, BoardVO vo, BoardVO idx) {
		int res = boardService.update(idx);
		 
		return "redirect:b_view.do?idx="+vo.getIdx();
	}
	//삭제하기
	@RequestMapping("/b_delet.do")
	@ResponseBody
	public String delet(BoardVO vo) {
		
		int res = boardService.delet(vo); 
		String result="no";
		
		if( res == 1) {
			result="yes";
		}
		
		String finRes= String.format("[{'res':'%s'}]",result);
		
		return finRes;
	}
	
	
}
