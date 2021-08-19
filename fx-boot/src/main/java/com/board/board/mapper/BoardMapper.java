package com.board.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.board.model.BoardMaster;
import com.board.utility.Pagination;


@Mapper
public interface BoardMapper {

	public List<BoardMaster> getBoardList(Pagination pagination) throws Exception;

	public int getBoardListCnt() throws Exception;

	public void insertArticle(BoardMaster param) throws Exception;

	public BoardMaster getArticle(int boardIdx) throws Exception;

	public void updateReadCnt(int boardIdx) throws Exception;

	public void modifyArticle(BoardMaster param) throws Exception;

	public void deleteArticle(BoardMaster param) throws Exception;

}
