package com.board.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.board.model.BoardMaster;


@Mapper
public interface BoardMapper {

	public List<BoardMaster> getBoardTest() throws Exception;

	public List<BoardMaster> insertArticle(BoardMaster param) throws Exception;
}
