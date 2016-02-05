package com.xiehui.api.common.util;

import javax.servlet.http.*;

/**
 * IP地址辅助类
 * 
 * @author xiehui
 *
 */
public class IPAddressHelper {

	/**
	 * 获取远程IP地址
	 * 
	 * @param request HTTP服务请求
	 * @return 远程IP地址
	 */
	public static String getRemoteIPAddress(HttpServletRequest request) {
		String ipAddress = request.getHeader("X-Real-IP");
		if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getHeader("X-Forwarded-For");
		}
		if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getHeader("Proxy-Client-IP");
		}
		if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getRemoteAddr();
		}
		if (ipAddress != null && ipAddress.contains(",")) {
			ipAddress = ipAddress.split(",")[0].trim();
		}
		return ipAddress;
	}

}
