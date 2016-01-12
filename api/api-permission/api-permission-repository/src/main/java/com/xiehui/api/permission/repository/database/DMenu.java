package com.xiehui.api.permission.repository.database;

/**
 * 菜单类
 * 
 * @author xiehui
 * 
 */
public class DMenu {

	/** 菜单标识 */
	private Long id = null;
	/** 父菜单标识 */
	private Long parentId = null;
	/** 菜单状态(0:隐藏;1:显示) */
	private Short status = null;
	/** 菜单名称 */
	private String name = null;
	/** 菜单链接 */
	private String href = null;
	/** 菜单描述 */
	private String description = null;

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
	 * 获取父菜单标识
	 * 
	 * @return 父菜单标识
	 */
	public Long getParentId() {
		return parentId;
	}

	/**
	 * 设置父菜单标识
	 * 
	 * @param parentId
	 *            父菜单标识
	 */
	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	/**
	 * 获取菜单状态(0:隐藏;1:显示)
	 * 
	 * @return 菜单状态(0:隐藏;1:显示)
	 */
	public Short getStatus() {
		return status;
	}

	/**
	 * 设置菜单状态(0:隐藏;1:显示)
	 * 
	 * @param status
	 *            菜单状态(0:隐藏;1:显示)
	 */
	public void setStatus(Short status) {
		this.status = status;
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
	 * 获取菜单描述
	 * 
	 * @return 菜单描述
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * 设置菜单描述
	 * 
	 * @param description
	 *            菜单描述
	 */
	public void setDescription(String description) {
		this.description = description;
	}

}
