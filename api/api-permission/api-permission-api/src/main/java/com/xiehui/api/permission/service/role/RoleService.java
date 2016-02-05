package com.xiehui.api.permission.service.role;

import java.util.*;

import com.xiehui.api.common.exception.APIException;

/**
 * 角色服务接口
 * 
 * @author xiehui
 * 
 */
public interface RoleService {

	/**
	 * 查询角色
	 * 
	 * @param myId
	 *            我的标识
	 * @param roleId
	 *            角色标识
	 * @return 角色列表
	 * @throws APIException
	 *             API异常
	 */
	public List<Role> queryRole(Long myId, Long roleId) throws APIException;

}
