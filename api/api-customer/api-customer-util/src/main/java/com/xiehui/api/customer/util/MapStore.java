package com.xiehui.api.customer.util;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Map 存储类
 * 
 * @author xiehui
 *
 */
public class MapStore {

	/** 声明一个线程安全的Map类 */
	private static final Map<String, Object> map = new ConcurrentHashMap<String, Object>();

	/**
	 * 赋值
	 * 
	 * @param str
	 *            map的key值
	 * @param obj
	 *            key对应的值
	 */
	public static void setData(String str, Object obj) {
		map.put(str, obj);
	}

	/**
	 * 根据key获取map里的值
	 * 
	 * @param str
	 *            map的key
	 * @return key对应的值
	 */
	public static Object getData(String str) {
		Object obj = null;
		obj = map.get(str);
		return obj;
	}

	public static void delData(String str) {
		map.remove(str);
	}

}
