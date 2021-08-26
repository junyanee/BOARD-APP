package com.board.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.common.mapper.CommonMapper;
import com.board.common.model.UserMaster;

@Service
public class UserMasterService {

	@Autowired
		CommonMapper commonMapper;

	public UserMaster getUserInfo(String userId) throws Exception {
		return commonMapper.getUserInfo(userId);
	}

}
