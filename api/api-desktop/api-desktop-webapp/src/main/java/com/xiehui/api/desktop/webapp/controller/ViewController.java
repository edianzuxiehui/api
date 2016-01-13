package com.xiehui.api.desktop.webapp.controller;

import javax.annotation.*;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import com.xiehui.api.desktop.service.permission.PermissionService;

/**
 * 视图控制器类
 * 
 * @author xiehui
 *
 */
@Controller
@RequestMapping("")
@SessionAttributes("myId")
public class ViewController {

	/** 服务相关 */
	/** 权限服务 */
	@Resource(name = "permissionService")
	private PermissionService permissionService = null;

	/** 索引视图 */
	private static final String INDEX = "index";

	/** 错误视图 */
	private static final String ERROR = "error";

	/**
	 * 进入索引视图
	 * 
	 * @param myId
	 *            我的标识
	 * @return 模型视图
	 */
	@RequestMapping(value = "/index", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView enterIndexView(@ModelAttribute("myId") Long myId) {
		// 初始化
		ModelAndView mv = new ModelAndView();

		// 处理逻辑
		try {

			// 设置模型
			// 设置模型: 获取我的用户
			mv.addObject("user", permissionService.getMyUser(myId));
			// 设置模型: 查询我的菜单
			mv.addObject("menuList", permissionService.queryMyMenu(myId));

			// 设置视图
			mv.setViewName(INDEX);
		} catch (Exception e) {
			// 错误视图
			mv.addObject("message", e.getMessage());
			mv.setViewName(ERROR);
		}

		// 返回应答
		return mv;
	}

}
