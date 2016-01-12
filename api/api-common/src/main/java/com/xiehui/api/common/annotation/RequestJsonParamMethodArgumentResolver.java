package com.xiehui.api.common.annotation;

import java.lang.reflect.*;
import java.util.*;

import org.springframework.core.*;
import org.springframework.web.bind.support.*;
import org.springframework.web.context.request.*;
import org.springframework.web.method.support.*;

import com.alibaba.fastjson.*;

/**
 * 请求JSON参数方法参数解析器类
 * 
 * @author xiehui
 *
 */
public class RequestJsonParamMethodArgumentResolver implements HandlerMethodArgumentResolver {

	/**
	 * 是否支持参数
	 * 
	 * @param parameter
	 *            方法参数
	 * @return 是否支持
	 */
	public boolean supportsParameter(MethodParameter parameter) {
		return parameter.hasParameterAnnotation(RequestJsonParam.class);
	}

	/**
	 * 解析参数
	 * 
	 * @param parameter
	 *            方法参数
	 * @param mavContainer
	 *            模型视图容器
	 * @param webRequest
	 *            本地Web请求
	 * @param binderFactory
	 *            绑定器工厂
	 * @return 参数值
	 * @throws Exception
	 *             异常信息
	 */
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		// 获取名称
		String name = parameter.getParameterName();

		System.out.println(JSON.toJSONString(parameter));

		// 解析参数
		Map<String, String[]> parameterMap = webRequest.getParameterMap();
		if (parameterMap != null && parameterMap.containsKey(name)) {
			String[] values = parameterMap.get(name);
			if (values != null && values.length > 0) {
				// 解析列表
				if (List.class.equals(parameter.getParameterType())) {
					Type[] types = parameter.getMethod().getGenericParameterTypes();
					if (types != null && types.length > 0) {
						for (Type type : types) {
							if (type instanceof ParameterizedType) {
								Type[] actualTypes = ((ParameterizedType) type).getActualTypeArguments();
								Type rawType = ((ParameterizedType) type).getRawType();
								if (actualTypes != null && actualTypes.length > 0 && actualTypes[0] instanceof Class<?>
										&& rawType != null && List.class.isAssignableFrom((Class<?>) rawType)) {
									return JSON.parseArray(values[0], (Class<?>) actualTypes[0]);
								}
							}
						}
					}
				}

				// 解析对象
				return JSON.parseObject(values[0], parameter.getParameterType());
			}
		}

		// 返回空值
		return null;
	}
}
