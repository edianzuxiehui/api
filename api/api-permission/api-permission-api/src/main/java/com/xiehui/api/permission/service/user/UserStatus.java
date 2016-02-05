package com.xiehui.api.permission.service.user;

import java.io.*;

/**
 * 用户状态类
 * 
 * @author xiehui
 * 
 */
public class UserStatus implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2252896432551269320L;
	/** 状态标识 */
	private Short id = null;
	/** 状态名称 */
	private String name = null;

	/**
	 * 获取状态标识
	 * 
	 * @return 状态标识
	 */
	public Short getId() {
		return id;
	}

	/**
	 * 设置状态标识
	 * 
	 * @param id
	 *            状态标识
	 */
	public void setId(Short id) {
		this.id = id;
	}

	/**
	 * 获取状态名称
	 * 
	 * @return 状态名称
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置状态名称
	 * 
	 * @param name
	 *            状态名称
	 */
	public void setName(String name) {
		this.name = name;
	}

}
