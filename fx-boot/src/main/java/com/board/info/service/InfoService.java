package com.board.info.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.board.model.BoardMaster;
import com.board.common.model.ResultMaster;
import com.board.common.model.UserMaster;
import com.board.info.mapper.InfoMapper;
import com.board.info.model.testMaster;
import com.board.utility.Search;

@Service
public class InfoService {

	@Autowired
	InfoMapper infoMapper;

	public List<testMaster> getTestData(testMaster param) throws Exception{
		return infoMapper.getTestData(param);
	}

	public List<BoardMaster> getMyBoardList(String empCode) throws Exception {
		return infoMapper.getMyBoardList(empCode);
	}

	public int getMyBoardListCnt(Search search) throws Exception {
		return infoMapper.getMyBoardListCnt(search);
	}

	public List<BoardMaster> getMyBoardListAll(Search search) throws Exception {
		return infoMapper.getMyBoardListAll(search);
	}

	public Map<String, Object> saveProfileImage(String empCode, String uploadPath) throws Exception {
		ResultMaster resultMaster = new ResultMaster();
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("empCode", empCode);
		parameterMap.put("uploadPath", uploadPath);
		resultMaster = infoMapper.saveProfileImage(parameterMap);
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

	public String deleteIfProfileImageExists(String path) throws Exception {
		String result = "";
		File deleteFile = new File(path);
		if(deleteFile.exists()) {
			deleteFile.delete();
			result = "Y";
			return result;
		} else {
			result = "N";
			return result;
		}
	}

	public Map<String, Object> saveProfileInfo(UserMaster param) throws Exception {
		ResultMaster resultMaster = new ResultMaster();
		resultMaster = infoMapper.saveProfileInput(param);
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
}
