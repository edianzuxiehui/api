package com.xiehui.api.permission.repository.redis;

/**
 * 用户日志标识接口
 * 
 * @author cychen
 *
 */
public interface RUserLogId {

	/**
	 * 递增用户日志标识
	 * 
	 * @param time
	 *            指定时间(毫秒)
	 * @return 用户日志标识
	 */
	public Long increment(long time);

}
