package com.board.utility;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Search extends Pagination {

	String searchType;
	String keyword;
}
