package com.xiehui.api.desktop.service.permission;

import java.util.*;

import javax.annotation.*;

import org.springframework.stereotype.*;

import com.xiehui.api.common.exception.APIException;
import com.xiehui.api.permission.service.menu.MenuService;
import com.xiehui.api.permission.service.menu.MyMenu;
import com.xiehui.api.permission.service.right.MyViewRight;
import com.xiehui.api.permission.service.right.RightService;
import com.xiehui.api.permission.service.role.RoleService;
import com.xiehui.api.permission.service.user.MyUser;
import com.xiehui.api.permission.service.user.UserService;

/**
 * 权限服务实现类
 * 
 * @author xiehui
 * 
 */
@Service("permissionService")
public class PermissionServiceImpl implements PermissionService {

	/** 服务相关 */
	/** 用户服务 */
	@Resource(name = "userService")
	private UserService userService = null;
	/** 角色服务 */
	@Resource(name = "roleService")
	private RoleService roleService = null;
	/** 菜单服务 */
	@Resource(name = "menuService")
	private MenuService menuService = null;
	/** 权限服务 */
	@Resource(name = "rightService")
	private RightService rightService = null;

	/**
	 * 获取我的标识
	 * 
	 * @param token
	 *            登录令牌
	 * @return 我的标识
	 * @throws APIException
	 *             API异常
	 */
	@Override
	public Long getMyId(String token) throws APIException {
		// 调用接口
		return userService.getMyId(token);
	}

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
	@Override
	public String login(String email, String password) throws APIException {
		// 调用接口
		return userService.login(email, password);
	}

	/**
	 * 登出
	 * 
	 * @param myId
	 *            我的标识
	 * @throws APIException
	 *             API异常
	 */
	@Override
	public void logout(Long myId) throws APIException {
		// 调用接口
		userService.logout(myId);
	}

	/**
	 * 获取我的用户
	 * 
	 * @param myId
	 *            我的标识
	 * @return 我的用户
	 * @throws APIException
	 *             API异常
	 */
	@Override
	public MyUser getMyUser(Long myId) throws APIException {
		// 调用接口
		return userService.getMyUser(myId);
	}

	/**
	 * 查询我的菜单
	 * 
	 * @param myId
	 *            我的标识
	 * @return 我的菜单列表
	 * @throws APIException
	 *             API异常
	 */
	@Override
	public List<MyMenu> queryMyMenu(Long myId) throws APIException {
		// 调用接口
		return menuService.queryMyMenu(myId);
	}

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
	@Override
	public List<MyViewRight> queryMyViewRight(Long myId, String view) throws APIException {
		// 调用接口
		return rightService.queryMyViewRight(myId, view);
	}

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
	@Override
	public Boolean checkMyMenu(Long myId, String href) throws APIException {
		// 调用接口
		return menuService.checkMyMenu(myId, href);
	}

	/**
	 * 查询我的权限
	 * 
	 * @param myId
	 *            我的标识
	 * @param href
	 *            权限链接
	 * @return 检查结果
	 * @throws APIException
	 *             API异常
	 */
	@Override
	public Boolean checkMyRight(Long myId, String href) throws APIException {
		// 调用接口
		return rightService.checkMyRight(myId, href);
	}

}
