package com.board.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.admin.model.AdminMaster;
import com.board.common.mapper.CommonMapper;
import com.board.common.model.ResultMaster;
import com.board.utility.Search;

@Service
public class AdminService {
	@Autowired
	com.board.admin.mapper.AdminMapper adminMapper;

	public AdminMaster getAdminInfo(String userId) throws Exception {
		return adminMapper.getAdminInfo(userId);
	}

	public AdminMaster getAdminInfoByAdminCode(int adminCode) throws Exception {
		return adminMapper.getAdminInfoByAdminCode(adminCode);
	}

	public List<AdminMaster> getAdminUser(Search search) throws Exception {
		return adminMapper.getAdminUser(search);
	}

	public int getAdminListCnt(Search search) throws Exception {
		return adminMapper.getAdminListCnt(search);
	}

	public Map<String, Object> modifyAuthLevel(AdminMaster param) throws Exception {
		ResultMaster resultMaster = new ResultMaster();
		resultMaster = adminMapper.modifyAuthLevel(param);
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

	public Map<String, Object> updateBannerInfo(String bannerPath1, String bannerPath2, String bannerPath3) throws Exception {
		ResultMaster resultMaster = new ResultMaster();
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("bannerPath1", bannerPath1);
		parameterMap.put("bannerPath2", bannerPath2);
		parameterMap.put("bannerPath3", bannerPath3);
		resultMaster = adminMapper.updateBannerInfo(parameterMap);
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
