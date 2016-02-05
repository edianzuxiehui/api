package com.xiehui.api.permission.constant;

/**
 * 角色状态枚举
 * 
 * @author xiehui
 *
 */
public enum CRoleStatus {

	/** 字段相关 */
	/** 禁用 */
	DISABLE((short) 0, "禁用"),
	/** 启用 */
	ENABLE((short) 1, "启用");

	/** 属性相关 */
	/** 角色状态值 */
	private short value = 0;
	/** 角色状态描述 */
	private String description = null;

	/**
	 * 构造函数
	 * 
	 * @param value
	 *            角色状态值
	 * @param description
	 *            角色状态描述
	 */
	private CRoleStatus(short value, String description) {
		this.value = value;
		this.description = description;
	}

	/**
	 * 获取角色状态值
	 * 
	 * @return 角色状态值
	 */
	public short getValue() {
		return value;
	}

	/**
	 * 设置角色状态值
	 * 
	 * @return 角色状态值
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * 根据值获取角色状态
	 * 
	 * @param value
	 *            角色状态值
	 * @return 角色状态
	 */
	public static CRoleStatus fromValue(short value) {
		for (CRoleStatus field : values()) {
			if (field.value == value) {
				return field;
			}
		}
		return null;
	}

}
