package com.board.info.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.board.model.BoardMaster;
import com.board.info.model.testMaster;
import com.board.utility.Search;

@Mapper
public interface InfoMapper {

	public List<testMaster> getTestData(testMaster param) throws Exception;

	public List<BoardMaster> getMyBoardList(String empCode) throws Exception;

	public int getMyBoardListCnt(Search search) throws Exception;

	public List<BoardMaster> getMyBoardListAll(Search search) throws Exception;
}
