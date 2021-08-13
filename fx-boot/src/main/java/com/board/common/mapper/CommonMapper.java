package com.board.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.common.model.ItemMaster;
import com.board.common.model.UserMaster;

@Mapper
public interface CommonMapper {

	public List<ItemMaster> getItemCode(ItemMaster param) throws Exception;
	public UserMaster getUserInfo(String userId) throws Exception;
}
