package com.board.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.board.model.CommentMaster;

@Mapper
public interface CommentMapper {

	public List<CommentMaster> getComment(int boardIdx) throws Exception;

}
