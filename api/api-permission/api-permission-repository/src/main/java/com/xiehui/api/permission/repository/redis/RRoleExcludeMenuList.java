package com.xiehui.api.permission.repository.redis;

import java.util.*;

/**
 * 角色排除菜单列表接口
 * 
 * @author xiehui
 *
 */
public interface RRoleExcludeMenuList {

	/**
	 * 添加菜单链接
	 * 
	 * @param id
	 *            角色标识
	 * @param href
	 *            菜单链接
	 */
	public void add(Long id, String href);

	/**
	 * 删除菜单链接
	 * 
	 * @param id
	 *            角色标识
	 * @param href
	 *            菜单链接
	 */
	public void remove(Long id, String href);

	/**
	 * 存在菜单链接
	 * 
	 * @param id
	 *            角色标识
	 * @param href
	 *            菜单链接
	 * @return 是否存在
	 */
	public Boolean exist(Long id, String href);

	/**
	 * 获取列表大小
	 * 
	 * @param id
	 *            角色标识
	 * @return 列表大小
	 */
	public Long size(Long id);

	/**
	 * 最后菜单链接
	 * 
	 * @param id
	 *            角色标识
	 * @return 菜单链接
	 */
	public String last(Long id);

	/**
	 * 清除列表内容
	 * 
	 * @param id
	 *            角色标识
	 */
	public void clear(Long id);

	/**
	 * 获取菜单链接
	 * 
	 * @param id
	 *            角色标识
	 * @param startIndex
	 *            开始序号
	 * @param endIndex
	 *            结束序号
	 * @return 菜单链接列表
	 */
	public List<String> range(Long id, Long startIndex, Long endIndex);

}
