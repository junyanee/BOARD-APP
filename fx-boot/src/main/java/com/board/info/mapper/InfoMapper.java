package com.board.info.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.board.board.model.BoardMaster;
import com.board.common.model.ResultMaster;
import com.board.common.model.UserMaster;
import com.board.info.model.testMaster;
import com.board.utility.Search;

@Mapper
public interface InfoMapper {

	public List<testMaster> getTestData(testMaster param) throws Exception;

	public List<BoardMaster> getMyBoardList(String empCode) throws Exception;

	public int getMyBoardListCnt(Search search) throws Exception;

	public List<BoardMaster> getMyBoardListAll(Search search) throws Exception;

	public ResultMaster saveProfileImage(Map<String, Object> parameterMap) throws Exception;

	public ResultMaster saveProfileInput(UserMaster param) throws Exception;
}
