package com.xiehui.api.permission.repository.database;

import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.*;

/**
 * 角色DAO接口
 * 
 * @author xiehui
 *
 */
@Repository("dRoleDAO")
public interface DRoleDAO {

	/**
	 * 获取角色
	 * 
	 * @param id
	 *            角色标识
	 * @return 角色
	 */
	public DRole get(@Param("id") Long id);

	/**
	 * 创建角色
	 * 
	 * @param id
	 *            角色标识
	 * @param create
	 *            角色创建
	 * @return 创建行数
	 */
	public Integer create(@Param("id") Long id, @Param("create") DRoleCreate create);

	/**
	 * 修改角色
	 * 
	 * @param modify
	 *            角色修改
	 * @return 修改行数
	 */
	public Integer modify(@Param("modify") DRoleModify modify);

}
