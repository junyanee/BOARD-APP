package com.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.model.ItemMaster;

@Mapper
public interface CommonMapper {

	public List<ItemMaster> getItemCode(ItemMaster param) throws Exception;
}
