package com.xiehui.api.permission.service.user;

import java.util.concurrent.*;

import javax.annotation.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.xiehui.api.common.exception.APIException;
import com.xiehui.api.common.util.EncryptHelper;
import com.xiehui.api.permission.constant.CUserStatus;
import com.xiehui.api.permission.repository.database.DUser;
import com.xiehui.api.permission.repository.database.DUserDAO;
import com.xiehui.api.permission.repository.redis.RTokenUserValue;
import com.xiehui.api.permission.repository.redis.RUserTokenValue;
import com.xiehui.api.permission.secret.Authenticator;

/**
 * 用户服务实现类
 * 
 * @author xiehui
 * 
 */
@Service("userService")
public class UserServiceImpl implements UserService {

	/** DAO相关 */
	/** 用户DAO */
	@Resource(name = "dUserDAO")
	private DUserDAO dUserDAO = null;

	/** 令牌用户值 */
	@Resource(name = "rTokenUserValue")
	private RTokenUserValue rTokenUserValue = null;
	/** 用户令牌值 */
	@Resource(name = "rUserTokenValue")
	private RUserTokenValue rUserTokenValue = null;

	/** 属性相关 */
	/** 令牌超时时间(毫秒) */
	@Value("${user.token.timeout}")
	private Long tokenTimeout = null;

	/**
	 * 获取我的标识
	 * 
	 * @param token
	 *            登录令牌
	 * @return 我的标识
	 * @throws APIException
	 *             API异常
	 */
	@Override
	public Long getMyId(String token) throws APIException {
		// 初始化
		Long myId = rTokenUserValue.get(token);

		// 重设超时
		if (myId != null) {
			rTokenUserValue.setExpire(token, tokenTimeout, TimeUnit.MILLISECONDS);
		}

		// 返回数据
		return myId;
	}

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
	@Override
	public String login(String email, String password) throws APIException {
		// 检查用户
		DUser dUser = dUserDAO.getByEmail(email);
		if (dUser == null) {
			throw new APIException("用户不存在");
		}
		if (dUser.getStatus().equals(CUserStatus.DISABLE.getValue())) {
			throw new APIException("用户被禁用");
		}
		String secret = dUser.getLoginSecret();
		boolean validatorSecret = Authenticator.check(secret, Integer.parseInt(password));
		if (!validatorSecret) {
			throw new APIException("用户密码错误");
		}
		// 删除令牌
		String token = rUserTokenValue.get(dUser.getId());
		if (token != null) {
			rTokenUserValue.remove(token);
		}
		rUserTokenValue.remove(dUser.getId());

		// 添加令牌
		token = EncryptHelper.toMD5(email + System.currentTimeMillis());
		rTokenUserValue.set(token, dUser.getId(), tokenTimeout, TimeUnit.MILLISECONDS);
		rUserTokenValue.set(dUser.getId(), token);

		// 返回数据
		return token;
	}

	/**
	 * 登出
	 * 
	 * @param myId
	 *            我的标识
	 * @throws APIException
	 *             API异常
	 */
	@Override
	public void logout(Long myId) throws APIException {
		// 删除令牌
		String token = rUserTokenValue.get(myId);
		if (token != null) {
			rTokenUserValue.remove(token);
		}
		rUserTokenValue.remove(myId);
	}

	/**
	 * 获取我的用户
	 * 
	 * @param myId
	 *            我的标识
	 * @return 我的用户
	 * @throws APIException
	 *             API异常
	 */
	@Override
	public MyUser getMyUser(Long myId) throws APIException {
		// 初始化
		MyUser user = new MyUser();

		DUser dUser = dUserDAO.get(myId);
		if (dUser != null) {
			user.setId(dUser.getId());
			user.setName(dUser.getName());
			user.setPhone(dUser.getPhone());
		}

		// 返回数据
		return user;
	}

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
	@Override
	public void modifyMyPassword(Long myId, String oldPassword, String newPassword) throws APIException {
		// TODO: 实现代码
	}

}
