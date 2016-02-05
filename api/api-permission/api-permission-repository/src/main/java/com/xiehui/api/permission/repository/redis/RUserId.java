package com.xiehui.api.permission.repository.redis;

/**
 * 用户标识接口
 * 
 * @author xiehui
 *
 */
public interface RUserId {

	/**
	 * 递增用户标识
	 * 
	 * @return 用户标识
	 */
	public Long increment();

}
