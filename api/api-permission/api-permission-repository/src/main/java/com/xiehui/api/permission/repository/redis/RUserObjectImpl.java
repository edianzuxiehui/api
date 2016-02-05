package com.xiehui.api.permission.repository.redis;

import java.text.*;
import java.util.*;

import javax.annotation.*;

import org.springframework.data.redis.core.*;
import org.springframework.stereotype.*;

/**
 * 用户对象实现类
 * 
 * @author xiehui
 *
 */
@Repository("rUserObject")
public class RUserObjectImpl implements RUserObject {

	/** Redis模板 */
	@Resource(name = "redisTemplate")
	private RedisTemplate<String, String> redisTemplate = null;

	/** 键值格式 */
	private static final MessageFormat KEY_FORMAT = new MessageFormat("API:Object:User:{0}");

	/**
	 * 设置用户对象
	 * 
	 * @param id
	 *            用户标识
	 * @param user
	 *            用户对象
	 */
	@Override
	public void set(Long id, RUser user) {
		// 初始化
		Map<String, String> map = new HashMap<String, String>();
		String key = KEY_FORMAT.format(new Long[] { id });

		// 赋值参数
		if (user.getRoleId() != null) {
			map.put(RUser.ROLEID, user.getRoleId().toString());
		}
		if (user.getDepartmentId() != null) {
			map.put(RUser.DEPARTMENTID, user.getDepartmentId().toString());
		}
		if (user.getStatus() != null) {
			map.put(RUser.STATUS, user.getStatus().toString());
		}
		if (user.getEmail() != null) {
			map.put(RUser.EMAIL, user.getEmail());
		}
		if (user.getPhone() != null) {
			map.put(RUser.PHONE, user.getPhone());
		}
		if (user.getName() != null) {
			map.put(RUser.NAME, user.getName());
		}
		if (user.getAvatar() != null) {
			map.put(RUser.AVATAR, user.getAvatar());
		}
		if (user.getDescription() != null) {
			map.put(RUser.DESCRIPTION, user.getDescription());
		}

		// 调用接口
		redisTemplate.opsForHash().putAll(key, map);
	}

	/**
	 * 获取用户对象
	 * 
	 * @param id
	 *            用户标识
	 * @return 用户对象
	 */
	@Override
	public RUser get(Long id) {
		// 初始化
		RUser user = null;
		List<String> keyList = new ArrayList<String>();
		String key = KEY_FORMAT.format(new Long[] { id });

		// 赋值参数
		keyList.add(RUser.ROLEID);
		keyList.add(RUser.DEPARTMENTID);
		keyList.add(RUser.STATUS);
		keyList.add(RUser.EMAIL);
		keyList.add(RUser.PHONE);
		keyList.add(RUser.NAME);
		keyList.add(RUser.AVATAR);
		keyList.add(RUser.DESCRIPTION);

		// 调用接口
		HashOperations<String, String, String> objectOperations = redisTemplate.opsForHash();
		List<String> valueList = objectOperations.multiGet(key, keyList);

		// 转化数据
		if (valueList != null && !valueList.isEmpty()) {
			user = new RUser();
			String[] valueArray = valueList.toArray(new String[0]);
			int length = valueArray.length;
			if (length > 0 && valueArray[0] != null) {
				user.setRoleId(Long.parseLong(valueArray[0]));
			}
			if (length > 1 && valueArray[1] != null) {
				user.setDepartmentId(Long.parseLong(valueArray[1]));
			}
			if (length > 2 && valueArray[2] != null) {
				user.setStatus(Short.parseShort(valueArray[2]));
			}
			if (length > 3 && valueArray[3] != null) {
				user.setEmail(valueArray[3]);
			}
			if (length > 4 && valueArray[4] != null) {
				user.setPhone(valueArray[4]);
			}
			if (length > 5 && valueArray[5] != null) {
				user.setName(valueArray[5]);
			}
			if (length > 6 && valueArray[6] != null) {
				user.setAvatar(valueArray[6]);
			}
			if (length > 7 && valueArray[7] != null) {
				user.setDescription(valueArray[7]);
			}
		}

		// 返回数据
		return user;
	}

	/**
	 * 删除用户对象
	 * 
	 * @param id
	 *            用户标识
	 */
	@Override
	public void remove(Long id) {
		// 初始化
		String key = KEY_FORMAT.format(new Long[] { id });

		// 调用接口
		redisTemplate.delete(key);
	}

	/**
	 * 存在用户对象
	 * 
	 * @param id
	 *            用户标识
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
	 *            用户标识
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
	 *            用户标识
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
	 *            用户标识
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
	 *            用户标识
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
