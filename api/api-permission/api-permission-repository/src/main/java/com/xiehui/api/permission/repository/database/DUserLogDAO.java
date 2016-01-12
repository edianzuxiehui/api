package com.xiehui.api.permission.repository.database;

import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.*;

/**
 * 用户日志DAO接口
 * 
 * @author xiehui
 *
 */
@Repository("dUserLogDAO")
public interface DUserLogDAO {

	/**
	 * 获取用户日志
	 * 
	 * @param id
	 *            日志标识
	 * @return 用户日志
	 */
	public DUserLog get(@Param("id") Long id);

	/**
	 * 创建用户日志
	 * 
	 * @param id
	 *            日志标识
	 * @param create
	 *            用户日志创建
	 * @return 创建行数
	 */
	public Integer create(@Param("id") Long id, @Param("create") DUserLogCreate create);

}
