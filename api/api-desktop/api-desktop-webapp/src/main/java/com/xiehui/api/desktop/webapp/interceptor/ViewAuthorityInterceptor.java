package com.xiehui.api.desktop.webapp.interceptor;

import javax.annotation.*;
import javax.servlet.http.*;

import org.springframework.web.servlet.handler.*;

import com.xiehui.api.desktop.service.permission.PermissionService;

/**
 * 视图鉴权拦截器类
 * 
 * @author xiehui
 *
 */
public class ViewAuthorityInterceptor extends HandlerInterceptorAdapter {

	/** 服务相关 */
	/** 权限服务 */
	@Resource(name = "permissionService")
	private PermissionService permissionService = null;

	/** 常量相关 */
	/** 我的标识 */
	private static final String MYID = "myId";
	/** 登录令牌 */
	private static final String TOKEN = "token";
	/** 跳转视图 */
	private static final String REDIRECT = "redirect";

	/**
	 * 设置权限服务
	 * 
	 * @param permissionService
	 *            权限服务
	 */
	public void setPermissionService(PermissionService permissionService) {
		this.permissionService = permissionService;
	}

	/**
	 * 处理前调用
	 * 
	 * @param request
	 *            HTTP请求
	 * @param response
	 *            HTTP应答
	 * @param handler
	 *            处理器
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 获取令牌
		String token = request.getParameter(TOKEN);
		if (token == null) {
			response.sendRedirect(REDIRECT);
			return false;
		}

		// 获取标识
		Long myId = permissionService.getMyId(token);
		if (myId == null) {
			response.sendRedirect(REDIRECT);
			return false;
		}

		// 设置标识
		request.getSession().setAttribute(MYID, myId);

		// 回调函数
		return super.preHandle(request, response, handler);
	}

}
