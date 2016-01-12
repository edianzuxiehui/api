package com.xiehui.api.permission.repository.redis;

import java.text.*;

import javax.annotation.*;

import org.springframework.data.redis.core.*;
import org.springframework.stereotype.*;

/**
 * 用户令牌值实现类
 * 
 * @author xiehui
 *
 */
@Repository("rUserTokenValue")
public class RUserTokenValueImpl implements RUserTokenValue {

	/** Redis模板 */
	@Resource(name = "redisTemplate")
	private RedisTemplate<String, String> redisTemplate = null;

	/** 键值格式 */
	private static final MessageFormat KEY_FORMAT = new MessageFormat("API:Value:UserToken:{0}");

	/**
	 * 设置用户令牌
	 * 
	 * @param userId
	 *            用户标识
	 * @param token
	 *            登录令牌
	 */
	@Override
	public void set(Long userId, String token) {
		// 初始化
		String key = KEY_FORMAT.format(new Long[] { userId });

		// 调用接口
		redisTemplate.opsForValue().set(key, token);
	}

	/**
	 * 获取用户令牌
	 * 
	 * @param userId
	 *            用户标识
	 * @return 登录令牌
	 */
	@Override
	public String get(Long userId) {
		// 初始化
		String key = KEY_FORMAT.format(new Long[] { userId });

		// 调用接口
		return redisTemplate.opsForValue().get(key);
	}

	/**
	 * 删除用户令牌
	 * 
	 * @param userId
	 *            用户标识
	 */
	@Override
	public void remove(Long userId) {
		// 初始化
		String key = KEY_FORMAT.format(new Long[] { userId });

		// 调用接口
		redisTemplate.delete(key);
	}

	/**
	 * 存在用户令牌
	 * 
	 * @param userId
	 *            用户标识
	 * @return 是否存在
	 */
	@Override
	public boolean exist(Long userId) {
		// 初始化
		String key = KEY_FORMAT.format(new Long[] { userId });

		// 调用接口
		return redisTemplate.hasKey(key);
	}

}
