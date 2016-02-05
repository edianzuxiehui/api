package com.xiehui.api.permission.repository.redis;

/**
 * 角色对象接口
 * 
 * @author xiehui
 *
 */
public interface RRoleObject {

	/**
	 * 设置角色对象
	 * 
	 * @param id
	 *            角色标识
	 * @param role
	 *            角色对象
	 */
	public void set(Long id, RRole role);

	/**
	 * 获取角色对象
	 * 
	 * @param id
	 *            角色标识
	 * @return 角色对象
	 */
	public RRole get(Long id);

	/**
	 * 删除角色对象
	 * 
	 * @param id
	 *            角色标识
	 */
	public void remove(Long id);

	/**
	 * 存在角色对象
	 * 
	 * @param id
	 *            角色标识
	 * @return 是否存在
	 */
	public boolean exist(Long id);

	/**
	 * 设置参数值
	 * 
	 * @param id
	 *            角色标识
	 * @param name
	 *            参数名称
	 * @param value
	 *            参数值
	 */
	public void set(Long id, String name, String value);

	/**
	 * 获取参数值
	 * 
	 * @param id
	 *            角色标识
	 * @param name
	 *            参数名称
	 * @return 参数值
	 */
	public String get(Long id, String name);

	/**
	 * 删除参数值
	 * 
	 * @param id
	 *            角色标识
	 * @param name
	 *            参数名称
	 */
	public void remove(Long id, String name);

	/**
	 * 存在参数值
	 * 
	 * @param id
	 *            角色标识
	 * @param name
	 *            参数名称
	 * @return 持久化异常
	 */
	public boolean exist(Long id, String name);

}
