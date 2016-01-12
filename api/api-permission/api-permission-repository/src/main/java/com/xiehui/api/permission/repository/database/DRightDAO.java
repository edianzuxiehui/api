package com.xiehui.api.permission.repository.database;

import java.util.*;

import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.*;

/**
 * 权限DAO接口
 * 
 * @author xiehui
 *
 */
@Repository("dRightDAO")
public interface DRightDAO {

	/**
	 * 获取权限
	 * 
	 * @param id
	 *            权限标识
	 * @return 权限
	 */
	public DRight get(@Param("id") Long id);

	/**
	 * 根据用户标识和视图名称获取权限
	 * 
	 * @param userId
	 *            用户标识
	 * @param name
	 *            视图名称
	 * @return 权限集合
	 */
	public List<DRight> queryByUserIdAndName(@Param("userId") Long userId, @Param("href") String href);

	/**
	 * 根据用户标识和URL判断权限是否存在
	 * 
	 * @param userId
	 *            用户标识
	 * @param href
	 *            URL
	 * @return 存在个数
	 */
	public Integer queryByUserIdAndUrl(@Param("userId") Long userId, @Param("href") String href);

}
