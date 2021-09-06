package com.board.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.board.board.model.BoardMaster;
import com.board.board.model.FileMaster;
import com.board.common.model.ResultMaster;
import com.board.utility.Search;


@Service
public class BoardService {
	@Autowired
	com.board.board.mapper.BoardMapper boardMapper;

	public List<BoardMaster> getBoardList(Search search) throws Exception {
		return boardMapper.getBoardList(search);
	}

	public int getBoardListCnt(Search search) throws Exception {
		return boardMapper.getBoardListCnt(search);
	}

	public Map<String, Object> uploadFile(FileMaster file) throws Exception {
		ResultMaster resultMaster = new ResultMaster();
		resultMaster = boardMapper.uploadFile(file);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (resultMaster.getIsSuccess().equals("true")) {
			resultMap.put("isSuccess", true);
			resultMap.put("resultMsg", "정상적으로 처리되었습니다.");
		} else if (resultMaster.getIsSuccess().equals("false")) {
			resultMap.put("isSuccess", false);
			resultMap.put("resultMsg", "정상적으로 처리되지 못했습니다.");
			boardMapper.cancelInsertArticle(file.getBoardIdx());
		}
		return resultMap;
	}

	public int insertArticle(BoardMaster param) throws Exception {
		return boardMapper.insertArticle(param);
	}

	public BoardMaster getArticle(int boardIdx) throws Exception {
		return boardMapper.getArticle(boardIdx);
	}

	public void updateReadCnt(int boardIdx) throws Exception {
		boardMapper.updateReadCnt(boardIdx);
	}

	public Map<String, Object> modifyArticle(BoardMaster param) throws Exception {
		ResultMaster resultMaster = new ResultMaster();
		resultMaster = boardMapper.modifyArticle(param);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (resultMaster.getIsSuccess().equals("true")) {
			resultMap.put("isSuccess", true);
			resultMap.put("resultMsg", "정상적으로 처리되었습니다.");
		} else if (resultMaster.getIsSuccess().equals("false")) {
			resultMap.put("isSuccess", false);
			resultMap.put("resultMsg", "정상적으로 처리되지 못했습니다.");
		}
		return resultMap;
	}

	public Map<String, Object> deleteArticle(BoardMaster param) throws Exception {
		ResultMaster resultMaster = new ResultMaster();
		resultMaster = boardMapper.deleteArticle(param);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (resultMaster.getIsSuccess().equals("true")) {
			resultMap.put("isSuccess", true);
			resultMap.put("resultMsg", "정상적으로 처리되었습니다.");
		} else if (resultMaster.getIsSuccess().equals("false")) {
			resultMap.put("isSuccess", false);
			resultMap.put("resultMsg", "정상적으로 처리되지 못했습니다.");
		}
		return resultMap;

	}

	public List<FileMaster> getFileList(int boardIdx) throws Exception {
		return boardMapper.getFileList(boardIdx);
	}

	public FileMaster downloadFile(int idx) throws Exception {
		return boardMapper.downloadFile(idx);
	}

	public void deleteFile(int boardIdx) throws Exception {
		boardMapper.deleteFile(boardIdx);
	}
}
