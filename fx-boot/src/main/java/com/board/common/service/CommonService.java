package com.board.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.model.BoardMaster;
import com.board.model.ItemMaster;

@Service
public class CommonService {
	@Autowired
	com.board.common.mapper.CommonMapper commonMapper;

	public List<ItemMaster> getItemCode(ItemMaster param) throws Exception{
		return commonMapper.getItemCode(param);
	}

	public List<BoardMaster> getBoardTest() throws Exception {
		return commonMapper.getBoardTest();
	}
}
