package com.xiehui.api.desktop.webapp.interceptor;

import javax.annotation.*;
import javax.servlet.http.*;

import org.springframework.web.servlet.handler.*;

import com.xiehui.api.common.exception.APIException;
import com.xiehui.api.common.exception.ExceptionCode;
import com.xiehui.api.desktop.service.permission.PermissionService;

/**
 * JSON鉴权拦截器类
 * 
 * @author xiehui
 *
 */
public class JsonAuthorityInterceptor extends HandlerInterceptorAdapter {

	/** 服务相关 */
	/** 权限服务 */
	@Resource(name = "permissionService")
	private PermissionService permissionService = null;

	/** 常量相关 */
	/** 我的标识 */
	private static final String MYID = "myId";
	/** 登录令牌 */
	private static final String TOKEN = "token";

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
			throw new APIException(ExceptionCode.TOKEN_INVALID, "令牌不存在");
		}

		// 获取标识
		Long myId = permissionService.getMyId(token);
		if (myId == null) {
			throw new APIException(ExceptionCode.TOKEN_INVALID, "令牌已失效");
		}

		// 设置标识
		request.getSession().setAttribute(MYID, myId);

		// 回调函数
		return super.preHandle(request, response, handler);
	}

}
