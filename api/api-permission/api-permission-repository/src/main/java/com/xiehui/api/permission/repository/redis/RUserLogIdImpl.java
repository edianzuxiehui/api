package com.xiehui.api.permission.repository.redis;

import java.text.*;
import java.util.*;

import javax.annotation.*;

import org.springframework.data.redis.core.*;
import org.springframework.stereotype.*;

/**
 * 用户日志标识实现类
 * 
 * @author xiehui
 *
 */
@Repository("rUserLogId")
public class RUserLogIdImpl implements RUserLogId {

	/** Redis模板 */
	@Resource(name = "redisTemplate")
	private RedisTemplate<String, String> redisTemplate = null;

	/** 键值格式 */
	private static final String KEY = "API:Id:UserLog";

	/** 常量相关 */
	/** 放大倍率 */
	private static final long RATIO = 1000000000000L;
	/** 日期格式 */
	private final static SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyMMdd");

	/**
	 * 递增用户日志标识
	 * 
	 * @param time
	 *            指定时间(毫秒)
	 * @return 用户日志标识
	 */
	@Override
	public Long increment(long time) {
		// 获取数据
		long date = Long.parseLong(DATE_FORMAT.format(new Date(time)));
		long index = redisTemplate.opsForValue().increment(KEY, 1l);

		// 返回数据
		return date * RATIO + index % RATIO;
	}

}
