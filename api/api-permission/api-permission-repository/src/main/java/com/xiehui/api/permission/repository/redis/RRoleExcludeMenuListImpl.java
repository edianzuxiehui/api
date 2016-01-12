package com.xiehui.api.permission.repository.redis;

import java.text.*;
import java.util.*;

import javax.annotation.*;

import org.springframework.data.redis.core.*;
import org.springframework.stereotype.*;

/**
 * 角色排除菜单列表实现类
 * 
 * @author xiehui
 *
 */
@Repository("rRoleExcludeMenuList")
public class RRoleExcludeMenuListImpl implements RRoleExcludeMenuList {

	/** Redis模板 */
	@Resource(name = "redisTemplate")
	private RedisTemplate<String, String> redisTemplate = null;

	/** 键值格式 */
	private static final MessageFormat KEY_FORMAT = new MessageFormat("API:List:RRoleExcludeMenuList:{0}");

	/**
	 * 添加菜单链接
	 * 
	 * @param id
	 *            角色标识
	 * @param href
	 *            菜单链接
	 */
	@Override
	public void add(Long id, String href) {
		// 生成键值
		String key = KEY_FORMAT.format(new Long[] { id });

		// 删除取值
		redisTemplate.opsForList().remove(key, 0l, href.toString());

		// 添加取值
		redisTemplate.opsForList().rightPush(key, href.toString());
	}

	/**
	 * 删除菜单链接
	 * 
	 * @param id
	 *            角色标识
	 * @param href
	 *            菜单链接
	 */
	@Override
	public void remove(Long id, String href) {
		// 生成键值
		String key = KEY_FORMAT.format(new Long[] { id });

		// 删除取值
		redisTemplate.opsForList().remove(key, 0l, href.toString());
	}

	/**
	 * 存在菜单链接
	 * 
	 * @param id
	 *            角色标识
	 * @param href
	 *            菜单链接
	 * @return 是否存在
	 */
	@Override
	public Boolean exist(Long id, String href) {
		// 生成键值
		String key = KEY_FORMAT.format(new Long[] { id });

		// 依次检查
		List<String> valueList = redisTemplate.opsForList().range(key, 0l, -1l);
		if (valueList != null) {
			for (String value : valueList) {
				if (href.toString().equals(value)) {
					return Boolean.TRUE;
				}
			}
		}

		// 返回失败
		return Boolean.FALSE;
	}

	/**
	 * 获取列表大小
	 * 
	 * @param id
	 *            角色标识
	 * @return 列表大小
	 */
	@Override
	public Long size(Long id) {
		// 生成键值
		String key = KEY_FORMAT.format(new Long[] { id });

		// 返回大小
		return redisTemplate.opsForList().size(key);
	}

	/**
	 * 最后菜单链接
	 * 
	 * @param id
	 *            角色标识
	 * @return 菜单链接
	 */
	@Override
	public String last(Long id) {
		// 生成键值
		String key = KEY_FORMAT.format(new Long[] { id });

		// 返回数据
		return redisTemplate.opsForList().index(key, -1l);
	}

	/**
	 * 清除列表内容
	 * 
	 * @param id
	 *            角色标识
	 */
	@Override
	public void clear(Long id) {
		// 生成键值
		String key = KEY_FORMAT.format(new Long[] { id });

		// 删除列表
		redisTemplate.delete(key);
	}

	/**
	 * 获取菜单链接
	 * 
	 * @param id
	 *            角色标识
	 * @param startIndex
	 *            开始序号
	 * @param endIndex
	 *            结束序号
	 * @return 菜单链接列表
	 */
	public List<String> range(Long id, Long startIndex, Long endIndex) {
		// 生成键值
		String key = KEY_FORMAT.format(new Long[] { id });

		// 返回列表
		return redisTemplate.opsForList().range(key, startIndex, endIndex);
	}

}
