package com.xiehui.api.permission.repository.redis;

/**
 * 用户类
 * 
 * @author xiehui
 *
 */
public class RUser {

	/** 属性相关 */
	/** 角色标识 */
	private Long roleId = null;
	/** 部门标识 */
	private Long departmentId = null;
	/** 用户状态(0:禁用;1:启用) */
	private Short status = null;
	/** 用户邮箱 */
	private String email = null;
	/** 用户电话 */
	private String phone = null;
	/** 用户姓名 */
	private String name = null;
	/** 用户头像 */
	private String avatar = null;
	/** 用户描述 */
	private String description = null;

	/** 常量相关 */
	/** 角色标识 */
	public static final String ROLEID = "roleId";
	/** 部门标识 */
	public static final String DEPARTMENTID = "departmentId";
	/** 用户状态(0:禁用;1:启用) */
	public static final String STATUS = "status";
	/** 用户邮箱 */
	public static final String EMAIL = "email";
	/** 用户电话 */
	public static final String PHONE = "phone";
	/** 用户姓名 */
	public static final String NAME = "name";
	/** 用户头像 */
	public static final String AVATAR = "avatar";
	/** 用户描述 */
	public static final String DESCRIPTION = "description";

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
	 * 获取部门标识
	 * 
	 * @return 部门标识
	 */
	public Long getDepartmentId() {
		return departmentId;
	}

	/**
	 * 设置部门标识
	 * 
	 * @param departmentId
	 *            部门标识
	 */
	public void setDepartmentId(Long departmentId) {
		this.departmentId = departmentId;
	}

	/**
	 * 获取用户状态(0:禁用;1:启用)
	 * 
	 * @return 用户状态(0:禁用;1:启用)
	 */
	public Short getStatus() {
		return status;
	}

	/**
	 * 设置用户状态(0:禁用;1:启用)
	 * 
	 * @param status
	 *            用户状态(0:禁用;1:启用)
	 */
	public void setStatus(Short status) {
		this.status = status;
	}

	/**
	 * 获取用户邮箱
	 * 
	 * @return 用户邮箱
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * 设置用户邮箱
	 * 
	 * @param email
	 *            用户邮箱
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * 获取用户电话
	 * 
	 * @return 用户电话
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * 设置用户电话
	 * 
	 * @param phone
	 *            用户电话
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * 获取用户姓名
	 * 
	 * @return 用户姓名
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置用户姓名
	 * 
	 * @param name
	 *            用户姓名
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取用户头像
	 * 
	 * @return 用户头像
	 */
	public String getAvatar() {
		return avatar;
	}

	/**
	 * 设置用户头像
	 * 
	 * @param avatar
	 *            用户头像
	 */
	public void setAvatar(String avatar) {
		this.avatar = avatar;
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
