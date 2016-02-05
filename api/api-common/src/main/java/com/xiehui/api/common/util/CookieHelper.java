package com.xiehui.api.common.util;

import javax.servlet.http.*;

/**
 * Cookie辅助类
 * 
 * @author xiehui
 *
 */
public class CookieHelper {

	/**
	 * 获取Cookie值
	 * 
	 * @param cookies Cookie数组
	 * @param name Cookie名称
	 * @return Cookie值
	 */
	public static String getCookieValue(Cookie[] cookies, String name) {
		// 检查空值
		if (name == null || name.isEmpty()) {
			return null;
		}
		if (cookies == null || cookies.length == 0) {
			return null;
		}

		// 查找令牌
		for (Cookie cookie : cookies) {
			if (name.equalsIgnoreCase(cookie.getName())) {
				return cookie.getValue();
			}
		}

		// 返回空值
		return null;
	}

}
