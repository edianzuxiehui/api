package com.xiehui.api.desktop.webapp.controller;

import javax.annotation.*;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.xiehui.api.common.exception.APIException;
import com.xiehui.api.common.response.APIResponse;
import com.xiehui.api.desktop.service.permission.PermissionService;
import com.xiehui.api.desktop.webapp.validator.ParameterValidator;

/**
 * 权限控制器类
 * 
 * @author xiehui
 *
 */
@Controller
@RequestMapping("/permission")
@SessionAttributes("myId")
public class PermissionController {

	/** 权限服务 */
	@Resource(name = "permissionService")
	private PermissionService permissionService = null;

	/**
	 * 登录
	 * 
	 * @param email
	 *            用户邮箱
	 * @param password
	 *            用户密码
	 * @param secret
	 *            用户密钥
	 * @return API应答
	 * @throws APIException
	 *             API异常
	 */
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public APIResponse login(@RequestParam(value = "email", required = false) String email,
			@RequestParam(value = "password", required = false) String password) throws APIException {
		// 初始化
		APIResponse $response = new APIResponse();

		// 验证参数
		// 验证参数: 用户邮箱
		ParameterValidator.notNull(email, "用户邮箱");
		ParameterValidator.stringLengthLimit(email, "用户邮箱", 50);
		// 验证参数: 用户密码
		ParameterValidator.notNull(password, "用户密码");
		ParameterValidator.stringLengthLimit(password, "用户密码", 32);

		// 调用接口
		$response.setData(permissionService.login(email, password));

		// 返回应答
		return $response;
	}

	/**
	 * 登出
	 * 
	 * @param myId
	 *            我的标识
	 * @return API应答
	 * @throws APIException
	 *             API异常
	 */
	@ResponseBody
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public APIResponse logout(@ModelAttribute("myId") Long myId) throws APIException {
		// 初始化
		APIResponse $response = new APIResponse();

		// 调用接口
		permissionService.logout(myId);

		// 返回应答
		return $response;
	}

	/**
	 * 获取我的用户
	 * 
	 * @param myId
	 *            我的标识
	 * @return API应答
	 * @throws APIException
	 *             API异常
	 */
	@ResponseBody
	@RequestMapping(value = "/getMyUser", method = { RequestMethod.GET, RequestMethod.POST })
	public APIResponse getMyUser(@ModelAttribute("myId") Long myId) throws APIException {
		// 初始化
		APIResponse $response = new APIResponse();

		// 调用接口
		$response.setData(permissionService.getMyUser(myId));

		// 返回应答
		return $response;
	}

	/**
	 * 查询我的菜单
	 * 
	 * @param myId
	 *            我的标识
	 * @return API应答
	 * @throws APIException
	 *             API异常
	 */
	@ResponseBody
	@RequestMapping(value = "/queryMyMenu", method = { RequestMethod.GET, RequestMethod.POST })
	public APIResponse queryMyMenu(@ModelAttribute("myId") Long myId) throws APIException {
		// 初始化
		APIResponse $response = new APIResponse();

		// 调用接口
		$response.setData(permissionService.queryMyMenu(myId));

		// 返回应答
		return $response;
	}

	/**
	 * 查询我的视图权限
	 * 
	 * @param myId
	 *            我的标识
	 * @param view
	 *            视图名称
	 * @return API应答
	 * @throws APIException
	 *             API异常
	 */
	@ResponseBody
	@RequestMapping(value = "/queryMyViewRight", method = { RequestMethod.GET, RequestMethod.POST })
	public APIResponse queryMyViewRight(@ModelAttribute("myId") Long myId,
			@RequestParam(value = "view", required = false) String view) throws APIException {
		// 初始化
		APIResponse $response = new APIResponse();

		// 验证参数
		// 验证参数: 视图名称
		ParameterValidator.notNull(view, "视图名称");

		// 调用接口
		$response.setData(permissionService.queryMyViewRight(myId, view));

		// 返回应答
		return $response;
	}

	/**
	 * 查询我的菜单
	 * 
	 * @param myId
	 *            我的标识
	 * @param href
	 *            菜单链接
	 * @return API应答
	 * @throws APIException
	 *             API异常
	 */
	@ResponseBody
	@RequestMapping(value = "/checkMyMenu", method = { RequestMethod.GET, RequestMethod.POST })
	public APIResponse checkMyMenu(@RequestParam(value = "myId", required = false) Long myId,
			@RequestParam(value = "href", required = false) String href) throws APIException {
		// 初始化
		APIResponse $response = new APIResponse();

		// 验证参数
		// 验证参数: 我的标识
		ParameterValidator.notNull(myId, "我的标识");
		// 验证参数: 菜单链接
		ParameterValidator.notNull(href, "菜单链接");

		// 调用接口
		$response.setData(permissionService.checkMyMenu(myId, href));

		// 返回应答
		return $response;
	}

	/**
	 * 查询我的权限
	 * 
	 * @param myId
	 *            我的标识
	 * @param href
	 *            权限链接
	 * @return API应答
	 * @throws APIException
	 *             API异常
	 */
	@ResponseBody
	@RequestMapping(value = "/checkMyRight", method = { RequestMethod.GET, RequestMethod.POST })
	public APIResponse checkMyRight(@RequestParam(value = "myId", required = false) Long myId,
			@RequestParam(value = "href", required = false) String href) throws APIException {
		// 初始化
		APIResponse $response = new APIResponse();

		// 验证参数
		// 验证参数: 我的标识
		ParameterValidator.notNull(myId, "我的标识");
		// 验证参数: 权限链接
		ParameterValidator.notNull(href, "权限链接");

		// 调用接口
		$response.setData(permissionService.checkMyRight(myId, href));

		// 返回应答
		return $response;
	}

}
