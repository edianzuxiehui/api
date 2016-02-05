package com.xiehui.api.permission.service.right;

import java.util.*;

import javax.annotation.*;

import org.springframework.stereotype.*;

import com.xiehui.api.common.exception.APIException;
import com.xiehui.api.permission.repository.database.DRight;
import com.xiehui.api.permission.repository.database.DRightDAO;

/**
 * 权限服务实现类
 * 
 * @author xiehui
 * 
 */
@Service("rightService")
public class RightServiceImpl implements RightService {

	/** DAO相关 */
	/** 权限DAO */
	@Resource(name = "dRightDAO")
	private DRightDAO dRightDAO = null;

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
	@Override
	public List<MyViewRight> queryMyViewRight(Long myId, String view) throws APIException {
		// 初始化
		List<MyViewRight> myViewRightList = new ArrayList<MyViewRight>();

		// 根据用户标识和视图名称获取权限
		List<DRight> dRights = dRightDAO.queryByUserIdAndName(myId, view);

		// 数据转换
		if (dRights != null && dRights.size() > 0) {
			for (DRight dRight : dRights) {
				// 初始化
				MyViewRight myViewRight = new MyViewRight();

				// 数据赋值
				myViewRight.setId(dRight.getId());
				myViewRight.setName(dRight.getName());
				myViewRight.setHref(dRight.getHref());

				// 添加数据
				myViewRightList.add(myViewRight);
			}
		}
		// 返回数据
		return myViewRightList;
	}

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
	@Override
	public Boolean checkMyRight(Long myId, String href) throws APIException {
		// 初始化
		Boolean result = false;

		Integer count = dRightDAO.queryByUserIdAndUrl(myId, href);
		if (count > 0) {
			result = true;
		}

		// 返回数据
		return result;
	}

}
