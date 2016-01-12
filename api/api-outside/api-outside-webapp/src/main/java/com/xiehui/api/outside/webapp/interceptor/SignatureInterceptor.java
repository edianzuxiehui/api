package com.xiehui.api.outside.webapp.interceptor;

import java.util.*;

import javax.servlet.http.*;

import org.springframework.web.servlet.handler.*;

import com.xiehui.api.common.exception.APIException;
import com.xiehui.api.common.exception.ExceptionCode;
import com.xiehui.api.common.util.EncryptHelper;

/**
 * JSON鉴权拦截器类
 * 
 * @author xiehui
 *
 */
public class SignatureInterceptor extends HandlerInterceptorAdapter {

	/** 常量相关 */
	/** 干扰编码 */
	private static final String NOISE = "EqYKiaWy6qBRvX0EUoUXC6O3xEeRhz";
	/** 版本名称 */
	private static final String VERSION = "appVersion";
	/** 签名名称 */
	private static final String SIGNATURE = "sign";

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
		// 获取客户
		String version = request.getParameter(VERSION);
		String signature = request.getParameter(SIGNATURE);
		if (signature == null) {
			throw new APIException(ExceptionCode.SIGNATURE_ERROR, "签名不存在");
		}
		String $signature = genSignature(request, version);
		if (!signature.equalsIgnoreCase($signature)) {
			throw new APIException(ExceptionCode.SIGNATURE_ERROR, "签名错误");
		}

		// 回调函数
		return super.preHandle(request, response, handler);
	}

	/**
	 * 生成签名
	 * 
	 * @param request
	 *            HTTP请求
	 * @param version
	 *            软件版本
	 * @return 签名
	 */
	private String genSignature(HttpServletRequest request, String version) {
		// 初始化
		StringBuilder sb = new StringBuilder();
		List<String> nameList = new ArrayList<String>();

		// 排序名称
		@SuppressWarnings("unchecked")
		Enumeration<String> nameEnum = request.getParameterNames();
		while (nameEnum.hasMoreElements()) {
			nameList.add(nameEnum.nextElement());
		}
		Collections.sort(nameList);

		// 组装数据
		for (String name : nameList) {
			if (!SIGNATURE.equals(name)) {
				sb.append(name);
				sb.append(request.getParameter(name));
			}
		}
		sb.append(NOISE);

		// 计算返回
		return EncryptHelper.toMD5(sb.toString());
	}

}
