package com.board.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.admin.model.AdminMaster;
import com.board.utility.Search;

@Mapper
public interface AdminMapper {

	public AdminMaster getAdminInfo(String userId) throws Exception;

	public List<AdminMaster> getAdminUser(Search search) throws Exception;

	public int getAdminListCnt(Search search) throws Exception;
}
