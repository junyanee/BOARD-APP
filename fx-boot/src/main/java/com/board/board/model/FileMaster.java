package com.board.board.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FileMaster {

	int idx;
	int boardIdx;
	String orgFileName;
	String storedFileName;
	byte[] fileBytes;
	long fileSize;
	String insertUser;
	String insertDate;
	String modifyUser;
	String modifyDate;
	int deleteFg;

}
