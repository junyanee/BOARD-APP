package com.board.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.common.model.ItemMaster;

@Mapper
public interface CommonMapper {

	public List<ItemMaster> getItemCode(ItemMaster param) throws Exception;
}
