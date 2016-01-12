package com.xiehui.api.permission.repository.redis;

import java.text.*;
import java.util.*;

import javax.annotation.*;

import org.springframework.data.redis.core.*;
import org.springframework.stereotype.*;

/**
 * 角色对象实现类
 * 
 * @author xiehui
 *
 */
@Repository("rRoleObject")
public class RRoleObjectImpl implements RRoleObject {

	/** Redis模板 */
	@Resource(name = "redisTemplate")
	private RedisTemplate<String, String> redisTemplate = null;

	/** 键值格式 */
	private static final MessageFormat KEY_FORMAT = new MessageFormat("API:Object:Role:{0}");

	/**
	 * 设置角色对象
	 * 
	 * @param id
	 *            角色标识
	 * @param role
	 *            角色对象
	 */
	@Override
	public void set(Long id, RRole role) {
		// 初始化
		Map<String, String> map = new HashMap<String, String>();
		String key = KEY_FORMAT.format(new Long[] { id });

		// 赋值参数
		if (role.getStatus() != null) {
			map.put(RRole.STATUS, role.getStatus().toString());
		}
		if (role.getName() != null) {
			map.put(RRole.NAME, role.getName());
		}
		if (role.getDescription() != null) {
			map.put(RRole.DESCRIPTION, role.getDescription());
		}

		// 调用接口
		redisTemplate.opsForHash().putAll(key, map);
	}

	/**
	 * 获取角色对象
	 * 
	 * @param id
	 *            角色标识
	 * @return 角色对象
	 */
	@Override
	public RRole get(Long id) {
		// 初始化
		RRole role = null;
		List<String> keyList = new ArrayList<String>();
		String key = KEY_FORMAT.format(new Long[] { id });

		// 赋值参数
		keyList.add(RRole.STATUS);
		keyList.add(RRole.NAME);
		keyList.add(RRole.DESCRIPTION);

		// 调用接口
		HashOperations<String, String, String> objectOperations = redisTemplate.opsForHash();
		List<String> valueList = objectOperations.multiGet(key, keyList);

		// 转化数据
		if (valueList != null && !valueList.isEmpty()) {
			role = new RRole();
			String[] valueArray = valueList.toArray(new String[0]);
			int length = valueArray.length;
			if (length > 0 && valueArray[0] != null) {
				role.setStatus(Short.parseShort(valueArray[0]));
			}
			if (length > 1 && valueArray[1] != null) {
				role.setName(valueArray[1]);
			}
			if (length > 2 && valueArray[2] != null) {
				role.setDescription(valueArray[2]);
			}
		}

		// 返回数据
		return role;
	}

	/**
	 * 删除角色对象
	 * 
	 * @param id
	 *            角色标识
	 */
	@Override
	public void remove(Long id) {
		// 初始化
		String key = KEY_FORMAT.format(new Long[] { id });

		// 调用接口
		redisTemplate.delete(key);
	}

	/**
	 * 存在角色对象
	 * 
	 * @param id
	 *            角色标识
	 * @return 是否存在
	 */
	@Override
	public boolean exist(Long id) {
		// 初始化
		String key = KEY_FORMAT.format(new Long[] { id });

		// 调用接口
		return redisTemplate.hasKey(key);
	}

	/**
	 * 设置参数值
	 * 
	 * @param id
	 *            角色标识
	 * @param name
	 *            参数名称
	 * @param value
	 *            参数值
	 */
	@Override
	public void set(Long id, String name, String value) {
		// 初始化
		String key = KEY_FORMAT.format(new Long[] { id });

		// 调用接口
		redisTemplate.opsForHash().put(key, name, value);
	}

	/**
	 * 获取参数值
	 * 
	 * @param id
	 *            角色标识
	 * @param name
	 *            参数名称
	 * @return 参数值
	 */
	@Override
	public String get(Long id, String name) {
		// 初始化
		String key = KEY_FORMAT.format(new Long[] { id });

		// 调用接口
		HashOperations<String, String, String> objectOperations = redisTemplate.opsForHash();
		return objectOperations.get(key, name);
	}

	/**
	 * 删除参数值
	 * 
	 * @param id
	 *            角色标识
	 * @param name
	 *            参数名称
	 */
	@Override
	public void remove(Long id, String name) {
		// 初始化
		String key = KEY_FORMAT.format(new Long[] { id });

		// 调用接口
		HashOperations<String, String, String> objectOperations = redisTemplate.opsForHash();
		objectOperations.delete(key, name);
	}

	/**
	 * 存在参数值
	 * 
	 * @param id
	 *            角色标识
	 * @param name
	 *            参数名称
	 * @return 持久化异常
	 */
	@Override
	public boolean exist(Long id, String name) {
		// 初始化
		String key = KEY_FORMAT.format(new Long[] { id });

		// 调用接口
		HashOperations<String, String, String> objectOperations = redisTemplate.opsForHash();
		return objectOperations.hasKey(key, name);
	}

}
