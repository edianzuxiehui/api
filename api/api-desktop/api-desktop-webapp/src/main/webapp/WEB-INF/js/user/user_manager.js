/**
 * 定义表格
 */
//var dg = $('#wu-datagrid-user');
/**
 * 准备函数
 */
var data = {};
var usermodifydata = {};
var userRight = new Object();
var Regex = /^(?:\w+\.?)*\w+@(?:\w+\.)*\w+$/;
$(document).ready(function() {
	// 获取权限
	userRight.modify = $("#modifyUserRight").val();
	$("#modifyUserRight").val("");

	// 加载部门树
	var treedata = queryDepartmentTree(null, true);
	$("#departmentCombotree").combotree({
		data : treedata
	});
	$("#cDepartmentCombotree").combotree({
		data : treedata
	});
	$("#mDepartmentCombotree").combotree({
		data : treedata
	});

	// 设置部门树默认值
	setTreeValue();

	// 加载表格
	initUserTable();

	// 绑定函数
	$("#btn_searchUser").bind("click", searchUser);
	$("#btn_showCreateUserDialog").bind("click", showCreateUserDialog);
	$("#btn_createUser").bind("click", createUser);
	$("#btn_createUserCancel").bind("click", createUserCancel);
	$("#btn_modifyUser").bind("click", modifyUser);
	$("#btn_modifyUserCancel").bind("click", modifyUserCancel);

});

/*
 * 设置部门树默认值
 */
function setTreeValue() {
	setTimeout(function() {
		setValue()
	}, 300);
	var setValue = function() {
		$('#departmentCombotree').combotree('setValue', 0);
	}
}

/**
 * 父部门树
 * 
 */
function getRootArray(list, departmentArray) {
	for ( var i in list) {
		var department = new Object();
		// 判断当前节点是否还有子节点
		department.id = list[i].id;
		department.text = list[i].name;
		department.iconCls = 'icon-organization';
		var childlist = list[i].childList;
		if (childlist != null && childlist.length > 0) {
			department.children = getChildArray(list[i].id, childlist);
		}
		departmentArray.push(department);
	}
}

/**
 * 子部门树
 * 
 */
function getChildArray(parentId, list) {
	var childDepartmentArray = new Array();
	for ( var i in list) {
		var childDepartment = new Object();
		childDepartment.id = list[i].id;
		childDepartment.text = list[i].name;
		childDepartment.iconCls = 'icon-folder-user';
		var childlist = list[i].childList;
		if (childlist != null && childlist.length > 0) {
			childDepartment.children = getChildArray(list[i].id, childlist);
		}
		childDepartmentArray.push(childDepartment);
	}

	return childDepartmentArray;
}

/**
 * 查询部门树
 * 
 */
function queryDepartmentTree(departmentId, isCascaded) {
	var treedata = {};
	if (departmentId != null && departmentId != "") {
		treedata['departmentId'] = departmentId;
	}
	treedata['isCascaded'] = isCascaded;

	// 部门数组
	var departmentArray = new Array();

	// 调用接口
	$.ajax({
		type : "POST",
		dataType : "json",
		url : "organization/queryDepartment",
		cache : false,
		async : false,
		data : treedata,
		success : function(response) {
			if (response.code == 0) {
				// 部门对象
				var list = response.data;
				if (list != null && list.length > 0) {
					getRootArray(list, departmentArray);
				}
			}
		},
		error : function(err) {
			// 移除屏蔽
			$.messager.alert('操作提示', '获取数据失败!', 'error');
		},
		complete : function() {
			treedata = {};
		}
	});
	// console.log(departmentArray);
	return departmentArray;
}

/**
 * 加载表格
 */
function initUserTable() {
	// 加载表格
	$('#wu-datagrid-user').datagrid(
			{
				fit : true,
				// fitColumns : true,
				// width : 'auto',
				// height : 'auto',
				nowrap : false, // True 数据将在一行显示
				striped : true, // True 就把行条纹化
				collapsible : false, // True 可折叠
				// sortName : 'id', //定义可以排序的列
				// sortOrder : 'asc', //定义列的排序顺序，只能用 asc或 desc
				// remoteSort : false, //定义是否从服务器给数据排序
				singleSelect : true, // True 只能选择一行
				border : true,
				columns : [[
						{
							field : 'id',
							title : 'ID',
							width : fixWidth(0.05),
							// sortable : true,
							align : "center"
						},
						{
							field : 'departmentName',
							title : '部门',
							width : fixWidth(0.08),
							// sortable : true,
							align : "center"
						},
						{
							field : 'name',
							title : '销售人员',
							width : fixWidth(0.08),
							// sortable : true,
							align : "center"
						},
						{
							field : 'email',
							title : '登录邮箱',
							width : fixWidth(0.12),
							// sortable : true,
							align : "center"
						},
						{
							field : 'roleName',
							title : '角色名称',
							width : fixWidth(0.08),
							// sortable : true,
							align : "center"
						},
						{
							field : 'titleName',
							title : '职称',
							width : fixWidth(0.1),
							// sortable : true,
							align : "center"
						},
						{
							field : 'status',
							title : '用户状态',
							width : fixWidth(0.08),
							// sortable : true,
							align : "center",
							formatter : function(value, rowData, rowIndex) {
								return value == 0 ? "禁用" : "启用";
							}
						},
						{
							field : 'phone',
							title : '手机号码',
							width : fixWidth(0.1),
							// sortable : true,
							align : "center"
						},
						{
							field : 'createTime',
							title : '创建时间',
							width : fixWidth(0.1),
							// sortable : true,
							align : "center"
						},
						{
							field : 'loginTime',
							title : '最后登录',
							width : fixWidth(0.1),
							// sortable : true,
							align : "center"
						},
						{
							field : 'departmentId',
							title : '部门标识',
							width : '0',
							align : "center"
						},
						{
							field : 'titleId',
							title : '职称标识',
							width : '0',
							align : "center"
						},
						{
							field : 'roleId',
							title : '用户标识',
							width : '0',
							align : "center"
						},
						{
							field : 'opt',
							title : '操作',
							width : fixWidth(0.1),
							sortable : false,
							align : 'center',
							formatter : function(value, rowData, rowIndex) {
								// "<a href='javascript:void(0);' title=" +
								// rowData.id + "
								// onclick='queryCallListByUserId(" + rowData.id
								// + ");'>通话记录</a>"
								return "<a href='javascript:void(0);' onclick='showModifyUserDialog(\"" + rowData.id
										+ "\",\"" + rowData.departmentId + "\",\"" + rowData.titleId + "\",\""
										+ rowData.name + "\",\"" + rowData.phone + "\",\"" + rowData.email + "\",\""
										+ rowData.roleId + "\",\"" + rowData.status + "\");'>编辑成员</a>";
							}
						}]],
				// rownumbers : true,
				pagination : true,
				pageNumber : 1,
				pageSize : 20,
				pageList : [10, 20, 30, 50, 100],
				loadMsg : '数据加载中,请稍候......'
			});

	// 隐藏列
	$('#wu-datagrid-user').datagrid('hideColumn', 'departmentId');
	$('#wu-datagrid-user').datagrid('hideColumn', 'titleId');
	// $('#wu-datagrid-user').datagrid('hideColumn', 'positionName');
	// $('#wu-datagrid-user').datagrid('hideColumn', 'positionId');
	$('#wu-datagrid-user').datagrid('hideColumn', 'roleId');
	if (userRight.modify != "1") {
		$('#wu-datagrid-user').datagrid('hideColumn', 'opt');
	}

	// $('#wu-datagrid-user').datagrid({
	// onSortColumn: function (sort, order) {
	// alert("sort:"+sort+",order："+order+"");
	// }});

	// 分页
	var opts = $('#wu-datagrid-user').datagrid('options');
	findUser(opts.pageNumber, opts.pageSize);
}

/**
 * 查询通话记录
 * 
 * @param $userId
 */
function queryCallListByUserId(sId) {
	var title = '通话记录';
	var url = "call_list?userId=" + sId + "&t=" + new Date().getTime();
	var tabPanel = $('#wu-tabs');
	if (tabPanel.tabs('exists', title)) {
		tabPanel.tabs('select', title);
		var tab = tabPanel.tabs('getSelected');
		var title = tab.panel('options').title;
		$('#wu-tabs').tabs('update', {
			tab : tab,
			options : {
				title : title,
				cls : 'pd3',
				href : url,
				closable : true,
				fit : true,
				selected : true
			}
		});
	}
	else {
		$('#wu-tabs').tabs('add', {
			closable : true,
			title : title,
			href : url
		});
	}
}

/**
 * 调用接口
 * 
 * @param pageNumber 开始序号
 * @param pageSize 页面大小
 */
function findUser(pageNumber, pageSize) {
	// 获取选中的
	var departmentId = $('#departmentCombotree').combotree('getValue');
	// var departmentId = $("#departmentId option:selected").val();
	var statusId = $("#statusId option:selected").val();
	var sortId = $("#sortId option:selected").val();
	var keyword = $.trim($("#keyword").val());
	var userId = $("#sId").val();
	if (userId != null && userId != "") {
		data['userId'] = userId;
	}
	// alert("userId#"+userId+"#"+data['userId']);
	if (departmentId != null && departmentId != 0 && departmentId != "") {
		data['departmentId'] = departmentId;
	}
	if (statusId != "") {
		data['statusId'] = statusId;
	}
	if (sortId != "") {
		data['sortId'] = sortId;
	}
	if (keyword != "") {
		data['keyword'] = keyword;
	}
	data['startIndex'] = (pageNumber - 1) * pageSize;
	data['pageSize'] = pageSize;

	// 重置
	$('#wu-datagrid-user').datagrid('getPager').pagination({
		pageSize : pageSize,
		pageNumber : pageNumber
	});

	$('#wu-datagrid-user').datagrid("loading"); // 加屏蔽

	$.ajax({
		type : "POST",
		dataType : "json",
		url : "permission/queryUser",
		cache : false,
		// async : false,
		data : data,
		success : function(response) {
			if (response.code == 0) {
				var total = response.data.totalCount;
				var list = response.data.abstractList;
				$('#wu-datagrid-user').datagrid('loadData', pageData(list, total));

				// 分页
				var pager = $('#wu-datagrid-user').datagrid('getPager');
				if (pager) {
					$(pager).pagination({
						onBeforeRefresh : function() {
						},
						onRefresh : function(pageNumber, pageSize) {
						},
						onChangePageSize : function() {
						},
						onSelectPage : function(pageNumber, pageSize) {
							findUser(pageNumber, pageSize);
						}
					});
				}
			}
			else if (response.code == 1) {
				alert(response.message);
				window.location.href = 'login';
			}
			else if (response.code == 2) {
				alert(response.message);
				window.location.href = 'login';
			}
			else {
				alert("未知异常!");
				// window.location.href = 'login';
			}
		},
		error : function(err) {
			// 移除屏蔽
			$('#wu-datagrid-user').datagrid("loaded");
			$.messager.alert('操作提示', '获取数据失败!', 'error');
		},
		complete : function() {
			// 移除屏蔽
			$('#wu-datagrid-user').datagrid("loaded");
			$("#sId").val("");
			delete data['userId'];
			data = {};
		}
	});
}

/**
 * pageData用来封装获取的总条数和当前页数据
 * 
 * @param list 当前页数据
 * @param total 总条数
 * @returns
 */
function pageData(list, total) {
	var obj = new Object();
	obj.total = total;
	obj.rows = list;
	return obj;
}

/**
 * 查询用户
 */
function searchUser() {
	var opts = $('#wu-datagrid-user').datagrid('options');
	findUser(opts.pageNumber, opts.pageSize);
}

/**
 * 关闭新增用户对话框
 */
function createUserCancel() {
	$('#createUserDialog').window('close');
}

/**
 * 弹出新增用户对话框
 * 
 */
function showCreateUserDialog() {
	$('#createUserDialog').window('open');
	// 重置表单
	$('#createUserForm')[0].reset();
	$('#cDepartmentCombotree').combotree('setValue', 0);
}

/**
 * 关闭编辑用户对话框
 */
function modifyUserCancel() {
	$('#modifyUserDialog').window('close');
}

/**
 * 弹出对话框关闭事件
 * 
 */
// $('#modifyUserDialog').dialog({
// onClose : function() {
//
// }
// });
/**
 * 弹出编辑用户对话框
 * 
 */
function showModifyUserDialog(id, departmentId, titleId, name, phone, email, roleId, status) {
	$('#modifyUserDialog').window('open');
	// 重置表单
	$('#modifyUserForm')[0].reset();
	// $('#modifyUserForm').form('clear');
	$('#mDepartmentCombotree').combotree('setValue', departmentId);

	// 填充数据
	$("#mUId").val(id);
	$("#mUName").val(name);
	$("#mUEmail").val(email);
	$("#mUPhone").val(phone);
	// $("#mDepartmentId").val(departmentId);
	$("#mUTitleId").val(titleId);
	$("#mURoleId").val(roleId);
	document.getElementById('mUStatusId' + status).checked = true;
}

/**
 * 新增用户
 */
function createUser() {
	// 表单验证
	// if( !$('#createUserForm').form('enableValidation').form('validate') ) {
	// return false;
	// }
	// 获取参数
	var departmentId = $('#cDepartmentCombotree').combotree('getValue');
	// var departmentId = $.trim($("#cDepartmentId").val());
	var name = $.trim($("#cUName").val());
	if (name == '') {
		alert('姓名不能为空！');
		return false;
	}
	var email = $.trim($("#cUEmail").val());
	if (Regex.test(email)) {
	}
	else {
		if (email == '') {
			alert("邮箱不能为空！");
			return false;
		}
		else {
			alert("输入的邮件地址不正确，请重新输入！");
			return false;
		}
	}
	var password = $.trim($("#cUPassword").val());
	if (password == '') {
		alert('密码不能为空！');
		return false;
	}
	else {
		password = $.md5(password);
	}
	var phone = $.trim($("#cUPhone").val());
	if (isNaN(phone) || (phone.length != 11)) {
		alert("手机号为11位数字！请正确填写！");
		return false;
	}
	var titleId = $.trim($("#cUTitleId").val());
	var roleId = $.trim($("#cURoleId").val());
	var statusId = $('input[type="radio"][name="cUStatusId"]:checked').val();
	// var statusId = $.trim($("#cStatusId").val());
	// if (departmentId == '') {
	// alert('部门不能为空！');
	// return false;
	// }
	// if (titleId == '') {
	// alert('职称不能为空！');
	// return false;
	// }
	// if (roleId == '') {
	// alert('用户角色不能为空！');
	// return false;
	// }
	// if (statusId == '') {
	// alert('用户状态不能为空！');
	// return false;
	// }

	// 调用接口
	$.ajax({
		type : 'POST',
		url : "permission/createUser",
		dataType : 'json',
		cache : false,
		data : {
			name : name,
			departmentId : departmentId,
			email : email,
			password : password,
			phone : phone,
			status : statusId,
			roleId : roleId,
			// positionId : positionId,
			titleId : titleId
		},
		success : function(response) {
			if (response.code == 0) {
				alert("新增用户成功!");

				// 重置表单
				$('#createUserForm')[0].reset();

				// 关闭窗口
				$('#createUserDialog').window('close');

				// 获取用户
				searchUser();
			}
			else if (response.code == 1) {
				alert(response.message);
				window.location.href = 'login';
			}
			else if (response.code == 2) {
				alert(response.message);
				window.location.href = 'login';
			}
			else {
				alert(response.message);
				// window.location.href = 'login';
			}
		},
		error : function(request, status, cause) {
			alert("新增用户失败!");
			// $.messager.alert('操作提示', '新增用户失败!', 'error');
		},
		complete : function() {

		}
	});
}

/**
 * 修改用户
 */
function modifyUser() {
	// 获取参数
	var departmentId = $('#mDepartmentCombotree').combotree('getValue');
	// var departmentId = $.trim($("#mDepartmentId").val());
	var name = $.trim($("#mUName").val());
	if (name == '') {
		alert('姓名不能为空！');
		return false;
	}
	var email = $.trim($("#mUEmail").val());
	if (Regex.test(email)) {
		usermodifydata['email'] = email;
	}
	else {
		if (email == '') {
			alert("邮箱不能为空！");
			return false;
		}
		else {
			alert("输入的邮件地址不正确，请重新输入！");
			return false;
		}
	}

	var password = $.trim($("#mUPassword").val());
	if (password != '') {
		password = $.md5(password);
		usermodifydata['password'] = password;
	}
	var phone = $.trim($("#mUPhone").val());
	if (isNaN(phone) || (phone.length != 11)) {
		alert("手机号为11位数字！请正确填写！");
		return false;
	}
	var titleId = $.trim($("#mUTitleId").val());
	var roleId = $.trim($("#mURoleId").val());
	var statusId = $('input[type="radio"][name="mUStatusId"]:checked').val();
	// var statusId = $.trim($("#mStatusId").val());

	usermodifydata['id'] = $.trim($("#mUId").val());
	usermodifydata['name'] = name;
	usermodifydata['departmentId'] = departmentId;
	usermodifydata['phone'] = phone;
	usermodifydata['titleId'] = titleId;
	usermodifydata['roleId'] = roleId;
	usermodifydata['status'] = statusId;

	// 调用接口
	$.ajax({
		type : 'POST',
		url : "permission/modifyUser",
		dataType : 'json',
		cache : false,
		data : usermodifydata,
		success : function(response) {
			if (response.code == 0) {
				alert("编辑用户成功!");

				// 重置表单
				$('#modifyUserForm')[0].reset();

				// 关闭窗口
				$('#modifyUserDialog').window('close');

				// 获取用户
				searchUser();
			}
			else if (response.code == 1) {
				alert(response.message);
				window.location.href = 'login';
			}
			else if (response.code == 2) {
				alert(response.message);
				window.location.href = 'login';
			}
			else {
				alert(response.message);
				// window.location.href = 'login';
			}
		},
		error : function(request, status, cause) {
			alert("编辑用户失败!");
			// $.messager.alert('操作提示', '新增用户失败!', 'error');
		},
		complete : function() {

		}
	});
}
