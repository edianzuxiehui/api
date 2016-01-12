package com.xiehui.api.desktop.service.permission;

import java.util.*;

import com.xiehui.api.common.exception.APIException;
import com.xiehui.api.permission.service.menu.MyMenu;
import com.xiehui.api.permission.service.right.MyViewRight;
import com.xiehui.api.permission.service.user.MyUser;

/**
 * 权限服务接口
 * 
 * @author xiehui
 * 
 */
public interface PermissionService {

	/**
	 * 获取我的标识
	 * 
	 * @param token
	 *            登录令牌
	 * @return 我的标识
	 * @throws APIException
	 *             API异常
	 */
	public Long getMyId(String token) throws APIException;

	/**
	 * 登录
	 * 
	 * @param email
	 *            用户邮箱
	 * @param password
	 *            用户密码
	 * @return 登录令牌
	 * @throws APIException
	 *             API异常
	 */
	public String login(String email, String password) throws APIException;

	/**
	 * 登出
	 * 
	 * @param myId
	 *            我的标识
	 * @throws ECMException
	 *             ECM异常
	 */
	public void logout(Long myId) throws APIException;

	/**
	 * 获取我的用户
	 * 
	 * @param myId
	 *            我的标识
	 * @return 我的用户
	 * @throws APIException
	 *             API异常
	 */
	public MyUser getMyUser(Long myId) throws APIException;

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
	 * 查询我的视图权限
	 * 
	 * @param myId
	 *            我的标识
	 * @param view
	 *            视图名称
	 * @return 我的视图权限列表
	 * @throws APIException
	 *             API异常
	 */
	public List<MyViewRight> queryMyViewRight(Long myId, String view) throws APIException;

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

	/**
	 * 查询我的权限
	 * 
	 * @param myId
	 *            我的标识
	 * @param href
	 *            权限链接
	 * @return 检查结果
	 * @throws API异常
	 */
	public Boolean checkMyRight(Long myId, String href) throws APIException;

}
