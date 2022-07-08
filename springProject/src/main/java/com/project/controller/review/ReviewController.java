package com.project.controller.review;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.ReplyService;
import com.project.service.ReviewService;
import com.project.service.UserService;

import util.Common;
import util.Paging;
import vo.ReviewVO;
import vo.UserVO;
import vo.ReplyVO;

@Controller
public class ReviewController {

	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	ReplyService replyService;
	
	@Autowired
	UserService userService;
	
	
	public static final String VIEW_PATH = "/WEB-INF/views/";
	
	//전체글조회
	@RequestMapping("list")
	public String list(Model model, HttpServletRequest request, ReviewVO reviewvo, UserVO userVO) {
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
		List<ReviewVO> list = reviewService.count(map);
		
		
		//vo에 setStarview를 만들어서 HashMap에서 불러오도록
		HashMap<String,String> mv = new HashMap<String,String>();
		mv.put("0", "☆☆☆☆☆");
		mv.put("1", "★☆☆☆☆");
		mv.put("2", "★★☆☆☆");
		mv.put("3", "★★★☆☆");
		mv.put("4", "★★★★☆");
		mv.put("5", "★★★★★");
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setStarview((mv.get(list.get(i).getStar())));			
		}
		
		model.addAttribute("list",list);
		//페이징 끝
		
		//전체게시글의 수
		int rowTotal = reviewService.getRowTotal();
		
		String pageMenu = Paging.getPaging //util안에있는 page
				("list.do", nowPage, rowTotal, Common.Board.BLOCKLIST , Common.Board.BLOCKPAGE);
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
	
		return VIEW_PATH+"review/list.jsp";
	}
	
	//검색
	@RequestMapping("/getSearchList")
	@ResponseBody
	public List<ReviewVO> count_search(@RequestParam("type") String type,
									   @RequestParam("keyword") String keyword, Model model){
		
		System.out.println(type);
		ReviewVO reviewvo = new ReviewVO();
		reviewvo.setType(type);
		reviewvo.setKeyword(keyword);
		System.out.println(reviewvo);
		
		return reviewService.count_search(reviewvo);
		
	}
	
	//새글 작성하기 폼으로 이동
	@RequestMapping("/insert_form")
	public String insert_form(Model model,HttpServletRequest request, UserVO userVO) {
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
		
		return VIEW_PATH+"review/insert_form.jsp";
	}
	//새글 작성 해서 추가
	@RequestMapping("/insert")
	public String insert(ReviewVO vo) {
		reviewService.insert(vo);
		
		
		
		return "redirect:list.do";
	}
	
	//자세히보기 폼으로 이동 +댓글도보이도록
	
	 @RequestMapping("/view.do") 
	 public String list_one(HttpServletRequest request , int idx , UserVO userVO, Model model) {
		 request.setAttribute("vo",reviewService.list_one(idx));
	 
		 List<ReplyVO> reply = null;
				 reply = replyService.reply_list(idx);
		 request.setAttribute("reply", reply);
		 
		 //조회수증가
		 HttpSession session2 = request.getSession();
			String show = (String)session2.getAttribute("show");
			if(show == null) {
				int res = reviewService.update(idx);
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
		 
		 
	 return VIEW_PATH+"review/view.jsp";
	 }
	 
	//수정하기 폼으로 이동
	@RequestMapping("/modify_form")
	public String modify_form(Model model, int idx,HttpServletRequest request ,UserVO userVO) {
		model.addAttribute("vo",reviewService.list_one(idx)); 
		
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
		return VIEW_PATH+"review/modify_form.jsp";
	}
	//수정하기
	@RequestMapping("/modify.do")
	public String modify(Model model, ReviewVO vo, ReviewVO idx) {
		
		//List<ReviewVO> list = reviewService.modify(vo);
		
		//model.addAttribute("vo",list); 
		
		int res = reviewService.update_modi(idx);
		
		return "redirect:view.do?idx="+vo.getIdx();
	}
	//삭제하기
	@RequestMapping("/delet.do")
	@ResponseBody
	public String delet(ReviewVO vo) {
		
		int res = reviewService.delet(vo); 
		String result="no";
		
		if( res == 1) {
			result="yes";
		}
		
		String finRes= String.format("[{'res':'%s'}]",result);
		
		return finRes;
	}
	
	@RequestMapping("/boardAlert")
	public ModelAndView boardAlert(Model model, ModelAndView mv) {
		model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
		model.addAttribute("url", "userLogin");
		mv.setViewName("/WEB-INF/views/review/boardAlert.jsp");
		return mv;
	}
	
	
	
}
