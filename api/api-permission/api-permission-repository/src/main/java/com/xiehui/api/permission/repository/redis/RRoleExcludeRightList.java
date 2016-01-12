package com.xiehui.api.permission.repository.redis;

import java.util.*;

/**
 * 角色排除权限列表接口
 * 
 * @author xiehui
 *
 */
public interface RRoleExcludeRightList {

	/**
	 * 添加权限链接
	 * 
	 * @param id
	 *            角色标识
	 * @param href
	 *            权限链接
	 */
	public void add(Long id, String href);

	/**
	 * 删除权限链接
	 * 
	 * @param id
	 *            角色标识
	 * @param href
	 *            权限链接
	 */
	public void remove(Long id, String href);

	/**
	 * 存在权限链接
	 * 
	 * @param id
	 *            角色标识
	 * @param href
	 *            权限链接
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
	 * 最后权限链接
	 * 
	 * @param id
	 *            角色标识
	 * @return 权限链接
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
	 * 获取权限链接
	 * 
	 * @param id
	 *            角色标识
	 * @param startIndex
	 *            开始序号
	 * @param endIndex
	 *            结束序号
	 * @return 权限链接列表
	 */
	public List<String> range(Long id, Long startIndex, Long endIndex);

}
