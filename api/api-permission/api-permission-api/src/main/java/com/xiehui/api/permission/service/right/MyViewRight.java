package com.xiehui.api.permission.service.right;

import java.io.*;

/**
 * 我的视图权限类
 * 
 * @author xiehui
 * 
 */
public class MyViewRight implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7456568475573789290L;
	/** 权限标识 */
	private Long id = null;
	/** 权限名称 */
	private String name = null;
	/** 权限链接 */
	private String href = null;

	/**
	 * 获取权限标识
	 * 
	 * @return 权限标识
	 */
	public Long getId() {
		return id;
	}

	/**
	 * 设置权限标识
	 * 
	 * @param id 权限标识
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * 获取权限名称
	 * 
	 * @return 权限名称
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置权限名称
	 * 
	 * @param name 权限名称
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取权限链接
	 * 
	 * @return 权限链接
	 */
	public String getHref() {
		return href;
	}

	/**
	 * 设置权限链接
	 * 
	 * @param href 权限链接
	 */
	public void setHref(String href) {
		this.href = href;
	}

}
