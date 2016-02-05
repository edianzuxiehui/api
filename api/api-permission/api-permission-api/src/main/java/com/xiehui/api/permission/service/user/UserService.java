package com.xiehui.api.permission.service.user;

import com.xiehui.api.common.exception.APIException;

/**
 * 用户服务接口
 * 
 * @author xiehui
 * 
 */
public interface UserService {

	/**
	 * 获取我的标识
	 * 
	 * @param token
	 *            登录令牌
	 * @return 我的标识
	 * @throws APIException
	 *             API异常
	 */
	public Long getMyId(String token) throws APIException;

	/**
	 * 登录
	 * 
	 * @param email
	 *            用户邮箱
	 * @param password
	 *            用户密码
	 * @return 登录令牌
	 * @throws APIException
	 *             API异常
	 */
	public String login(String email, String password) throws APIException;

	/**
	 * 登出
	 * 
	 * @param myId
	 *            我的标识
	 * @throws APIException
	 *             API异常
	 */
	public void logout(Long myId) throws APIException;

	/**
	 * 获取我的用户
	 * 
	 * @param myId
	 *            我的标识
	 * @return 我的用户
	 * @throws APIException
	 *             API异常
	 */
	public MyUser getMyUser(Long myId) throws APIException;

	/**
	 * 修改我的密码
	 * 
	 * @param myId
	 *            我的标识
	 * @param oldPassword
	 *            原始密码
	 * @param newPassword
	 *            新的密码
	 * @throws APIException
	 *             API异常
	 */
	public void modifyMyPassword(Long myId, String oldPassword, String newPassword) throws APIException;

}
