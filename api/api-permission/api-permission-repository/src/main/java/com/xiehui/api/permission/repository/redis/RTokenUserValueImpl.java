package com.xiehui.api.permission.repository.redis;

import java.text.*;
import java.util.concurrent.*;

import javax.annotation.*;

import org.springframework.data.redis.core.*;
import org.springframework.stereotype.*;

/**
 * 令牌用户值实现类
 * 
 * @author xiehui
 *
 */
@Repository("rTokenUserValue")
public class RTokenUserValueImpl implements RTokenUserValue {

	/** Redis模板 */
	@Resource(name = "redisTemplate")
	private RedisTemplate<String, String> redisTemplate = null;

	/** 键值格式 */
	private static final MessageFormat KEY_FORMAT = new MessageFormat("API:Value:TokenUser:{0}");

	/**
	 * 设置令牌用户
	 * 
	 * @param token
	 *            登录令牌
	 * @param userId
	 *            用户标识
	 */
	@Override
	public void set(String token, Long userId) {
		// 初始化
		String key = KEY_FORMAT.format(new String[] { token });

		// 调用接口
		redisTemplate.opsForValue().set(key, userId.toString());
	}

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
	@Override
	public void set(String token, Long userId, long timeout, TimeUnit unit) {
		// 初始化
		String key = KEY_FORMAT.format(new String[] { token });

		// 调用接口
		redisTemplate.opsForValue().set(key, userId.toString(), timeout, unit);
	}

	/**
	 * 获取令牌用户
	 * 
	 * @param token
	 *            登录令牌
	 * @return 用户标识
	 */
	@Override
	public Long get(String token) {
		// 初始化
		String key = KEY_FORMAT.format(new String[] { token });

		// 调用接口
		String userId = redisTemplate.opsForValue().get(key);

		// 返回数据
		if (userId != null) {
			return Long.parseLong(userId);
		}
		return null;
	}

	/**
	 * 删除令牌用户
	 * 
	 * @param token
	 *            登录令牌
	 */
	@Override
	public void remove(String token) {
		// 初始化
		String key = KEY_FORMAT.format(new String[] { token });

		// 调用接口
		redisTemplate.delete(key);
	}

	/**
	 * 存在令牌用户
	 * 
	 * @param token
	 *            登录令牌
	 * @return 是否存在
	 */
	@Override
	public boolean exist(String token) {
		// 初始化
		String key = KEY_FORMAT.format(new String[] { token });

		// 调用接口
		return redisTemplate.hasKey(key);
	}

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
	@Override
	public void setExpire(String token, long timeout, TimeUnit unit) {
		// 初始化
		String key = KEY_FORMAT.format(new String[] { token });

		// 调用接口
		redisTemplate.expire(key, timeout, unit);
	}

	/**
	 * 获取超时时间
	 * 
	 * @param token
	 *            登录令牌
	 * @param unit
	 *            时间单位
	 * @return 超时时间
	 */
	@Override
	public Long getExpire(String token, TimeUnit unit) {
		// 初始化
		String key = KEY_FORMAT.format(new String[] { token });

		// 调用接口
		return redisTemplate.getExpire(key, unit);
	}

}
