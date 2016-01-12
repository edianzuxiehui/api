package com.xiehui.api.permission.service.user;

import java.io.*;

/**
 * 我的用户类
 * 
 * @author xiehui
 * 
 */
public class MyUser implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6584508340847786386L;
	/** 用户标识 */
	private Long id = null;
	/** 用户电话 */
	private String phone = null;
	/** 用户姓名 */
	private String name = null;
	/** 用户头像 */
	private String avatar = null;
	/** 角色名称 */
	private String roleName = null;

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
	 * 获取角色名称
	 * 
	 * @return 角色名称
	 */
	public String getRoleName() {
		return roleName;
	}

	/**
	 * 设置角色名称
	 * 
	 * @param roleName
	 *            角色名称
	 */
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

}
