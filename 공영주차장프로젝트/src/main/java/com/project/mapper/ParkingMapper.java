package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import vo.ParkingVO;

@Mapper
public interface ParkingMapper {
	public void insertParking(ParkingVO parkingVO);
	public List<ParkingVO> search(String parkingAddr);
}
