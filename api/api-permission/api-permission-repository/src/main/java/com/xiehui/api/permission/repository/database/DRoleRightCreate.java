package com.xiehui.api.permission.repository.database;

import java.sql.*;

/**
 * 角色权限创建类
 * 
 * @author xiehui
 *
 */
public class DRoleRightCreate {

	/** 角色标识 */
	private Long roleId = null;
	/** 权限标识 */
	private Long rightId = null;
	/** 创建时间 */
	private Timestamp createdTime = null;

	/**
	 * 获取角色标识
	 * 
	 * @return 角色标识
	 */
	public Long getRoleId() {
		return roleId;
	}

	/**
	 * 设置角色标识
	 * 
	 * @param roleId
	 *            角色标识
	 */
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	/**
	 * 获取权限标识
	 * 
	 * @return 权限标识
	 */
	public Long getRightId() {
		return rightId;
	}

	/**
	 * 设置权限标识
	 * 
	 * @param rightId
	 *            权限标识
	 */
	public void setRightId(Long rightId) {
		this.rightId = rightId;
	}

	/**
	 * 获取创建时间
	 * 
	 * @return 创建时间
	 */
	public Timestamp getCreatedTime() {
		return createdTime;
	}

	/**
	 * 设置创建时间
	 * 
	 * @param createdTime
	 *            创建时间
	 */
	public void setCreatedTime(Timestamp createdTime) {
		this.createdTime = createdTime;
	}

}
