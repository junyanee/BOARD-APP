package com.board.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.common.mapper.CommonMapper;
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
}
