/**
 * 准备函数
 */
var hrefArray = {};
var isDefault = true;
var defaultObj = new Object();
$(document).ready(function() {
	// 设置 cookie
	// var $username = $("#username").val();
	// setCookie('username', $username);
	// 获取 cookie
	// $username=getCookie("username");
	
	// 加载菜单树
	$("#menutree").tree({
		data : queryMenuTree(),
		onClick : function(node) {
			// 判断是否是叶子节点
			if ($('#menutree').tree('isLeaf', node.target)) {
				var title = node.text;
				var href = hrefArray[node.id];
				showView(title, href);
			}
		}
	});

	// 默认加载tab
	showView(defaultObj.title,defaultObj.href);
	
	// 绑定函数
	$('.wu-side-tree a').bind("click", function() {
		var title = $(this).text();
		var url = $(this).attr('data-link');
		var iconCls = $(this).attr('data-icon');
		var iframe = $(this).attr('iframe') == 1 ? true : false;
		addTab(title, url, iconCls, iframe);
	});
})

/**
 * 父菜单树
 * 
 */
function getRootArray(list, treeArray) {
	for ( var i in list) {
		var menu = new Object();
		// 判断当前节点是否还有子节点
		menu.id = list[i].id;
		menu.text = list[i].name;
		menu.iconCls = 'icon-application-view-tile';
		hrefArray[menu.id] = list[i].href;
		var childlist = list[i].childList;
		if (childlist != null && childlist.length > 0) {
			menu.children = getChildArray(list[i].id, childlist);
		}
		treeArray.push(menu);
	}
}

/**
 * 子菜单树
 * 
 */
function getChildArray(parentId, list) {
	var childArray = new Array();
	for ( var i in list) {
		var subMenu = new Object();
		subMenu.id = list[i].id;
		subMenu.text = list[i].name;
		subMenu.iconCls = 'icon-play-green';
		hrefArray[subMenu.id] = list[i].href;
		var childlist = list[i].childList;
		if (childlist != null && childlist.length > 0) {
			subMenu.children = getChildArray(list[i].id, childlist);
		}else{
			if(isDefault){
				defaultObj.title = list[i].name;
				defaultObj.href = list[i].href;
				isDefault=false;
			}
		}
		childArray.push(subMenu);
	}
	return childArray;
}

/**
 * 查询菜单树
 * 
 */
function queryMenuTree() {
	// 菜单数组
	var treeArray = new Array();

	// 调用接口
	$.ajax({
		type : "POST",
		dataType : "json",
		url : "permission/queryMyMenu",
		cache : false,
		async : false,
		data : null,
		success : function(response) {
			if (response.code == 0) {
				// 菜单对象
				var list = response.data;
				if (list != null && list.length > 0) {
					getRootArray(list, treeArray);
				}
			}
		},
		error : function(err) {
			// 移除屏蔽
			$.messager.alert('操作提示', '获取数据失败!', 'error');
		},
		complete : function() {
		}
	});
	return treeArray;
}

/**
 * 载入树形菜单
 */
// $('#wu-side-tree').tree({
// url : 'temp/menu.php',
// cache : false,
// onClick : function(node) {
// var url = node.attributes['url'];
// if (url == null || url == "") {
// return false;
// }
// else {
// addTab(node.text, url, '', node.attributes['iframe']);
// }
// }
// });
/**
 * 选项卡初始化
 */
$('#wu-tabs').tabs({
	tools : [{
		iconCls : 'icon-reload',
		border : false,
		handler : function() {
			$('#wu-datagrid').datagrid('reload');
		}
	}]
});

/**
 * 添加菜单选项
 * 
 * @param title 名称
 * @param href 链接
 * @param iconCls 图标样式
 * @param iframe 链接跳转方式（true为iframe，false为href）
 */
function addTab(title, href, iconCls, iframe) {
	var tabPanel = $('#wu-tabs');
	if (!tabPanel.tabs('exists', title)) {
		var content = '<iframe scrolling="auto" frameborder="0"  src="' + href
				+ '" style="width:100%;height:99%;"></iframe>';
		if (iframe) {
			tabPanel.tabs('add', {
				title : title,
				content : content,
				// iconCls : iconCls,
				fit : true,
				cls : 'pd3',
				closable : true
			});
		}
		else {
			tabPanel.tabs('add', {
				title : title,
				closable : true,
				href : href,
				// iconCls : iconCls,
				fit : true,
				cls : 'pd3'
			});
		}
	}
	else {
		tabPanel.tabs('select', title);
	}
}

/**
 * 移除菜单选项
 */
function removeTab() {
	var tabPanel = $('#wu-tabs');
	var tab = tabPanel.tabs('getSelected');
	if (tab) {
		var index = tabPanel.tabs('getTabIndex', tab);
		tabPanel.tabs('close', index);

	}
}

/**
 * 用户登出
 */
function logout() {
	// 确认退出
	var result = window.confirm('确定退出系统吗？');
	if (typeof (result) == "undefined" || result == null || result == false) {
		return;
	}

	// 调用接口
	$.ajax({
		type : "POST",
		url : "logout",
		data : null,
		dataType : 'json',
		complete : function() {
			window.location.href = "login";
		}
	});
}

/**
 * 面板伸展
 */
function panelCollapase() {
	$(".easyui-layout").layout('collapse', 'north');
}

/**
 * 指定页面
 */
function showView(title,url) {
	var tabPanel = $('#wu-tabs');
	if (tabPanel.tabs('exists', title)) {
		tabPanel.tabs('select', title);
	}
	else {
		$('#wu-tabs').tabs('add', {
			closable : true,
			title : title,
			href : url
		});
	}
}