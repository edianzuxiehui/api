package com.xiehui.api.permission.repository.database;

/**
 * 角色修改类
 * 
 * @author xiehui
 *
 */
public class DRoleModify {

	/** 角色标识 */
	private Long id = null;
	/** 角色状态(0:禁用;1:启用) */
	private Short status = null;
	/** 角色名称 */
	private String name = null;
	/** 角色描述 */
	private String description = null;
	/** 附加信息 */
	private String additional = null;

	/**
	 * 获取角色标识
	 * 
	 * @return 角色标识
	 */
	public Long getId() {
		return id;
	}

	/**
	 * 设置角色标识
	 * 
	 * @param id
	 *            角色标识
	 */
	public void setId(Long id) {
		this.id = id;
	}

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
	 * 获取角色描述
	 * 
	 * @return 角色描述
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * 设置角色描述
	 * 
	 * @param description
	 *            角色描述
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * 获取附加信息
	 * 
	 * @return 附加信息
	 */
	public String getAdditional() {
		return additional;
	}

	/**
	 * 设置附加信息
	 * 
	 * @param additional
	 *            附加信息
	 */
	public void setAdditional(String additional) {
		this.additional = additional;
	}

}
