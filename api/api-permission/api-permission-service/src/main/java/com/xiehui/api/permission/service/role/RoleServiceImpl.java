package com.xiehui.api.permission.service.role;

import java.util.*;

import org.springframework.stereotype.*;

import com.xiehui.api.common.exception.APIException;

/**
 * 角色服务实现类
 * 
 * @author xiehui
 * 
 */
@Service("roleService")
public class RoleServiceImpl implements RoleService {

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
	@Override
	public List<Role> queryRole(Long myId, Long roleId) throws APIException {
		// 初始化
		List<Role> roleList = null;

		// TODO: 实现代码

		// 返回数据
		return roleList;
	}

}
