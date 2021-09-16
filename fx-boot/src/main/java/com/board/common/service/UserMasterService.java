package com.board.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.common.mapper.CommonMapper;
import com.board.common.model.ResultMaster;
import com.board.common.model.UserMaster;
import com.board.utility.Search;

@Service
public class UserMasterService {

	@Autowired
		CommonMapper commonMapper;

	public UserMaster getUserInfo(String userId) throws Exception {
		return commonMapper.getUserInfo(userId);
	}

	public List<UserMaster> getAllUser(Search search) throws Exception {
		return commonMapper.getAllUser(search);
	}

	public int getUserListCnt(Search search) throws Exception {
		return commonMapper.getUserListCnt(search);
	}

	public Map<String, Object> setAdmin(UserMaster param) throws Exception {
		ResultMaster resultMaster = new ResultMaster();
		resultMaster = commonMapper.setAdmin(param);
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

	public Map<String, Object> deleteAdmin(UserMaster param) throws Exception {
		ResultMaster resultMaster = new ResultMaster();
		resultMaster = commonMapper.deleteAdmin(param);
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
