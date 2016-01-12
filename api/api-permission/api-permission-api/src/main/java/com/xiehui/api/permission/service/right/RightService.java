package com.xiehui.api.permission.service.right;

import java.util.*;

import com.xiehui.api.common.exception.APIException;

/**
 * 权限服务接口
 * 
 * @author xiehui
 * 
 */
public interface RightService {

	/**
	 * 查询我的视图权限
	 * 
	 * @param myId
	 *            我的标识
	 * @param view
	 *            视图名称
	 * @return 我的视图权限列表
	 * @throws APIException
	 *             API异常
	 */
	public List<MyViewRight> queryMyViewRight(Long myId, String view) throws APIException;

	/**
	 * 查询我的权限
	 * 
	 * @param myId
	 *            我的标识
	 * @param href
	 *            权限链接
	 * @return 检查结果
	 * @throws APIException
	 *             API异常
	 */
	public Boolean checkMyRight(Long myId, String href) throws APIException;

}
