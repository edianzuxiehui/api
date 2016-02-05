package com.xiehui.api.common.util;

import javax.servlet.http.*;

/**
 * 请求辅助类
 * 
 * @author xiehui
 *
 */
public class RequestHelper {

	/**
	 * 获取URI
	 * 
	 * @param request HTTP请求
	 * @return URI
	 */
	public static String getURI(HttpServletRequest request) {
		String uri = request.getRequestURI();
		if (uri != null && uri.startsWith("/")) {
			return uri.substring(1);
		}
		return uri;
	}

}
