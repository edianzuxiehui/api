package com.xiehui.api.permission.service.menu;

import java.io.*;
import java.util.*;

/**
 * 我的菜单类
 * 
 * @author xiehui
 * 
 */
public class MyMenu implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2933083514922235101L;
	/** 菜单标识 */
	private Long id = null;
	/** 菜单名称 */
	private String name = null;
	/** 菜单链接 */
	private String href = null;
	/** 父级菜单 */
	private Long parentId = null;
	/** 菜单描述 */
	private String description = null;
	/** 菜单状态 */
	private Short status = null;
	/** 子菜单列表 */
	private List<MyMenu> childList = null;

	/**
	 * 获取菜单标识
	 * 
	 * @return 菜单标识
	 */
	public Long getId() {
		return id;
	}

	/**
	 * 设置菜单标识
	 * 
	 * @param id
	 *            菜单标识
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * 获取菜单名称
	 * 
	 * @return 菜单名称
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置菜单名称
	 * 
	 * @param name
	 *            菜单名称
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取菜单链接
	 * 
	 * @return 菜单链接
	 */
	public String getHref() {
		return href;
	}

	/**
	 * 设置菜单链接
	 * 
	 * @param href
	 *            菜单链接
	 */
	public void setHref(String href) {
		this.href = href;
	}

	/**
	 * 获取父级菜单
	 * 
	 * @return
	 */
	public Long getParentId() {
		return parentId;
	}

	/**
	 * 设置父级菜单
	 * 
	 * @param parentId
	 */
	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	/**
	 * 获取子菜单列表
	 * 
	 * @return 子菜单列表
	 */
	public List<MyMenu> getChildList() {
		return childList;
	}

	/**
	 * 设置子菜单列表
	 * 
	 * @param childList
	 *            子菜单列表
	 */
	public void setChildList(List<MyMenu> childList) {
		this.childList = childList;
	}

	/**
	 * 获取菜单描述
	 * 
	 * @return
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * 设置菜单描述
	 * 
	 * @param description
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * 获取菜单状态
	 * 
	 * @return
	 */
	public Short getStatus() {
		return status;
	}

	/**
	 * 设置菜单状态
	 * 
	 * @param status
	 */
	public void setStatus(Short status) {
		this.status = status;
	}

}
