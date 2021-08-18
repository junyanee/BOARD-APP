package com.board.board.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardMaster {
	int idx;
	String title;
	String contents;
	String insuser;
	String insdate;
	String moduser;
	String moddate;
	int readCnt;   
	int commentCnt;
	int deleteFg;
}
