package com.xiehui.api.permission.service.menu;

import java.util.*;

import com.xiehui.api.common.exception.APIException;

/**
 * 菜单服务接口
 * 
 * @author xiehui
 * 
 */
public interface MenuService {

	/**
	 * 查询我的菜单
	 * 
	 * @param myId
	 *            我的标识
	 * @return 我的菜单列表
	 * @throws APIException
	 *             API异常
	 */
	public List<MyMenu> queryMyMenu(Long myId) throws APIException;

	/**
	 * 查询我的菜单
	 * 
	 * @param myId
	 *            我的标识
	 * @param href
	 *            菜单链接
	 * @return 检查结果
	 * @throws APIException
	 *             API异常
	 */
	public Boolean checkMyMenu(Long myId, String href) throws APIException;

}
