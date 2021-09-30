package com.board.info.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.board.model.BoardMaster;
import com.board.info.mapper.InfoMapper;
import com.board.info.model.testMaster;
import com.board.utility.Search;

@Service
public class InfoService {

	@Autowired
	InfoMapper infoMapper;

	public List<testMaster> getTestData(testMaster param) throws Exception{
		return infoMapper.getTestData(param);
	}

	public List<BoardMaster> getMyBoardList(String empCode) throws Exception {
		return infoMapper.getMyBoardList(empCode);
	}

	public int getMyBoardListCnt(Search search) throws Exception {
		return infoMapper.getMyBoardListCnt(search);
	}

	public List<BoardMaster> getMyBoardListAll(Search search) throws Exception {
		return infoMapper.getMyBoardListAll(search);
	}
}
