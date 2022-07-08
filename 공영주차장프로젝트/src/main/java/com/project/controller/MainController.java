package com.project.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.ParkingService;
import com.project.service.UserService;

import vo.ParkingVO;
import vo.UserVO;

@Controller
public class MainController {
	public static final String VIEW_PATH = "/WEB-INF/views/";
	public static List<ParkingVO> list;

	@Autowired
	ParkingService parkingService;
	
	@Autowired
	UserService userService;

	//처음 로드 시 서울 공영 주차장 API 연동 후 리스트 보여줌
	@RequestMapping(value = { "/", "/parking" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String home(HttpServletRequest request,Locale locale, Model model, UserVO userVO) throws Exception {
		// 1. URL을 만들기 위한 StringBuilder/ 오픈 API의요청 규격에 맞는 파라미터 생성, 발급받은 인증키.
		StringBuilder urlBuilder = new StringBuilder(
				"http://openapi.seoul.go.kr:8088/484d455a6e6c6f763635654a72706a/json/GetParkInfo/1/500/강남");

		// 3. URL 객체 생성.
		URL url = new URL(urlBuilder.toString());
		// 4. 요청하고자 하는 URL과 통신하기 위한 Connection 객체 생성.
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		// 5. 통신을 위한 메소드 SET.
		conn.setRequestMethod("GET");
		// 6. 통신을 위한 Content-type SET.
		conn.setRequestProperty("Content-type", "application/json");
		// 7. 통신 응답 코드 확인.
		System.out.println("Response code: " + conn.getResponseCode());
		// 8. 전달받은 데이터를 BufferedReader 객체로 저장.
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		// 9. 저장된 데이터를 라인별로 읽어 StringBuilder 객체로 저장.
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		// 10. 객체 해제.
		rd.close();
		conn.disconnect();
		// 11. 전달받은 데이터 확인.
		System.out.println(sb.toString());

		// 1. 문자열 형태의 JSON을 파싱하기 위한 JSONParser 객체 생성.
		JSONParser parser = new JSONParser();
		// 2. 문자열을 JSON 형태로 JSONObject 객체에 저장.
		JSONObject obj = (JSONObject) parser.parse(sb.toString());
		// 3. 필요한 리스트 데이터 부분만 가져와 JSONArray로 저장.
		// JSON 형식에 따라 GetParkInfo 안에 row 안에 정보를 갖고오기
		JSONObject obj2 = (JSONObject) obj.get("GetParkInfo");
		JSONArray dataArr = (JSONArray) obj2.get("row");

		list = new ArrayList<ParkingVO>();
		for (int i = 0; i < dataArr.size(); i++) { 
			// 이런식으로 값을 하나씩 받아올 수 있음 JSONObject
			JSONObject jsonObject = (JSONObject) dataArr.get(i);

			ParkingVO vo = new ParkingVO();
			
			//시간 사이에 : 넣는 작업
			String holidayEndTime = jsonObject.get("HOLIDAY_END_TIME").toString().substring(0,2) + " : " + jsonObject.get("HOLIDAY_END_TIME").toString().substring(2,4);
			String weekdayEndTime = jsonObject.get("WEEKDAY_END_TIME").toString().substring(0,2) + " : " + jsonObject.get("WEEKDAY_END_TIME").toString().substring(2,4);
			String weekendEndTime = jsonObject.get("WEEKEND_END_TIME").toString().substring(0,2) + " : " + jsonObject.get("WEEKEND_END_TIME").toString().substring(2,4);
			String holidayBeginTime = jsonObject.get("HOLIDAY_BEGIN_TIME").toString().substring(0,2) + " : " + jsonObject.get("HOLIDAY_BEGIN_TIME").toString().substring(2,4);
			String weekdayBeginTime = jsonObject.get("WEEKDAY_BEGIN_TIME").toString().substring(0,2) + " : " + jsonObject.get("WEEKDAY_BEGIN_TIME").toString().substring(2,4);
			String weekendBeginTime = jsonObject.get("WEEKEND_BEGIN_TIME").toString().substring(0,2) + " : " + jsonObject.get("WEEKEND_BEGIN_TIME").toString().substring(2,4);
			
			//돈 소수점
			String monthlyPass = String.format("%,d", Integer.parseInt(jsonObject.get("FULLTIME_MONTHLY").toString()));

			vo.setParkingIdx(jsonObject.get("PARKING_CODE").toString());
			vo.setParkingName(jsonObject.get("PARKING_NAME").toString());
			vo.setParkingAddr(jsonObject.get("ADDR").toString());
			vo.setParkingBaseCharge(Integer.parseInt(jsonObject.get("RATES").toString().substring(0, jsonObject.get("RATES").toString().lastIndexOf("."))));
			vo.setParkingBaseTime(Integer.parseInt(jsonObject.get("TIME_RATE").toString().substring(0, jsonObject.get("TIME_RATE").toString().lastIndexOf("."))));
			vo.setParkingCount(Integer.parseInt(jsonObject.get("CAPACITY").toString().substring(0, jsonObject.get("CAPACITY").toString().lastIndexOf("."))));
			vo.setParkingEndTimeHoliday(holidayEndTime);
			vo.setParkingEndTimeWeekday(weekdayEndTime);
			vo.setParkingEndTimeWeekend(weekendEndTime);
			vo.setParkingLat(jsonObject.get("LAT").toString());
			vo.setParkingLon(jsonObject.get("LNG").toString());
			vo.setParkingMonthlyPass(monthlyPass);
			vo.setParkingPlusCharge(Integer.parseInt(jsonObject.get("ADD_RATES").toString().substring(0, jsonObject.get("ADD_RATES").toString().lastIndexOf("."))));
			vo.setParkingPlusTime(Integer.parseInt(jsonObject.get("ADD_TIME_RATE").toString().substring(0, jsonObject.get("ADD_TIME_RATE").toString().lastIndexOf("."))));
			vo.setParkingStartTimeHoliday(holidayBeginTime);
			vo.setParkingStartTimeWeekday(weekdayBeginTime);
			vo.setParkingStartTimeWeekend(weekendBeginTime);
			vo.setParkingTel(jsonObject.get("TEL").toString());
			vo.setParkingSatPay(jsonObject.get("SATURDAY_PAY_NM").toString());
			vo.setParkingHolidayPay(jsonObject.get("HOLIDAY_PAY_NM").toString());
			
			// 첫 실행시 주석 풀고 실행
			//실행 이후 주석처리 하고 다시 실행
			//임시 디비 추가
			//parkingService.addParking(vo);
			
			list.add(vo);
		}

		// 4. model에 담아준다.
		model.addAttribute("list", list);
		
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

		return VIEW_PATH + "main.jsp";
	}
	
	//검색 결과
	@RequestMapping("/search")
	@ResponseBody
	public HashMap<String,Object> search(Model model, HttpServletRequest request) {
		HashMap<String,Object> map = new HashMap<String,Object>(); 
		
		String parkingAddr = request.getParameter("ParkingAddr");
		list = new ArrayList<ParkingVO>();
		list = parkingService.searchList(parkingAddr); //DB조회
		map.put("list", list);
		
		if(list.size() != 0) {
			map.put("status", "ok");
			model.addAttribute("status", "ok");
		} else {
			map.put("status", "no");
			model.addAttribute("status", "no");
		}
		
		return map;
	}
	
	@RequestMapping("/favorites")
	   public String goFavorites() {
	      return VIEW_PATH+"sorryBoard.jsp";
	   }

}
