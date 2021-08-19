package com.board.board.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentMaster {

	int idx;
	String contents;
	String insuser;
	String insdate;
	String moduser;
	String moddate;
	int boardIdx;
	int deleteFg;
}
