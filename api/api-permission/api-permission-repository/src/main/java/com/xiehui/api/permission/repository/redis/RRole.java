package com.xiehui.api.permission.repository.redis;

/**
 * 角色类
 * 
 * @author xiehui
 *
 */
public class RRole {

	/** 属性相关 */
	/** 角色状态(0:禁用;1:启用) */
	private Short status = null;
	/** 角色名称 */
	private String name = null;
	/** 用户描述 */
	private String description = null;

	/** 常量相关 */
	/** 角色状态(0:禁用;1:启用) */
	public static final String STATUS = "status";
	/** 角色名称 */
	public static final String NAME = "name";
	/** 用户描述 */
	public static final String DESCRIPTION = "description";

	/**
	 * 获取角色状态(0:禁用;1:启用)
	 * 
	 * @return 角色状态(0:禁用;1:启用)
	 */
	public Short getStatus() {
		return status;
	}

	/**
	 * 设置角色状态(0:禁用;1:启用)
	 * 
	 * @param status
	 *            角色状态(0:禁用;1:启用)
	 */
	public void setStatus(Short status) {
		this.status = status;
	}

	/**
	 * 获取角色名称
	 * 
	 * @return 角色名称
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置角色名称
	 * 
	 * @param name
	 *            角色名称
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取用户描述
	 * 
	 * @return 用户描述
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * 设置用户描述
	 * 
	 * @param description
	 *            用户描述
	 */
	public void setDescription(String description) {
		this.description = description;
	}

}
