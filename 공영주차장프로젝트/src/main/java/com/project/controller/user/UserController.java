package com.project.controller.user;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.MailSendService;
import com.project.service.UserService;

import vo.UserVO;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	MailSendService mailService;
	
	@Autowired
	ServletContext application;
	
	//네이버로그인 연동 관련 설정
	
	
	public static final String VIEW_PATH = "/WEB-INF/views/";
	
	
	// 로그인 버튼 클릭 시 로그인 페이지로 이동
	@RequestMapping("/userLogin")
	public String goUserLogin(HttpServletRequest request,Model model) {	
		HttpSession session = request.getSession();
		if(session!=null) {
			String userId=(String)session.getAttribute("userId");
			String userPwd=(String)session.getAttribute("userPwd");
			model.addAttribute("userId", userId);
			model.addAttribute("userPwd", userPwd);			
		}
		
		//네이버로그인부분		
		
		return VIEW_PATH+"user/userLogin.jsp";
	}	
	
	@RequestMapping("/loginNaverOk")
	public String userNaverLogin() {
		return VIEW_PATH+"loginNaverOk.jsp";
	}
	
	// 회원가입 버튼 클릭 시 회원가입.jsp로 이동
	@RequestMapping("/userSignUp")
	public String goUserSign() {
		return VIEW_PATH+"user/userSignUp.jsp";
	}
	
	// 회원가입 페이지 - 아이디 중복 체크 ajax
	@RequestMapping("/userCheckId")
	@ResponseBody
	public HashMap<String,Object> checkId(String userId) {
		HashMap<String,Object> map = new HashMap<String,Object>(); 
		
		if(userService.checkId(userId)) {
			map.put("status", "not-ok");
		} else {
			map.put("status","ok");
		}
		return map;		
	}
	
	// 회원가입 페이지 - 닉네임 중복 체크 ajax
	@RequestMapping("/userCheckNick")
	@ResponseBody
	public HashMap<String,Object> checkNick(String userNick) {
		HashMap<String,Object> map = new HashMap<String,Object>(); 
		
		if(userService.checkNick(userNick)) {
			map.put("status", "not-ok");
		} else {
			map.put("status","ok");
		}
		return map;		
	}
	
	// 회원가입 페이지 - 이메일 인증번호 보내기 ajax
	@RequestMapping("/userEmailSend")
	@ResponseBody
	public HashMap<String,Object> userEmailSend(String userEmail) {
		System.out.println("이메일 인증 요청 들어옴");
		System.out.println("이메일 인증 이메일 : "+userEmail);
		
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		
		String addr = "korea1parking2project3@gmail.com";
		
		String subject = "주차장 알리미 사이트 이메일 인증코드입니다.";
		
		String body = "안녕하세요?\r\n주차장 알리미 사이트를 이용해 주셔서 감사합니다.\r\n 다음의 인증코드를 입력해주세요.\r\n"+checkNum
				+"\r\n오늘도 안전한 운전이 되길 바랍니다!";

		
		mailService.sendEmail(userEmail, addr, subject, body);
		
		HashMap<String,Object> map = new HashMap<String,Object>();		
		
		if(!mailService.sendEmail(userEmail, addr, subject, body)) {
			map.put("status", "not-ok");
			return map;
		}
			map.put("status","ok");	
			map.put("checkNum",checkNum);
		return map;
	}
	
	//회원가입이 정상적으로 작동될 경우 로그인 페이지로 이동
	// 여기서 회원가입 userVO가 DB에 들어감 + 사진 업로드
	@RequestMapping("/userSignOk")
	public String signUp(UserVO userVO) {
		
		// 유저 프로필 사진 업로드
		String webPath="/resources/upload/";//상대경로
		String savePath = application.getRealPath(webPath);//절대경로
		System.out.println(savePath);
		MultipartFile photo = userVO.getUserPhoto();
		String fileName="no_file";
		
		if(!photo.isEmpty()) {
			//upload된 실제 파일명
			fileName=photo.getOriginalFilename();
			//vo.setFilename(filename);
			
			//파일을 저장할 경로
			File saveFile = new File(savePath,fileName);
			// ㄴsavePath 경로까지 가서 filename이라고 하는 것이 있는지 확인해줄래??
			if(!saveFile.exists()) { //만약 saveFile이 존재하지 않다면
				saveFile.mkdirs();//경로 만들어줘				
			}else {
				// 같은 이름의 파일 올라올 때 중복 막기 (중복폴더로 생성이 안되는 경우 막아주기)
				long time = System.currentTimeMillis(); //자바가 만들어진 1970년부터 2022년 현재까지의 시간을 1000분의 1초로 저장
				fileName=String.format("%d_%s", time,fileName);
				saveFile = new File(savePath,fileName);
			}
			
			try { //실제로 파일을 업로드하는 코드
				photo.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}	
		userVO.setUserPhotoName(fileName);
		userService.signUp(userVO);
		
		return VIEW_PATH+"user/userLogin.jsp";
	}	
	
	
	// 아이디/비밀번호 찾기 페이지로 이동
	@RequestMapping("/userFindLogin")
	public String goUserFindLogin() {
		return VIEW_PATH+"user/userFindLogin.jsp";
	}
	
	//아이디 찾기 페이지 - 아이디 찾기 ajax
	@RequestMapping("/userFindLoginId")
	@ResponseBody
	public HashMap<String,Object> userFindLoginId(String userName,String userPhone1,String userPhone2,String userPhone3,String userEmail, UserVO userVO){
		userVO.setUserName(userName);
		userVO.setUserPhone1(userPhone1);
		userVO.setUserPhone2(userPhone2);
		userVO.setUserPhone3(userPhone3);
		userVO.setUserEmail(userEmail);
		String userId=userService.findUserId(userVO);		
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		
		if(userId==null) {
			map.put("status", "not-ok");
		}else {
			map.put("status","ok");
			map.put("userId", userId);
		}		
		return map;
	}
	
	// 비밀번호 찾기 - 임시비밀번호 ajax
	@RequestMapping("/userSendPwdEmail")
	@ResponseBody
	public HashMap<String,Object> userSendPwdEmail(String userId,String userEmail){
		List<UserVO> list =userService.getList(userId);
		String changePwd="";
		if(userEmail.equals(list.get(0).getUserEmail())) {
			Random r = new Random();
			int samplePwd = r.nextInt(888888) + 111111;
			changePwd=""+samplePwd;
			String addr = "korea1parking2project3@gmail.com";
			
			String subject = "주차장 알리미 사이트 임시 비밀번호 이메일 입니다.";
			
			String body = "안녕하세요?\r\n주차장 알리미 사이트에 방문해 주셔서 감사합니다.\r\n다음의 임시 비밀번호로 로그인해주세요.\r\n"+samplePwd
					+"\r\n로그인 후 꼭 비밀번호를 변경해주시기 바랍니다"+"\r\n오늘도 행복한 하루 보내세요!";			
			mailService.sendEmail(userEmail, addr, subject, body);
		}
		HashMap<String,String> userMap = new HashMap<String, String>();
		userMap.put("userId", userId);
		userMap.put("userPwd",changePwd);				
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		
		if(userService.changeUserPwd(userMap)) {
			map.put("status","ok");
		}else {
			map.put("status", "not-ok");
		}
		
		return map;
	}	
	
	
	// 로그인 성공시 loginHome.jsp로 이동 , 실패시 main.jsp로 이동
	// 여기서 로그인 판별(id와 pwd가 일치하는지)
	@RequestMapping("/loginOk")
	public ModelAndView okLogin(String userId, String userPwd, HttpServletRequest request, Model model) {
		HashMap<String,String> userMap = new HashMap<String, String>();
		userMap.put("userId", userId);
		userMap.put("userPwd",userPwd);
		ModelAndView mv = new ModelAndView();
		if(userService.login(userMap)==1) {
			HttpSession session = request.getSession();
			session.setAttribute("userId", userId);
			session.setAttribute("userPwd", userPwd);
			session.setAttribute("login", "common");
			
			List<UserVO> userVo =userService.getList(userId);
			model.addAttribute("userList", userVo);
			model.addAttribute("login","common");			
			
			mv.setViewName("parking");
			return mv;			
		};		
		model.addAttribute("msg", "로그인 정보가 잘못되었습니다.\\n다시 한 번 확인해주세요.");
		model.addAttribute("url", "userLogin");
		mv.setViewName("/WEB-INF/views/user/userLoginAlert.jsp");
		return mv;
	}
	
	@RequestMapping(value= "/loginNaverMain",method=RequestMethod.POST)
	public String goLoginNaverMain(UserVO userVO,Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("login", "naver");
		session.setAttribute("userNick",userVO.getUserNick());
		session.setAttribute("userPhotoName",userVO.getUserPhotoName());
		List<UserVO> userVOlist = new ArrayList<UserVO>();
		userVOlist.add(userVO);
		model.addAttribute("userList", userVOlist);
		model.addAttribute("login","naver");
		return "parking";
	}
	
	
	
	
	//로그인 성공, 회원정보 조회
	@RequestMapping("/userInfo")
	public String goUserInfo(HttpServletRequest request,Model model,UserVO userVO) {
		HttpSession session = request.getSession();
		//session으로 id 받아서 해당 id의 userVO 받아오기
		if(((String)session.getAttribute("login")).equals("common")) {
			String userId=(String)session.getAttribute("userId");
			List<UserVO> userVo =userService.getList(userId);
			model.addAttribute("list", userVo);			
		}
		if(((String)session.getAttribute("login")).equals("naver")) {
			String userNick=(String)session.getAttribute("userNick");
			String userPhotoName=(String)session.getAttribute("userPhotoName");
			userVO.setUserNick(userNick);
			userVO.setUserPhotoName(userPhotoName);
			List<UserVO> userVo = new ArrayList<UserVO>();
			userVo.add(userVO);
			model.addAttribute("list", userVo);			
		}		
		return VIEW_PATH+"user/userInfo.jsp";
	}
	
	// 회원정보 수정 페이지로 이동
	@RequestMapping("/userUpdate")
	public String goUserUpdate(HttpServletRequest request,Model model) {		
		HttpSession session = request.getSession();
		//session으로 id 받아서 해당 id의 userVO 받아오기
		String userId=(String)session.getAttribute("userId");
		List<UserVO> userVo =userService.getList(userId);
		model.addAttribute("list", userVo);
		return VIEW_PATH+"user/userUpdate.jsp";
	}
	
	
	// 회원정보 수정 (db 값 수정)
	@RequestMapping("/userUpdateOk")
	public String modify(UserVO userVO, String newPwd, Model model) {
		userVO.setUserPwd(newPwd);
		
		// 유저 프로필 사진 업로드
				String webPath="/resources/upload/";//상대경로
				String savePath = application.getRealPath(webPath);//절대경로
				System.out.println(savePath);
				MultipartFile photo = userVO.getUserPhoto();
				String fileName="no_file";
				
				if(!photo.isEmpty()) {
					//upload된 실제 파일명
					fileName=photo.getOriginalFilename();
					//vo.setFilename(filename);
					
					//파일을 저장할 경로
					File saveFile = new File(savePath,fileName);
					// ㄴsavePath 경로까지 가서 filename이라고 하는 것이 있는지 확인해줄래??
					if(!saveFile.exists()) { //만약 saveFile이 존재하지 않다면
						saveFile.mkdirs();//경로 만들어줘				
					}else {
						// 같은 이름의 파일 올라올 때 중복 막기 (중복폴더로 생성이 안되는 경우 막아주기)
						long time = System.currentTimeMillis(); //자바가 만들어진 1970년부터 2022년 현재까지의 시간을 1000분의 1초로 저장
						fileName=String.format("%d_%s", time,fileName);
						saveFile = new File(savePath,fileName);
					}
					
					try { //실제로 파일을 업로드하는 코드
						photo.transferTo(saveFile);
					} catch (Exception e) {
						e.printStackTrace();
					} 
				}	
				userVO.setUserPhotoName(fileName);		
		
		userService.modify(userVO);
		List<UserVO> list = userService.getList(userVO.getUserId());
		model.addAttribute("list", list);
		return VIEW_PATH+"user/userInfo.jsp";
	}	
	
	
	// 로그아웃시 세션 지워주기
	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request, Model model, ModelAndView mv) {
		//세션 지워주기
		HttpSession session = request.getSession();
		session.invalidate();
		
		model.addAttribute("msg", "로그아웃 되었습니다.");
		model.addAttribute("url", "parking");
		mv.setViewName("/WEB-INF/views/user/userLogoutAlert.jsp");
		return mv;
		
	}
	
	@RequestMapping("/loginNeedAlert")
	public ModelAndView loginAlert(Model model, ModelAndView mv) {
		model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
		model.addAttribute("url", "userLogin");
		mv.setViewName("/WEB-INF/views/user/userNeedLoginAlert.jsp");
		return mv;
	}
	
	
	

	
	// 회원 탈퇴 버튼 클릭시 탈퇴 페이지로 이동
	@RequestMapping("/userDelete")
	public String goDeleteUser(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		//session으로 id 받아서 해당 id의 userVO 받아오기
		String userId=(String)session.getAttribute("userId");
		List<UserVO> userVo =userService.getList(userId);
		model.addAttribute("list", userVo);
		return VIEW_PATH+"user/userDelete.jsp";
	}
	
	@RequestMapping("/userDrop")
	public String userDrop(String userId,HttpServletRequest request) {
		// 회원정보 삭제
		userService.delete(userId);
		
		//세션 삭제
		HttpSession session = request.getSession();
		session.invalidate();
		
		return VIEW_PATH+"main.jsp";
	}
	

}
