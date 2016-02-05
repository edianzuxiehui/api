package com.xiehui.api.permission.repository.redis;

import javax.annotation.*;

import org.springframework.data.redis.core.*;
import org.springframework.stereotype.*;

/**
 * 用户标识实现类
 * 
 * @author xiehui
 *
 */
@Repository("rUserId")
public class RUserIdImpl implements RUserId {

	/** Redis模板 */
	@Resource(name = "redisTemplate")
	private RedisTemplate<String, String> redisTemplate = null;

	/** 键值格式 */
	private static final String KEY = "API:Id:User";

	/**
	 * 递增用户标识
	 * 
	 * @return 用户标识
	 */
	@Override
	public Long increment() {
		return redisTemplate.opsForValue().increment(KEY, 1l);
	}

}
