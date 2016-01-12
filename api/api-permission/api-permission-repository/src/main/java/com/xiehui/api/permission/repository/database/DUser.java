package com.xiehui.api.permission.repository.database;

import java.sql.*;

/**
 * 用户类
 * 
 * @author xiehui
 * 
 */
public class DUser {

	/** 用户标识 */
	private Long id = null;
	/** 角色标识 */
	private Long roleId = null;
	/** 用户状态(0:禁用;1:启用) */
	private Short status = null;
	/** 用户邮箱 */
	private String email = null;
	/** 用户密码 */
	private String password = null;
	/** 用户电话 */
	private String phone = null;
	/** 用户姓名 */
	private String name = null;
	/** 用户头像 */
	private String avatar = null;
	/** 登录时间 */
	private Timestamp loginTime = null;
	/** 登录地址 */
	private String loginIp = null;
	/** 登录秘钥 */
	private String loginSecret = null;
	/** 用户描述 */
	private String description = null;
	/** 创建时间 */
	private Timestamp createdTime = null;
	/** 修改时间 */
	private Timestamp modifiedTime = null;
	/** 附加信息 */
	private String additional = null;

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
	 * 获取用户密码
	 * 
	 * @return 用户密码
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * 设置用户密码
	 * 
	 * @param password
	 *            用户密码
	 */
	public void setPassword(String password) {
		this.password = password;
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
	 * 获取登录时间
	 * 
	 * @return 登录时间
	 */
	public Timestamp getLoginTime() {
		return loginTime;
	}

	/**
	 * 设置登录时间
	 * 
	 * @param loginTime
	 *            登录时间
	 */
	public void setLoginTime(Timestamp loginTime) {
		this.loginTime = loginTime;
	}

	/**
	 * 获取登录地址
	 * 
	 * @return 登录地址
	 */
	public String getLoginIp() {
		return loginIp;
	}

	/**
	 * 设置登录地址
	 * 
	 * @param loginIp
	 *            登录地址
	 */
	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}

	/**
	 * 获取登录秘钥
	 * 
	 * @return 登录秘钥
	 */
	public String getLoginSecret() {
		return loginSecret;
	}

	/**
	 * 设置登录秘钥
	 * 
	 * @param loginSecret
	 *            登录秘钥
	 */
	public void setLoginSecret(String loginSecret) {
		this.loginSecret = loginSecret;
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

	/**
	 * 获取修改时间
	 * 
	 * @return 修改时间
	 */
	public Timestamp getModifiedTime() {
		return modifiedTime;
	}

	/**
	 * 设置修改时间
	 * 
	 * @param modifiedTime
	 *            修改时间
	 */
	public void setModifiedTime(Timestamp modifiedTime) {
		this.modifiedTime = modifiedTime;
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
