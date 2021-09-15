package com.board.common.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.board.common.model.ItemMaster;
import com.board.common.model.PersonDTO;
import com.board.common.model.UserMaster;
import com.board.utility.Search;

@Mapper
public interface CommonMapper {

	public List<ItemMaster> getItemCode(ItemMaster param) throws Exception;

	public UserMaster getUserInfo(String userId) throws Exception;

	public List<UserMaster> getAllUser(Search search) throws Exception;

	public int getUserListCnt(Search search) throws Exception;

	public void insertPerson(PersonDTO personDto);

	public List<PersonDTO> getPersonList();

	public Map<String, Object> setAdmin(UserMaster userMaster) throws Exception;
}
