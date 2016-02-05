package com.xiehui.api.permission.service.role;

import java.io.*;

/**
 * 角色类
 * 
 * @author xiehui
 * 
 */
public class Role implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5532456312458286237L;
	/** 用户标识 */
	private Long id = null;
	/** 角色状态(0:禁用;1:启用) */
	private Short status = null;
	/** 角色名称 */
	private String name = null;
	/** 角色描述 */
	private String description = null;
	/** 创建时间(YYYY-MM-DD HH:MM:SS) */
	private String createTime = null;

	/**
	 * 获取用户标识
	 * 
	 * @return 用户标识
	 */
	public Long getId() {
		return id;
	}

	/**
	 * 设置用户标识
	 * 
	 * @param id
	 *            用户标识
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
	 * 获取创建时间(YYYY-MM-DD HH:MM:SS)
	 * 
	 * @return 创建时间(YYYY-MM-DD HH:MM:SS)
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置创建时间(YYYY-MM-DD HH:MM:SS)
	 * 
	 * @param createTime
	 *            创建时间(YYYY-MM-DD HH:MM:SS)
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}
