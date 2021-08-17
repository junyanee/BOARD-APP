package com.board.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.board.model.BoardMaster;


@Mapper
public interface BoardMapper {

	public List<BoardMaster> getBoardTest() throws Exception;

	public void insertArticle(BoardMaster param) throws Exception;

	public BoardMaster getArticle(int boardIdx) throws Exception;

	public void modifyArticle(BoardMaster param) throws Exception;

	public void deleteArticle(int boardIdx) throws Exception;
}
