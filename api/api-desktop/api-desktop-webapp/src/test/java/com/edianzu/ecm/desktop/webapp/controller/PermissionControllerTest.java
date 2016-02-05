package com.edianzu.ecm.desktop.webapp.controller;

import javax.annotation.*;

import org.junit.*;
import org.junit.runner.*;
import org.springframework.test.context.*;
import org.springframework.test.context.junit4.*;

import com.alibaba.fastjson.*;
import com.xiehui.api.common.exception.APIException;
import com.xiehui.api.common.response.APIResponse;
import com.xiehui.api.desktop.webapp.controller.PermissionController;

/**
 * 客户控制器测试类
 * 
 * @author cychen
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring-config-test.xml" })
public class PermissionControllerTest {

	/** 权限控制器类 */
	@Resource(name = "permissionController")
	private PermissionController permissionController = null;

	/**
	 * 测试登录函数
	 * 
	 * @throws ECMException
	 *             ECM异常
	 */
	@Test
	public void testLogin() throws APIException {
		// 初始化
		String email = "admin@edianzu.cn";
		String password = "305744";

		// 调用接口
		APIResponse $response = permissionController.login(email, password);

		// 打印结果
		System.out.println("testLogin:");
		System.out.println(JSON.toJSONString($response));
	}

	/**
	 * 测试登出函数
	 * 
	 * @throws ECMException
	 *             ECM异常
	 */
	@Test
	public void testLogout() throws APIException {
		// 初始化
		Long myId = 1l;

		// 调用接口
		APIResponse $response = permissionController.logout(myId);

		// 打印结果
		System.out.println("testLogout:");
		System.out.println(JSON.toJSONString($response));
	}

	/**
	 * 测试获取我的用户函数
	 * 
	 * @throws ECMException
	 *             ECM异常
	 */
	@Test
	public void testGetMyUser() throws APIException {
		// 初始化
		Long myId = 1l;

		// 调用接口
		APIResponse $response = permissionController.getMyUser(myId);

		// 打印结果
		System.out.println("testGetMyUser:");
		System.out.println(JSON.toJSONString($response));
	}

	/**
	 * 测试查询我的菜单函数
	 * 
	 * @throws ECMException
	 *             ECM异常
	 */
	@Test
	public void testQueryMyMenu() throws APIException {
		// 初始化
		Long myId = 1l;

		// 调用接口
		APIResponse $response = permissionController.queryMyMenu(myId);

		// 打印结果
		System.out.println("testQueryMyMenu:");
		System.out.println(JSON.toJSONString($response));
	}

	/**
	 * 测试查询我的视图权限函数
	 * 
	 * @throws ECMException
	 *             ECM异常
	 */
	@Test
	public void testQueryMyViewRight() throws APIException {
		// 初始化
		Long myId = 1l;
		String view = "customer/getPanelData";

		// 调用接口
		APIResponse $response = permissionController.queryMyViewRight(myId, view);

		// 打印结果
		System.out.println("testQueryMyViewRight:");
		System.out.println(JSON.toJSONString($response));
	}

	/**
	 * 测试查询我的菜单函数
	 * 
	 * @throws ECMException
	 *             ECM异常
	 */
	@Test
	public void testCheckMyMenu() throws APIException {
		// 初始化
		Long myId = null;
		String href = null;

		// 调用接口
		APIResponse $response = permissionController.checkMyMenu(myId, href);

		// 打印结果
		System.out.println("testCheckMyMenu:");
		System.out.println(JSON.toJSONString($response));
	}

	/**
	 * 测试查询我的权限函数
	 * 
	 * @throws ECMException
	 *             ECM异常
	 */
	@Test
	public void testCheckMyRight() throws APIException {
		// 初始化
		Long myId = null;
		String href = null;

		// 调用接口
		APIResponse $response = permissionController.checkMyRight(myId, href);

		// 打印结果
		System.out.println("testCheckMyRight:");
		System.out.println(JSON.toJSONString($response));
	}

}
