package com.board.board.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentMaster {

	int idx;
	String contents;
	String insertUser;
	String insertDate;
	String modifyUser;
	String modifyDate;
	int boardIdx;
	int deleteFg;
}
