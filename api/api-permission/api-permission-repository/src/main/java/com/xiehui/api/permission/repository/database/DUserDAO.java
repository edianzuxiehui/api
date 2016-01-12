package com.xiehui.api.permission.repository.database;

import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.*;

/**
 * 用户DAO接口
 * 
 * @author xiehui
 *
 */
@Repository("dUserDAO")
public interface DUserDAO {

	/**
	 * 获取用户
	 * 
	 * @param id
	 *            用户标识
	 * @return 用户
	 */
	public DUser get(@Param("id") Long id);

	/**
	 * 创建用户
	 * 
	 * @param id
	 *            用户标识
	 * @param create
	 *            用户创建
	 * @return 创建行数
	 */
	public Integer create(@Param("id") Long id, @Param("create") DUserCreate create);

	/**
	 * 修改用户
	 * 
	 * @param modify
	 *            用户修改
	 * @return 修改行数
	 */
	public Integer modify(@Param("modify") DUserModify modify);

	/**
	 * 
	 * @param email
	 * @return
	 */
	public DUser getByEmail(@Param("email") String email);

}
