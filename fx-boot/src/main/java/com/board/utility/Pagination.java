package com.board.utility;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pagination {
	int listSize = 2; // 한 페이지당 보여질 리스트 개수 #RowPerPage
	int rangeSize = 5; // 한 페이지 범위에 보여질 페이지의 개수
	int page; // 현재 목록의 페이지 번호
	int range; // 각 페이지 범위 시작 번호
	int listCnt; // 전체 게시물 개수
	int pageCnt; // 전체 페이지 범위의 개수
	int startPage; // 각 페이지 범위 시작 번호
	int endPage; // 각 페이지 범위 끝 번호
	boolean prev; // 이전 페이지 여부
	boolean next; // 다음 페이지 여부

	public void pageInfo(int page, int range, int listCnt) {
		// page : 현재 목록의 페이지 번호, range : 현제 페이지 범위 정보, listCnt : 총 게시물 개수
		this.page = page;
		this.range = range;
		this.listCnt = listCnt;

		// 전체 페이지수
		this.pageCnt = (int)Math.ceil((double)listCnt / listSize);

		// 시작 페이지
		this.startPage = (range - 1) * rangeSize + 1;

		// 끝 페이지
		this.endPage = range * rangeSize;

		// 이전 버튼 상태
		this.prev = range == 1 ? false : true;

		// 다음 버튼 상태
		// this.next = endPage > pageCnt ? false : true;
		this.next = pageCnt > endPage ? true: false;

		if (this.endPage > this.pageCnt) {
			this.endPage = this.pageCnt;
			this.next = false;
		}

	}
}
