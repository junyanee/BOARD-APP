package com.board.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.common.mapper.CommonMapper;
import com.board.common.model.BannerMaster;
import com.board.common.model.ItemMaster;
import com.board.common.model.PersonDTO;

@Service
public class CommonService {
	@Autowired
	CommonMapper commonMapper;

	public List<ItemMaster> getItemCode(ItemMaster param) throws Exception {
		return commonMapper.getItemCode(param);
	}

	public void insertPerson(PersonDTO personDto) throws Exception {
		commonMapper.insertPerson(personDto);
	}

	public List<PersonDTO> getPersonList() throws Exception {
		return commonMapper.getPersonList();
	}

	public List<BannerMaster> getBannerInfo() throws Exception {
		return commonMapper.getBannerInfo();
	}

}
