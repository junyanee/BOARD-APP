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
	String insuser;
	String insdate;
	String moduser;
	String moddate;
	int deleteFg;

}
