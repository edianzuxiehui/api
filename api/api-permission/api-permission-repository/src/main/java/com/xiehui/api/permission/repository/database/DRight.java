package com.xiehui.api.permission.repository.database;

/**
 * 权限类
 * 
 * @author xiehui
 * 
 */
public class DRight {

	/** 权限标识 */
	private Long id = null;
	/** 菜单标识 */
	private Long menuId = null;
	/** 权限名称 */
	private String name = null;
	/** 权限链接 */
	private String href = null;
	/** 权限描述 */
	private String description = null;

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
	 * @param id
	 *            权限标识
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * 获取菜单标识
	 * 
	 * @return 菜单标识
	 */
	public Long getMenuId() {
		return menuId;
	}

	/**
	 * 设置菜单标识
	 * 
	 * @param menuId
	 *            菜单标识
	 */
	public void setMenuId(Long menuId) {
		this.menuId = menuId;
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
	 * @param name
	 *            权限名称
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
	 * @param href
	 *            权限链接
	 */
	public void setHref(String href) {
		this.href = href;
	}

	/**
	 * 获取权限描述
	 * 
	 * @return 权限描述
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * 设置权限描述
	 * 
	 * @param description
	 *            权限描述
	 */
	public void setDescription(String description) {
		this.description = description;
	}

}
