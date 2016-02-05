package com.xiehui.api.permission.repository.database;

import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.*;

/**
 * 角色权限DAO接口
 * 
 * @author xiehui
 *
 */
@Repository("dRoleRightDAO")
public interface DRoleRightDAO {

	/**
	 * 获取角色权限
	 * 
	 * @param roleId
	 *            角色标识
	 * @param rightId
	 *            权限标识
	 * @return 角色权限
	 */
	public DRoleRight get(@Param("roleId") Long roleId, @Param("rightId") Long rightId);

	/**
	 * 创建角色权限
	 * 
	 * @param create
	 *            角色权限创建
	 * @return 创建行数
	 */
	public Integer create(@Param("create") DRoleRightCreate create);

	/**
	 * 删除角色权限
	 * 
	 * @param roleId
	 *            角色标识
	 * @param rightId
	 *            权限标识
	 * @return 删除行数
	 */
	public Integer delete(@Param("roleId") Long roleId, @Param("rightId") Long rightId);

}
