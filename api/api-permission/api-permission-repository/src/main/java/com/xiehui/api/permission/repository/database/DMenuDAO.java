package com.xiehui.api.permission.repository.database;

import java.util.*;

import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.*;

/**
 * 菜单DAO接口
 * 
 * @author xiehui
 *
 */
@Repository("dMenuDAO")
public interface DMenuDAO {

	/**
	 * 获取菜单
	 * 
	 * @param id
	 *            菜单标识
	 * @return 菜单
	 */
	public DMenu get(@Param("id") Long id);

	/**
	 * 根据用户标识获取菜单
	 * 
	 * @param id
	 *            用户标识
	 * @return 菜单列表
	 */
	public List<DMenu> queryByuserId(@Param("id") Long id);

	/**
	 * 根据用户标识获取菜单
	 * 
	 * @param id
	 *            用户标识
	 * @return 菜单列表
	 */
	public List<Long> queryMenuIdByUserId(@Param("id") Long id);

	/**
	 * 根据用户标识获取菜单
	 * 
	 * @param id
	 *            用户标识
	 * @return 菜单列表
	 */
	public List<DMenu> queryByStatus(@Param("status") Short status);

	/**
	 * 获取菜单权限是否存在
	 * 
	 * @param id
	 *            我的标示
	 * @param href
	 *            权限url
	 * @return 返回存在个数
	 */
	public Integer queryByuserIdAndUrl(@Param("id") Long id, @Param("href") String href);

}
