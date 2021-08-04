package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.mapper.InfoMapper;
import com.board.model.testMaster;

@Service
public class InfoService {

	@Autowired
	InfoMapper infoMapper;
	
	public List<testMaster> getTestData(testMaster param) throws Exception{
		return infoMapper.getTestData(param);
	}
}
