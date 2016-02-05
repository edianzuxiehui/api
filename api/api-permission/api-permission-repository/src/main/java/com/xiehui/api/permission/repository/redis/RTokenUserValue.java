package com.xiehui.api.permission.repository.redis;

import java.util.concurrent.*;

/**
 * 令牌用户值接口
 * 
 * @author xiehui
 *
 */
public interface RTokenUserValue {

	/**
	 * 设置令牌用户
	 * 
	 * @param token
	 *            登录令牌
	 * @param userId
	 *            用户标识
	 */
	public void set(String token, Long userId);

	/**
	 * 设置令牌用户
	 * 
	 * @param token
	 *            登录令牌
	 * @param userId
	 *            用户标识
	 * @param timeout
	 *            超时时间
	 * @param unit
	 *            超时单位
	 */
	public void set(String token, Long userId, long timeout, TimeUnit unit);

	/**
	 * 获取令牌用户
	 * 
	 * @param token
	 *            登录令牌
	 * @return 用户标识
	 */
	public Long get(String token);

	/**
	 * 删除令牌用户
	 * 
	 * @param token
	 *            登录令牌
	 */
	public void remove(String token);

	/**
	 * 存在令牌用户
	 * 
	 * @param token
	 *            登录令牌
	 * @return 是否存在
	 */
	public boolean exist(String token);

	/**
	 * 设置超时时间
	 * 
	 * @param token
	 *            登录令牌
	 * @param timeout
	 *            超时时间
	 * @param unit
	 *            时间单位
	 */
	public void setExpire(String token, long timeout, TimeUnit unit);

	/**
	 * 获取超时时间
	 * 
	 * @param token
	 *            登录令牌
	 * @param unit
	 *            时间单位
	 * @return 超时时间
	 */
	public Long getExpire(String token, TimeUnit unit);

}
