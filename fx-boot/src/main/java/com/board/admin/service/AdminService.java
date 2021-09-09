package com.board.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.admin.model.AdminMaster;

@Service
public class AdminService {
	@Autowired
	com.board.admin.mapper.AdminMapper adminMapper;

	public AdminMaster getAdminInfo(String userId) throws Exception {
		return adminMapper.getAdminInfo(userId);

	}

}
