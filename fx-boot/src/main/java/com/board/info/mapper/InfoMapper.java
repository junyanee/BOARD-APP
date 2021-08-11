package com.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.model.testMaster;

@Mapper
public interface InfoMapper {

	public List<testMaster> getTestData(testMaster param) throws Exception;
}
