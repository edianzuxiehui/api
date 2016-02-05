package com.xiehui.api.permission.repository.redis;

/**
 * 用户令牌值接口
 * 
 * @author xiehui
 *
 */
public interface RUserTokenValue {

	/**
	 * 设置用户令牌
	 * 
	 * @param userId
	 *            用户标识
	 * @param token
	 *            登录令牌
	 */
	public void set(Long userId, String token);

	/**
	 * 获取用户令牌
	 * 
	 * @param userId
	 *            用户标识
	 * @return 登录令牌
	 */
	public String get(Long userId);

	/**
	 * 删除用户令牌
	 * 
	 * @param userId
	 *            用户标识
	 */
	public void remove(Long userId);

	/**
	 * 存在用户令牌
	 * 
	 * @param userId
	 *            用户标识
	 * @return 是否存在
	 */
	public boolean exist(Long userId);

}
