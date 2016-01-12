package com.xiehui.api.common.util;

import java.security.*;

import org.slf4j.*;

/**
 * 加密辅助类
 * 
 * @author xiehui
 *
 */
public class EncryptHelper {

	/** 日志相关 */
	private static final Logger LOGGER = LoggerFactory.getLogger(EncryptHelper.class);

	/**
	 * 转化MD5编码
	 * 
	 * @param value 字符串值
	 * @return MD5编码
	 */
	public static String toMD5(String value) {
		try {
			MessageDigest digest = MessageDigest.getInstance("MD5");
			digest.update(value.getBytes());
			return HexHelper.toHexFromBytes(digest.digest());
		}
		catch (NoSuchAlgorithmException e) {
			LOGGER.warn("转化MD5编码异常", e);
		}
		return "";
	}

}
