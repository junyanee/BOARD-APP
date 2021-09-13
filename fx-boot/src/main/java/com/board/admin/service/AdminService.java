package com.board.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.admin.model.AdminMaster;
import com.board.utility.Search;

@Service
public class AdminService {
	@Autowired
	com.board.admin.mapper.AdminMapper adminMapper;

	public AdminMaster getAdminInfo(String userId) throws Exception {
		return adminMapper.getAdminInfo(userId);

	}

	public List<AdminMaster> getAdminUser(Search search) throws Exception {
		return adminMapper.getAdminUser(search);
	}

	public int getAdminListCnt(Search search) throws Exception {
		return adminMapper.getAdminListCnt(search);
	}
}
