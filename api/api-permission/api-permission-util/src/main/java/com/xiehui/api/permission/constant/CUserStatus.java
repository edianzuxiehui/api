package com.xiehui.api.permission.constant;

/**
 * 用户状态枚举
 * 
 * @author xiehui
 *
 */
public enum CUserStatus {

	/** 字段相关 */
	/** 禁用 */
	DISABLE((short) 0, "禁用"),
	/** 启用 */
	ENABLE((short) 1, "启用");

	/** 属性相关 */
	/** 用户状态值 */
	private short value = 0;
	/** 用户状态描述 */
	private String description = null;

	/**
	 * 构造函数
	 * 
	 * @param value
	 *            用户状态值
	 * @param description
	 *            用户状态描述
	 */
	private CUserStatus(short value, String description) {
		this.value = value;
		this.description = description;
	}

	/**
	 * 获取用户状态值
	 * 
	 * @return 用户状态值
	 */
	public short getValue() {
		return value;
	}

	/**
	 * 设置用户状态值
	 * 
	 * @return 用户状态值
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * 根据值获取用户状态
	 * 
	 * @param value
	 *            用户状态值
	 * @return 用户状态
	 */
	public static CUserStatus fromValue(short value) {
		for (CUserStatus field : values()) {
			if (field.value == value) {
				return field;
			}
		}
		return null;
	}

}
