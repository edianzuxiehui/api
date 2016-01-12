package com.xiehui.api.common.exception;

/**
 * API异常类
 * 
 * @author xiehui
 *
 */
public class APIException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7441685590331517114L;
	/** 异常编码 */
	private ExceptionCode code = ExceptionCode.UNKNOWN_ERROR;

	/**
	 * 构造函数
	 */
	public APIException() {
		super();
	}

	/**
	 * 构造函数
	 * 
	 * @param code
	 *            异常编码
	 */
	public APIException(ExceptionCode code) {
		super();
		this.code = code;
	}

	/**
	 * 构造函数
	 * 
	 * @param message
	 *            异常消息
	 */
	public APIException(String message) {
		super(message);
	}

	/**
	 * 构造函数
	 * 
	 * @param code
	 *            异常编码
	 * @param message
	 *            异常消息
	 */
	public APIException(ExceptionCode code, String message) {
		super(message);
		this.code = code;
	}

	/**
	 * 构造函数
	 * 
	 * @param cause
	 *            异常原因
	 */
	public APIException(Throwable cause) {
		super(cause);
	}

	/**
	 * 构造函数
	 * 
	 * @param code
	 *            异常编码
	 * @param cause
	 *            异常原因
	 */
	public APIException(ExceptionCode code, Throwable cause) {
		super(cause);
		this.code = code;
	}

	/**
	 * 构造函数
	 * 
	 * @param message
	 *            异常消息
	 * @param cause
	 *            异常原因
	 */
	public APIException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * 构造函数
	 * 
	 * @param code
	 *            异常编码
	 * @param message
	 *            异常消息
	 * @param cause
	 *            异常原因
	 */
	public APIException(ExceptionCode code, String message, Throwable cause) {
		super(message, cause);
		this.code = code;
	}

	/**
	 * 获取异常编码
	 * 
	 * @return 异常编码
	 */
	public ExceptionCode getCode() {
		return code;
	}

}
