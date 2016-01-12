package com.xiehui.api.permission.service.menu;

import java.util.*;

import javax.annotation.*;

import org.springframework.stereotype.*;

import com.xiehui.api.common.exception.APIException;
import com.xiehui.api.permission.repository.database.DMenu;
import com.xiehui.api.permission.repository.database.DMenuDAO;

/**
 * 菜单服务实现类
 * 
 * @author xiehui
 * 
 */
@Service("menuService")
public class MenuServiceImpl implements MenuService {

	/** 菜单DAO接口 */
	@Resource(name = "dMenuDAO")
	private DMenuDAO dMenuDAO = null;

	/**
	 * 查询我的菜单
	 * 
	 * @param myId
	 *            我的标识
	 * @return 我的菜单列表
	 * @throws APIException
	 *             API异常
	 */
	@Override
	public List<MyMenu> queryMyMenu(Long myId) throws APIException {
		// 初始化
		List<MyMenu> myMenuList = new ArrayList<MyMenu>();
		Map<Long, MyMenu> myMenuMap = new HashMap<Long, MyMenu>();

		// 查询数据
		// 查询数据: 菜单标识
		List<Long> menuIdList = dMenuDAO.queryMenuIdByUserId(myId);
		// 查询数据: 菜单列表
		List<DMenu> dMenuList = dMenuDAO.queryByStatus((short) 1);

		// 整理数据
		Map<Long, DMenu> dMenuMap = new HashMap<Long, DMenu>();
		if (dMenuList != null) {
			for (DMenu dMenu : dMenuList) {
				dMenuMap.put(dMenu.getId(), dMenu);
			}
		}

		// 依次处理
		for (Long menuId : menuIdList) {
			handleMenu(menuId, null, dMenuMap, myMenuMap, myMenuList);
		}

		// 返回数据
		return myMenuList;
	}

	/**
	 * 处理菜单
	 * 
	 * @param menuId
	 *            菜单标识
	 * @param mySubMenu
	 *            我的子菜单
	 * @param dMenuMap
	 *            原始菜单列表
	 * @param myMenuMap
	 *            我的菜单映射
	 * @param myMenuList
	 *            我的菜单列表
	 */
	private void handleMenu(Long menuId, MyMenu mySubMenu, Map<Long, DMenu> dMenuMap, Map<Long, MyMenu> myMenuMap,
			List<MyMenu> myMenuList) {
		// 新的菜单
		if (!myMenuMap.containsKey(menuId)) {
			// 获取菜单
			DMenu dMenu = dMenuMap.get(menuId);
			if (dMenu == null) {
				return;
			}

			// 转化菜单
			MyMenu myMenu = new MyMenu();
			myMenu.setId(dMenu.getId());
			myMenu.setName(dMenu.getName());
			myMenu.setHref(dMenu.getHref());
			myMenu.setDescription(dMenu.getDescription());
			myMenu.setParentId(dMenu.getParentId());
			myMenu.setChildList(null);

			// 添加菜单
			myMenuMap.put(menuId, myMenu);
		}

		// 取出菜单
		MyMenu myMenu = myMenuMap.get(menuId);
		if (myMenu == null) {
			return;
		}

		// 添加子菜单
		if (mySubMenu != null) {
			// 获取子列表
			List<MyMenu> childList = myMenu.getChildList();
			if (childList == null) {
				childList = new ArrayList<MyMenu>();
				myMenu.setChildList(childList);
			}

			// 添加子菜单
			int i = 0;
			int length = childList.size();
			for (; i < length; i++) {
				MyMenu child = childList.get(i);
				int compare = child.getId().compareTo(mySubMenu.getId());
				if (compare > 0) {
					childList.add(i, mySubMenu);
				} else if (compare == 0) {
					break;
				}
			}
			if (!childList.contains(mySubMenu)) {
				if (i == length) {
					childList.add(mySubMenu);
				}
			}
		}

		// 处理根菜单
		// 处理根菜单: 不是根菜单
		if (myMenu.getParentId() != null) {
			handleMenu(myMenu.getParentId(), myMenu, dMenuMap, myMenuMap, myMenuList);
		}
		// 处理根菜单: 已是根菜单
		else {
			// 添加根菜单
			int i = 0;
			int length = myMenuList.size();
			for (; i < length; i++) {
				MyMenu child = myMenuList.get(i);
				int compare = child.getId().compareTo(myMenu.getId());
				if (compare > 0) {
					myMenuList.add(i, myMenu);
				} else if (compare == 0) {
					break;
				}
			}
			if (!myMenuList.contains(myMenu)) {
				if (i == length) {
					myMenuList.add(myMenu);
				}
			}
		}
	}

	/**
	 * 查询我的菜单权限
	 * 
	 * @param myId
	 *            我的标识
	 * @param href
	 *            菜单链接
	 * @return 检查结果
	 * @throws APIException
	 *             API异常
	 */
	@Override
	public Boolean checkMyMenu(Long myId, String href) throws APIException {
		// 初始化
		Boolean result = false;

		Integer count = dMenuDAO.queryByuserIdAndUrl(myId, href);
		if (count > 0) {
			result = true;
		}

		// 返回数据
		return result;
	}

}
