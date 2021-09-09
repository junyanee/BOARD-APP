package com.board.admin.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.board.admin.model.AdminMaster;

@Mapper
public interface AdminMapper {

	public AdminMaster getAdminInfo(String userId) throws Exception;
}
