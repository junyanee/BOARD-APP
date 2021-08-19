package com.board.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.board.model.BoardMaster;
import com.board.utility.Pagination;


@Service
public class BoardService {
	@Autowired
	com.board.board.mapper.BoardMapper boardMapper;

	public List<BoardMaster> getBoardList(Pagination pagination) throws Exception {
		return boardMapper.getBoardList(pagination);
	}

	public int getBoardListCnt() throws Exception {
		return boardMapper.getBoardListCnt();
	}

	public void insertArticle(BoardMaster param) throws Exception {
		boardMapper.insertArticle(param);
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

}
