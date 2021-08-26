package com.board.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.board.board.model.BoardMaster;
import com.board.board.model.FileMaster;
import com.board.utility.Search;


@Mapper
public interface BoardMapper {

	public List<BoardMaster> getBoardList(Search search) throws Exception;

	public int getBoardListCnt(Search search) throws Exception;

	public int insertArticle(BoardMaster param) throws Exception;

	public void uploadFile(FileMaster file) throws Exception;

	public BoardMaster getArticle(int boardIdx) throws Exception;

	public void updateReadCnt(int boardIdx) throws Exception;

	public void modifyArticle(BoardMaster param) throws Exception;

	public void deleteArticle(BoardMaster param) throws Exception;

	public List<FileMaster> getFileList(int boardIdx) throws Exception;

	public FileMaster downloadFile(@Param("fileList") int idx) throws Exception;

}
