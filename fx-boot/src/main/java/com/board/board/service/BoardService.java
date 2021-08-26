package com.board.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.board.board.model.BoardMaster;
import com.board.board.model.FileMaster;
import com.board.utility.Search;


@Service
public class BoardService {
	@Autowired
	com.board.board.mapper.BoardMapper boardMapper;

	public List<BoardMaster> getBoardList(Search search) throws Exception {
		return boardMapper.getBoardList(search);
	}

	public int getBoardListCnt(Search search) throws Exception {
		return boardMapper.getBoardListCnt(search);
	}

	public void uploadFile(FileMaster file) throws Exception {
		boardMapper.uploadFile(file);
	}

	public int insertArticle(BoardMaster param) throws Exception {
		return boardMapper.insertArticle(param);
	}

	public BoardMaster getArticle(int boardIdx) throws Exception {
		return boardMapper.getArticle(boardIdx);

	}

	public void updateReadCnt(int boardIdx) throws Exception {
		boardMapper.updateReadCnt(boardIdx);
	}

	public void modifyArticle(BoardMaster param) throws Exception {
		boardMapper.modifyArticle(param);
	}

	public void deleteArticle(BoardMaster param) throws Exception {
		boardMapper.deleteArticle(param);
	}

	public List<FileMaster> getFileList(int boardIdx) throws Exception {
		return boardMapper.getFileList(boardIdx);
	}

	public FileMaster downloadFile(int idx) throws Exception {
		return boardMapper.downloadFile(idx);
	}



}
