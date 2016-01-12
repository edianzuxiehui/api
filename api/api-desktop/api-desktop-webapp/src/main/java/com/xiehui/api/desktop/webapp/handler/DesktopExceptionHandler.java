package com.xiehui.api.desktop.webapp.handler;

import org.springframework.web.bind.annotation.*;

import com.xiehui.api.common.exception.APIException;
import com.xiehui.api.common.exception.ExceptionCode;
import com.xiehui.api.common.response.APIResponse;

/**
 * 桌面异常拦截器类
 * 
 * @author cychen
 *
 */
@ControllerAdvice
public class DesktopExceptionHandler {

	/**
	 * 处理未期望的服务异常
	 * 
	 * @param throwable
	 *            抛出异常
	 * @return 接口应答
	 */
	@ResponseBody
	@ExceptionHandler(Throwable.class)
	public APIResponse handleUnexpectedServerError(Throwable throwable) {
		throwable.printStackTrace();
		// 处理异常
		APIResponse response = new APIResponse();
		if (throwable instanceof APIException) {
			APIException exception = (APIException) throwable;
			response.setCode(exception.getCode().getValue());
			response.setMessage(exception.getMessage());
		} else {
			response.setCode(ExceptionCode.UNKNOWN_ERROR.getValue());
			response.setMessage(throwable.getMessage());
		}

		// 默认消息
		if (response.getMessage() == null) {
			response.setMessage(ExceptionCode.UNKNOWN_ERROR.getDescription());
		}

		// 返回数据
		return response;
	}

}
