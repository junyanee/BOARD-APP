package com.board.common.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.board.common.model.BannerMaster;
import com.board.common.model.ItemMaster;
import com.board.common.model.PersonDTO;
import com.board.common.model.ResultMaster;
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

	public ResultMaster setAdmin(UserMaster param) throws Exception;

	public ResultMaster deleteAdmin(UserMaster param) throws Exception;

	public List<UserMaster> getUserInfoBySearch(Search search) throws Exception;

	public List<BannerMaster> getBannerInfo() throws Exception;
}
