package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.mapper.CommonMapper;
import com.board.model.ItemMaster;

@Service
public class CommonService {
	@Autowired
	CommonMapper commonMapper;

	public List<ItemMaster> getItemCode(ItemMaster param) throws Exception{
		return commonMapper.getItemCode(param);
	}
}
