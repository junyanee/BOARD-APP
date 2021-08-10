package com.board.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardMaster {
	int idx;
	String title;
	String insuser;
	String insdate;
	String moduser;
	String moddate;
	int read_cnt;
	int comment_cnt;
	int delete_fg;
}
