package com.xiehui.api.permission.repository.redis;

import javax.annotation.*;

import org.springframework.data.redis.core.*;
import org.springframework.stereotype.*;

/**
 * 角色标识实现类
 * 
 * @author xiehui
 *
 */
@Repository("rRoleId")
public class RRoleIdImpl implements RRoleId {

	/** Redis模板 */
	@Resource(name = "redisTemplate")
	private RedisTemplate<String, String> redisTemplate = null;

	/** 键值格式 */
	private static final String KEY = "API:Id:Role";

	/**
	 * 递增角色标识
	 * 
	 * @return 角色标识
	 */
	@Override
	public Long increment() {
		return redisTemplate.opsForValue().increment(KEY, 1l);
	}

}
