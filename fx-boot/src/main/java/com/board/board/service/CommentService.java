package com.board.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.board.model.CommentMaster;

@Service
public class CommentService {
	@Autowired
	com.board.board.mapper.CommentMapper commentMapper;

	public List<CommentMaster> getComment(int boardIdx) throws Exception {
		return commentMapper.getComment(boardIdx);
	}
}
