package com.board.board.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardMaster{

	int idx;
	String title;
	String contents;
	String insertUser;
	String insertDate;
	String modifyUser;
	String modifyDate;
	int readCnt;
	int commentCnt;
	int isNotice;
	int isPublic;
	int deleteFg;
}
