package com.board.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.board.model.BoardMaster;


@Service
public class BoardService {
	@Autowired
	com.board.board.mapper.BoardMapper boardMapper;

	public List<BoardMaster> getBoardTest() throws Exception {
		return boardMapper.getBoardTest();
	}

	public List<BoardMaster> insertArticle(BoardMaster param) throws Exception {
		return boardMapper.insertArticle(param);

	}
}
