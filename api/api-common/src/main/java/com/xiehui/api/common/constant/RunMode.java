package com.xiehui.api.common.constant;

/**
 * 运行模式类
 * 
 * @author xiehui
 *
 */
public class RunMode {

	/** 开发 */
	public static final String DEVELOP = "develop";
	/** 测试 */
	public static final String TEST = "test";
	/** 预发布 */
	public static final String STAGE = "stage";
	/** 线上 */
	public static final String ONLINE = "online";

	/**
	 * 获取运行模式描述
	 * 
	 * @param runMode 运行模式值
	 * @return 运行模式描述
	 */
	public static String getDescription(String runMode) {
		if (DEVELOP.equals(runMode)) {
			return "开发";
		}
		if (TEST.equals(runMode)) {
			return "测试";
		}
		if (STAGE.equals(runMode)) {
			return "预发布";
		}
		if (ONLINE.equals(runMode)) {
			return "线上";
		}
		return "";
	}

}
