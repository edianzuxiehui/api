package com.xiehui.api.permission.repository.redis;

/**
 * 用户对象接口
 * 
 * @author cychen
 *
 */
public interface RUserObject {

	/**
	 * 设置用户对象
	 * 
	 * @param id
	 *            用户标识
	 * @param user
	 *            用户对象
	 */
	public void set(Long id, RUser user);

	/**
	 * 获取用户对象
	 * 
	 * @param id
	 *            用户标识
	 * @return 用户对象
	 */
	public RUser get(Long id);

	/**
	 * 删除用户对象
	 * 
	 * @param id
	 *            用户标识
	 */
	public void remove(Long id);

	/**
	 * 存在用户对象
	 * 
	 * @param id
	 *            用户标识
	 * @return 是否存在
	 */
	public boolean exist(Long id);

	/**
	 * 设置参数值
	 * 
	 * @param id
	 *            用户标识
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
	 *            用户标识
	 * @param name
	 *            参数名称
	 * @return 参数值
	 */
	public String get(Long id, String name);

	/**
	 * 删除参数值
	 * 
	 * @param id
	 *            用户标识
	 * @param name
	 *            参数名称
	 */
	public void remove(Long id, String name);

	/**
	 * 存在参数值
	 * 
	 * @param id
	 *            用户标识
	 * @param name
	 *            参数名称
	 * @return 持久化异常
	 */
	public boolean exist(Long id, String name);

}
