package com.xiehui.api.desktop.webapp.validator;

import java.text.*;

import com.xiehui.api.common.exception.APIException;

/**
 * 参数验证器类
 * 
 * @author xiehui
 *
 */
public class ParameterValidator {

	/**
	 * 不能为空
	 * 
	 * @param value
	 *            参数取值
	 * @param description
	 *            参数描述
	 * @throws APIException
	 *             API异常
	 */
	public static void notNull(Object value, String description) throws APIException {
		if (value == null || "".equals(value)) {
			throw new APIException(MessageFormat.format("{0}不能为空", description));
		}
	}

	/**
	 * 字符串限制长度
	 * 
	 * @param value
	 *            参数取值
	 * @param description
	 *            参数描述
	 * @param limit
	 *            限制长度
	 * @throws APIException
	 *             API异常
	 */
	public static void stringLengthLimit(String value, String description, int limit) throws APIException {
		if (value != null && value.getBytes().length > limit) {
			throw new APIException(MessageFormat.format("{0}超过长度限制{1}", description, limit));
		}
	}

	/**
	 * 手机号码格式
	 * 
	 * @param value
	 *            参数取值
	 * @param description
	 *            参数描述
	 * @throws APIException
	 *             API异常
	 */
	public static void phoneFormat(String value, String description) throws APIException {
		if (value != null && !value.matches("1\\d{10}")) {
			throw new APIException("请输入正确的手机号码");
		}
	}

	/**
	 * 时间戳格式
	 * 
	 * @param value
	 *            参数取值
	 * @param description
	 *            参数描述
	 * @throws APIException
	 *             API异常
	 */
	public static void timestampFormat(String value, String description) throws APIException {
		if (value != null && !value.matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}")) {
			throw new APIException(MessageFormat.format("{0}不是有效的时间戳格式", description));
		}
	}

	/**
	 * 时间格式
	 * 
	 * @param value
	 *            参数取值
	 * @param description
	 *            参数描述
	 * @throws APIException
	 *             API异常
	 */
	public static void timeFormat(String value, String description) throws APIException {
		if (value != null && !value.matches("\\d{2}:\\d{2}:\\d{2}")) {
			throw new APIException(MessageFormat.format("{0}不是有效的时间格式", description));
		}
	}

	/**
	 * 身份证格式
	 * 
	 * @param value
	 *            参数取值
	 * @param description
	 *            参数描述
	 * @throws APIException
	 *             API异常
	 */
	public static void idCardFormat(String value, String description) throws APIException {
		if (value != null && !value.matches(
				"((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})"
						+ "(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}"
						+ "[Xx0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))")) {
			throw new APIException(MessageFormat.format("{0}不是有效的身份证格式", description));
		}
	}

}
