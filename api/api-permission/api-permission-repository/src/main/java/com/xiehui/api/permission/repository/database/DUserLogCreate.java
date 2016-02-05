package com.xiehui.api.permission.repository.database;

import java.sql.*;

/**
 * 用户日志创建类
 * 
 * @author xiehui
 *
 */
public class DUserLogCreate {

	/** 用户标识 */
	private Long userId = null;
	/** 请求地址 */
	private String ip = null;
	/** 请求路径 */
	private String path = null;
	/** 请求参数 */
	private String parameters = null;
	/** 创建时间 */
	private Timestamp createdTime = null;

	/**
	 * 获取用户标识
	 * 
	 * @return 用户标识
	 */
	public Long getUserId() {
		return userId;
	}

	/**
	 * 设置用户标识
	 * 
	 * @param userId
	 *            用户标识
	 */
	public void setUserId(Long userId) {
		this.userId = userId;
	}

	/**
	 * 获取请求地址
	 * 
	 * @return 请求地址
	 */
	public String getIp() {
		return ip;
	}

	/**
	 * 设置请求地址
	 * 
	 * @param ip
	 *            请求地址
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}

	/**
	 * 获取请求路径
	 * 
	 * @return 请求路径
	 */
	public String getPath() {
		return path;
	}

	/**
	 * 设置请求路径
	 * 
	 * @param path
	 *            请求路径
	 */
	public void setPath(String path) {
		this.path = path;
	}

	/**
	 * 获取请求参数
	 * 
	 * @return 请求参数
	 */
	public String getParameters() {
		return parameters;
	}

	/**
	 * 设置请求参数
	 * 
	 * @param parameters
	 *            请求参数
	 */
	public void setParameters(String parameters) {
		this.parameters = parameters;
	}

	/**
	 * 获取创建时间
	 * 
	 * @return 创建时间
	 */
	public Timestamp getCreatedTime() {
		return createdTime;
	}

	/**
	 * 设置创建时间
	 * 
	 * @param createdTime
	 *            创建时间
	 */
	public void setCreatedTime(Timestamp createdTime) {
		this.createdTime = createdTime;
	}

}
