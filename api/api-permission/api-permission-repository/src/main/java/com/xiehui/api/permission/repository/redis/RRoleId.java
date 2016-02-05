package com.xiehui.api.permission.repository.redis;

/**
 * 角色标识接口
 * 
 * @author xiehui
 *
 */
public interface RRoleId {

	/**
	 * 递增角色标识
	 * 
	 * @return 角色标识
	 */
	public Long increment();

}
