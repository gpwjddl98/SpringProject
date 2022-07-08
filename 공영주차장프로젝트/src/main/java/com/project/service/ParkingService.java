package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.ParkingMapper;

import vo.ParkingVO;

@Service
public class ParkingService {

	@Autowired
	ParkingMapper parkingMapper;
	
	public void addParking(ParkingVO parkingVO) {
		parkingMapper.insertParking(parkingVO);
	}
	
	public List<ParkingVO> searchList(String parkingAddr) {
		
		return parkingMapper.search(parkingAddr);
	}
}
