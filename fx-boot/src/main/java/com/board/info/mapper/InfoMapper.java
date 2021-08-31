package com.board.info.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.info.model.testMaster;

@Mapper
public interface InfoMapper {

	public List<testMaster> getTestData(testMaster param) throws Exception;
}
