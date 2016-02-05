var tmsJ5ModuleTitle = "";
var tmsJ5ModuleId = "";
// 建立zTree
// ----------------------
// treeId 为页面中放置zTree的目标ul的id
// option 为zTree的选项配置，保留默认配置时{}
// zNodes
// 为zTree的初始化节点数据，为一JSONARRAY：对于同步加载（一次性加载），zNodes包含所有节点数据；对于异步加载，zNodes可能为null，或者为根节点数据
// ----------------------
function buildTree(treeId, option, zNodes) {
	// 默认option配置
	var setting = {
		data : {// 采用简单JSON数据
			simpleData : {
				enable : true
			}
		},
		check : {
			enable : false,// 默认不生成复选框
			chkStyle : "checkbox",
			chkboxType : {
				"Y" : "ps",
				"N" : "ps"
			}
		}
	};
	setting = $.extend(setting, option);
	$.fn.zTree.init($("#" + treeId), setting, zNodes);// 初始化生成

}
// 返回zTree对象
function getTree(treeId) {
	return $.fn.zTree.getZTreeObj(treeId);
}

// 选择实际角色窗口,返回值 实际角色ID_实际角色名称
function chooseRealrole() {
	var retValue = openDialogFrame(getRootPath()
			+ "/core/realrole/Realrole-query.jsp", "", "600", "400");
	return retValue;
}

// realRoleId为表单中存放实际角色ID的控件ID
// realRoleName为表单中存放实际角色名称的控件ID
function queryRealrole(realRoleId, realRoleName) {
	var retValue = openDialogFrame(getRootPath()
			+ "/core/realrole/Realrole-query.jsp", {
		include : 1
	}, "600", "400");
	if (retValue != undefined) {
		var ret = retValue.split("_");
		$('#' + realRoleId).val(ret[0]);
		$('#' + realRoleName).val(ret[1]);
	}
}

function clearRealrole(realRoleId, realRoleName) {
	$('#' + realRoleId).val('');
	$('#' + realRoleName).val('');
}

// 选择子系统角色窗口,返回值 子角色ID_子角色名称
// reg_id 机构id，可选
function chooseSubrole(reg_id) {
	var retValue;
	if (arguments.length == 0) {
		retValue = openDialogFrame(getRootPath()
				+ "/core/subrole/Subrole-query.jsp", "", "600", "400");
	} else {
		retValue = openDialogFrame(getRootPath()
				+ "/core/subrole/Subrole-query.jsp", "reg_id=" + reg_id, "600",
				"400");
	}
	return retValue;
}

// subRoleId为表单中存放子角色ID的控件ID
// subRoleName为表单中存放子角色名称的控件ID
// reg_id 机构id，可选
function querySubrole(subRoleId, subRoleName, reg_id) {
	var retValue;
	if (arguments.length == 2) {
		retValue = openDialogFrame(getRootPath()
				+ "/core/subrole/Subrole-query.jsp", "", "400", "400");
	} else {
		retValue = openDialogFrame(getRootPath()
				+ "/core/subrole/Subrole-query.jsp", "reg_id=" + reg_id, "400",
				"400");
	}
	if (retValue != undefined) {
		var ret = retValue.split("_");
		$('#' + subRoleId).val(ret[0]);
		$('#' + subRoleName).val(ret[1]);
	}
}
function clearSubrole(subRoleId, subRoleName) {
	$('#' + subRoleId).val('');
	$('#' + subRoleName).val('');
}

// 选择计划
function queryPlan(idPlanCode, idPlanName) {
	var retValue = openDialogFrame(getRootPath()
			+ "/core/rptplancomp/PlanDef-query.jsp", "", "800", "550");
	if (retValue != undefined) {
		$('#' + idPlanCode).val(retValue.plan_code);
		$('#' + idPlanName).val(retValue.plan_name);
	}
}
function clearPlan(idPlanCode, idPlanName) {
	$('#' + idPlanCode).val('');
	$('#' + idPlanName).val('');
}

// 弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
function msgShow(title, msgString, msgType) {
	$.messager.alert(title, msgString, msgType);
}

// 确认框
function showConfirm(title, msg, callback) {
	$.messager.confirm(title, msg, function(r) {
		if (r) {
			if (jQuery.isFunction(callback))
				callback.call();
		}
	});
}

// 进度框
function showProcess(isShow, title, msg) {
	if (!isShow) {
		$.messager.progress('close');
		return;
	}
	var win = $.messager.progress({
		title : title,
		msg : msg,
		text : '正在处理数据,请稍后......',
		interval : 100

	});
}

/*
 * 刷新表 @param {} dataTableId
 */
function flashTable(dataTableId) {
	$('#' + dataTableId).datagrid('clearSelections');
	$('#' + dataTableId).datagrid('load');

}

/*
 * 取消DataGrid中的行选择(适用于Jquery Easy Ui中的dataGrid)
 * 注意：解决了无法取消"全选checkbox"的选择,不过，前提是必须将列表展示
 * 数据的DataGrid所依赖的Table放入html文档的最全面，至少该table前没有 其他checkbox组件。
 * 
 * @paramdataTableId将要取消所选数据记录的目标table列表id
 */
function clearSelect(dataTableId) {
	$('#' + dataTableId).datagrid('clearSelections');
	// 取消选择DataGrid中的全选
	$("input[type='checkbox']").eq(0).attr("checked", false);
}

/*
 * 关闭Jquery EasyUi的弹出窗口(适用于Jquery Easy Ui)
 * 
 * @paramdialogId将要关闭窗口的id
 */
function closeDialog(dialogId) {
	$('#' + dialogId).dialog('close');
}

/*
 * 自适应表格的宽度处理(适用于Jquery Easy Ui中的dataGrid的列宽),
 * 注：可以实现列表的各列宽度跟着浏览宽度的变化而变化，即采用该方法来设置DataGrid
 * 的列宽可以在不同分辨率的浏览器下自动伸缩从而满足不同分辨率浏览器的要求
 * 使用方法：(如:{field:'ymName',title:'编号',width:fillsize(0.08),align:'center'},)
 * 
 * @parampercent当前列的列宽所占整个窗口宽度的百分比(以小数形式出现，如0.3代表30%)
 * 
 * @return通过当前窗口和对应的百分比计算出来的具体宽度
 */
function fillsize(percent) {
	var bodyWidth = document.body.clientWidth;
	return (bodyWidth - 90) * percent;
}

/*
 * 获取所选记录行(单选)
 * 
 * @paramdataTableId目标记录所在的DataGrid列表的table的id @paramerrorMessage
 * 如果没有选择一行(即没有选择或选择了多行)的提示信息
 * 
 * @return 所选记录行对象，如果返回值为null,或者"null"(有时浏览器将null转换成了字符串"null")说明没有 选择一行记录。
 */
function getSingleSelectRow(dataTableId, errorMessage) {
	var rows = $('#' + dataTableId).datagrid('getSelections');
	var num = rows.length;
	if (num == 1) {
		return rows[0];
	} else {
		$.messager.alert('提示消息', errorMessage, 'info');
		return null;
	}
}

/*
 * 在DataGrid中获取所选记录的id,多个id用逗号分隔
 * 注：该方法使用的前提是：DataGrid的idField属性对应到列表Json数据中的字段名必须为id
 * @paramdataTableId目标记录所在的DataGrid列表table的id
 * 
 * @return 所选记录的id字符串(多个id用逗号隔开)
 */
function getSelectIds(dataTableId, noOneSelectMessage) {
	var rows = $('#' + dataTableId).datagrid('getSelections');
	var num = rows.length;
	var ids = null;
	if (num < 1) {
		if (null != noOneSelectMessage)
			$.messager.alert('提示消息', noOneSelectMessage, 'info');
		return null;
	} else {
		for ( var i = 0; i < num; i++) {
			if (null == ids || i == 0) {
				ids = rows[i].id;
			} else {
				ids = ids + "," + rows[i].id;
			}
		}
		return ids;
	}
}

/*
 * 删除所选记录(适用于Jquery Easy Ui中的dataGrid)(删除的依据字段是id)
 * 注：该方法会自动将所选记录的id(DataGrid的idField属性对应到列表Json数据中的字段名必须为id)
 * 动态组装成字符串，多个id使用逗号隔开(如：1,2,3,8,10)，然后存放入变量ids中传入后台，后台
 * 可以使用该参数名从request对象中获取所有id值字符串，此时在组装sql或者hql语句时可以采用in 关键字来处理，简介方便。
 * 另外，后台代码必须在操作完之后以ajax的形式返回Json格式的提示信息，提示的json格式信息中必须有一个
 * message字段，存放本次删除操作成功与失败等一些提示操作用户的信息。 delId 调用方传进来的id，不限死
 * @paramdataTableId将要删除记录所在的列表table的id @paramrequestURL与后台服务器进行交互，进行具体删除操作的请求路径
 * @paramconfirmMessage 删除确认信息
 */

function deleteNoteById(dataTableId, requestURL, confirmMessage) {
	// var obj=new Object(delId);

	if (null == confirmMessage || typeof (confirmMessage) == "undefined"
			|| "" == confirmMessage) {
		confirmMessage = "确定删除所选记录?";
	}
	var rows = $('#' + dataTableId).datagrid('getSelections');
	var num = rows.length;
	var ids = null;
	var fields = null;
	if (num < 1) {
		msgShow('提示消息', '请选择你要删除的记录!', 'info');
	} else {
		$.messager.confirm('确认', confirmMessage, function(r) {
			if (r) {
				for ( var i = 0; i < num; i++) {
					if (null == ids || i == 0) {
						ids = $.trim(rows[i].KEYID);
					} else {
						ids = $.trim(ids) + "," + $.trim(rows[i].KEYID);
					}
				}
				fields = rows[0].FIELDS;
				// alert(ids);
				// var keyId=escape(escape($.trim(ids)));
				// var param={"ids":keyId};
				// alert(buildDelParam(ids,fields));
				// var param="ids="+keyId;

				var param = buildDelParamModule(ids, fields);

				// alert(param)

				$.getJSON(requestURL, param, function(data) {
					if (null != data && null != data.status
							&& "" != data.status && data.status == "true") {
						msgShow('提示消息', data.message, 'info');
						flashTable(dataTableId);
					} else {
						if (data.message == null || data.message == "") {
							msgShow('提示消息', '删除失败！', 'error');
						} else {
							msgShow('提示消息', data.message, 'error');
						}

					}
					clearSelect(dataTableId);
				});
			}
		});
	}
}

function buildDelParam(ids, fields) {
	if (ids && fields) {
		var filedsary = fields.split("/");
		ids = ids.toString();
		var idsary = ids.split(",");
		var retParam = "";
		for ( var i = 0; i < filedsary.length; i++) {
			var idsValue = "";
			for ( var j = 0; j < idsary.length; j++) {
				var tt = idsary[j];
				var ttary = tt.split("/");
				for ( var k = 0; k < ttary.length; k++) {
					if (i == k) {
						idsValue += escape(escape($.trim(ttary[k]))) + ",";
					}
				}
			}
			retParam += filedsary[i] + "="
					+ idsValue.substring(0, idsValue.lastIndexOf(",")) + "&";
		}
		return retParam.substring(0, retParam.lastIndexOf("&"));
	}

}

function buildDelParamModule(ids, fields) {
	if (ids && fields) {
		var filedsary = fields.split("/");
		ids = ids.toString();
		var idsary = ids.split(",");
		var retParam = "";
		for ( var i = 0; i < filedsary.length; i++) {
			var idsValue = "";
			for ( var j = 0; j < idsary.length; j++) {
				var tt = idsary[j];
				var ttary = tt.split("/");
				for ( var k = 0; k < ttary.length; k++) {
					if (i == k) {
						idsValue += escape(escape($.trim(ttary[k]))) + ",";
					}
				}
			}
			retParam += filedsary[i] + "="
					+ idsValue.substring(0, idsValue.lastIndexOf(",")) + "&";
		}
		// alert(tmsJ5ModuleTitle);
		if (tmsJ5ModuleTitle != '' && tmsJ5ModuleTitle != undefined) {
			retParam = retParam + "tmsModuleTitle="
					+ escape(escape(tmsJ5ModuleTitle)) + "&tmsModuleId="
					+ tmsJ5ModuleId;
		} else {// added by linfux on 20120724,在打开的窗口中调用删除
			var tmsModuleId = $("#idTmsModuleId").val();// alert(tmsModuleId);
			var tmsModuleTitle = $('#idTmsModuleTitle').val();
			retParam = retParam + "tmsModuleTitle="
					+ escape(escape(tmsModuleTitle)) + "&tmsModuleId="
					+ tmsModuleId;
		} // return retParam.substring(0,retParam.lastIndexOf("&"));
		// alert(retParam);
		return retParam;
	}

}

function updateValidate(dataTableId) {
	var rows = $('#' + dataTableId).datagrid('getSelections');
	var ids;
	var fields = null;
	if (rows) {
		var num = rows.length;
		if (num < 1) {
			msgShow('提示消息', '请选择你要修改的记录!', 'info');
		} else if (num > 1) {
			msgShow('提示消息', '只能选择一条信息进行修改!', 'info');
		} else {
			for ( var i = 0; i < num; i++) {
				if (null == ids || i == 0) {
					ids = rows[i].KEYID;
				} else {
					ids = ids + "," + rows[i].KEYID;

				}
			}
			fields = rows[0].FIELDS;
		}
	}
	return buildDelParam(ids, fields);

}

/*
 * 根据methodName判断方法是否存在
 */
function methodIsExsit(frameObj, methodName) {
	if (frameObj == null)
		return false;

	var sObj = frameObj.document.getElementsByTagName("script");
	var sLen = sObj.length;
	if (sLen > 0) {
		for (i = 0; i < sLen; i++) {
			var scriptText = sObj[i].innerHTML;
			if (scriptText.indexOf("function " + methodName) != -1) {
				return true;
			}
		}
	}
	return false;
}

/**
 * 打开一个dialog,对象页面显示在dialog内的一个帧中 params: fileName:
 * 文件名,注意是/dialog.jsp的相对路径，例如system/add_org.jsp title: 对话框的标题 height: 高度 width:
 * 宽度 resize: 是否可以调整大小
 */
function openDialogFrame(filePath, param, width, height, resize) {
	// added by linfux on 20120724,在打开的窗口中再次打开窗口
	if (tmsJ5ModuleTitle == '' || tmsJ5ModuleTitle == undefined) {
		tmsJ5ModuleId = $("#idTmsModuleId").val();// alert(tmsModuleId);
		tmsJ5ModuleTitle = $('#idTmsModuleTitle').val();
	}
	if (param) {
		var params = {
			win : window,
			par : param,
			tmsModuleTitle : tmsJ5ModuleTitle,
			tmsModuleId : tmsJ5ModuleId
		}
	} else {
		// alert(tmsJ5ModuleTitle+"######"+tmsJ5ModuleId);
		// var params=window;
		var params = {
			win : window,
			tmsModuleTitle : tmsJ5ModuleTitle,
			tmsModuleId : tmsJ5ModuleId
		};

	}

	height = Number(height);
	var browser = navigator.appName
	if (browser == "Microsoft Internet Explorer") {
		var b_version = navigator.appVersion
		var version = b_version.split(";");
		var trim_Version = version[1].replace(/[ ]/g, "");
		if (trim_Version == "MSIE6.0") {
			height += 30;
		} else if (trim_Version == "MSIE7.0") {
			height -= 10;
		}
	}
	if (resize == null || resize == "") {
		return window.showModalDialog(filePath, params, 'dialogHeight:'
				+ height + 'px;dialogWidth:' + width
				+ 'px;resizable:auto;help:no;status:no');
	} else {
		return window.showModalDialog(filePath, params, 'dialogHeight:'
				+ height + 'px;dialogWidth:' + width + 'px;resizable:' + resize
				+ ';help:no;status:no');
	}
}

function openDialogFrame_refresh(fileName, title, width, height, resize) {
	if (resize == null || resize == "") {
		return window.showModalDialog('dialog_refresh.jsp?title=' + title
				+ '&src=' + escape(fileName) + '&scroll=no', 0, 'dialogHeight:'
				+ height + 'px;dialogWidth:' + width
				+ 'px;resizable:auto;help:no;status:no');
		// return window.showModalDialog( fileName,0,'dialogHeight:' + height +
		// 'px;dialogWidth:'+width+'px;resizable:auto;help:no;scroll:no;status:no'
		// );
	} else {
		return window.showModalDialog('dialog_refresh.jsp?title=' + title
				+ '&src=' + escape(fileName), 0, 'dialogHeight:' + height
				+ 'px;dialogWidth:' + width + 'px;resizable:' + resize
				+ ';help:no;status:no');
		// return window.showModalDialog( fileName,0,'dialogHeight:' + height +
		// 'px;dialogWidth:'+width+'px;resizable:'+ resize
		// +';help:no;scroll:no;status:no' );
	}
}

/**
 * 打开一个dialog,对象页面显示在dialog内的一个帧中 params: fileName:
 * 文件名,注意是/dialogCF.jsp的相对路径，例如system/add_org.jsp title: 对话框的标题 height: 高度
 * width: 宽度 resize: 是否可以调整大小 author:bianzk
 */
function openDialogFrameCF(fileName, title, width, height, resize) {
	if (resize == null || resize == "") {
		return window.showModalDialog('dialogCF.jsp?title=' + title + '&src='
				+ escape(fileName) + '&scroll=no', 0, 'dialogHeight:' + height
				+ 'px;dialogWidth:' + width
				+ 'px;resizable:auto;help:no;status:no');
		// return window.showModalDialog( fileName,0,'dialogHeight:' + height +
		// 'px;dialogWidth:'+width+'px;resizable:auto;help:no;scroll:no;status:no'
		// );
	} else {
		return window.showModalDialog('dialogCF.jsp?title=' + title + '&src='
				+ escape(fileName), 0, 'dialogHeight:' + height
				+ 'px;dialogWidth:' + width + 'px;resizable:' + resize
				+ ';help:no;status:no');
		// return window.showModalDialog( fileName,0,'dialogHeight:' + height +
		// 'px;dialogWidth:'+width+'px;resizable:'+ resize
		// +';help:no;scroll:no;status:no' );
	}
}

/**
 * 打开一个dialog,对象页面显示在dialog内的一个帧中(其中补包括 确定和取消 ) params: fileName:
 * 文件名,注意是/dialog.jsp的相对路径，例如system/add_org.jsp title: 对话框的标题 height: 高度 width:
 * 宽度 resize: 是否可以调整大小 auther: weng
 */
function openDialogNoOkCancel(fileName, title, width, height, resize) {
	if (resize == null || resize == "") {
		return window.showModalDialog('issue_dialog.jsp?title=' + title
				+ '&src=' + escape(fileName) + '&scroll=no', 0, 'dialogHeight:'
				+ height + 'px;dialogWidth:' + width
				+ 'px;resizable:auto;help:no;status:no');
		// return window.showModalDialog( fileName,0,'dialogHeight:' + height +
		// 'px;dialogWidth:'+width+'px;resizable:auto;help:no;scroll:no;status:no'
		// );
	} else {
		return window.showModalDialog('issue_dialog.jsp?title=' + title
				+ '&src=' + escape(fileName), 0, 'dialogHeight:' + height
				+ 'px;dialogWidth:' + width + 'px;resizable:' + resize
				+ ';help:no;status:no');
		// return window.showModalDialog( fileName,0,'dialogHeight:' + height +
		// 'px;dialogWidth:'+width+'px;resizable:'+ resize
		// +';help:no;scroll:no;status:no' );
	}
}

/**
 * 打开一个dialog,对象页面显示在dialog内的一个帧中(其中包括 关闭 ) params: fileName:
 * 文件名,注意是/dialog.jsp的相对路径，例如system/add_org.jsp title: 对话框的标题 height: 高度 width:
 * 宽度 resize: 是否可以调整大小 auther: goodhq
 */
function openDialogOnlyClose(fileName, title, width, height, resize) {
	if (resize == null || resize == "") {
		return window.showModalDialog('close_dialog.jsp?title=' + title
				+ '&src=' + escape(fileName) + '&scroll=no', 0, 'dialogHeight:'
				+ height + 'px;dialogWidth:' + width
				+ 'px;resizable:auto;help:no;status:no');
		// return window.showModalDialog( fileName,0,'dialogHeight:' + height +
		// 'px;dialogWidth:'+width+'px;resizable:auto;help:no;scroll:no;status:no'
		// );
	} else {
		return window.showModalDialog('close_dialog.jsp?title=' + title
				+ '&src=' + escape(fileName), 0, 'dialogHeight:' + height
				+ 'px;dialogWidth:' + width + 'px;resizable:' + resize
				+ ';help:no;status:no');
		// return window.showModalDialog( fileName,0,'dialogHeight:' + height +
		// 'px;dialogWidth:'+width+'px;resizable:'+ resize
		// +';help:no;scroll:no;status:no' );
	}
}

function eCode(obj) {
	return escape(escape(obj));
}

function getRootPath() {
	var strFullPath = window.document.location.href;
	var strPath = window.document.location.pathname;
	var pos = strFullPath.indexOf(strPath);
	var prePath = strFullPath.substring(0, pos);
	var postPath = strPath.substring(0, strPath.substr(1).indexOf('/') + 1);
	return (prePath + postPath);
}

$
		.extend(
				$.fn.validatebox.defaults.rules,
				{
					minLength : { // 判断最小长度
						validator : function(value, param) {
							return $.trim(value).length >= param[0];
						},
						message : '最少输入 {0} 个字符。'
					},
					maxLen : {
						validator : function(value, param) {
							return limitMaxLenB($.trim(value), param[0]);
						},
						message : '最大长度是{0}'
					},
					length : {
						validator : function(value, param) {
							var len = $.trim(value).length;
							return len >= param[0] && len <= param[1];
						},
						message : "输入内容长度必须介于{0}和{1}之间."
					},
					phone : {// 验证电话号码
						validator : function(value) {
							return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i
									.test($.trim(value));
						},
						message : '格式不正确,请使用下面格式:020-88888888'
					},
					mobile : {// 验证手机号码
						validator : function(value) {
							return /^(13|15|18)\d{9}$/i.test($.trim(value));
						},
						message : '手机号码格式不正确,请输入[13|15|18]开头的手机号码!!'
					},
					idcard : {// 验证身份证
						validator : function(value) {
							return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test($
									.trim(value));
						},
						message : '身份证号码格式不正确'
					},
					intOrFloat : {// 验证整数或小数
						validator : function(value) {
							return /^\d+(\.\d+)?$/i.test($.trim(value));
						},
						message : '请输入数字，并确保格式正确'
					},
					currency : {// 验证货币
						validator : function(value) {
							return /^\d+(\.\d+)?$/i.test($.trim(value));
						},
						message : '货币格式不正确'
					},
					qq : {// 验证QQ,从10000开始
						validator : function(value) {
							return /^[1-9]\d{4,9}$/i.test($.trim(value));
						},
						message : 'QQ号码格式不正确'
					},
					integer : {// 验证整数
						validator : function(value) {
							return /^[+]?[1-9]+\d*$/i.test($.trim(value));
						},
						message : '请输入整数'
					},
					chinese : {// 验证中文
						validator : function(value) {
							return /^[\u0391-\uFFE5]+$/i.test($.trim(value));
						},
						message : '请输入中文'
					},
					english : {// 验证英语
						validator : function(value) {
							return /^[A-Za-z]+$/i.test($.trim(value));
						},
						message : '请输入英文'
					},
					number : {// 验证数字
						validator : function(value) {
							return /^[0-9]+$/i.test($.trim(value));
						},
						message : '请输入数字'
					},
					numberorchar : {// 验证数字或字母
						validator : function(value) {
							return /^[0-9a-zA-Z]+$/i.test($.trim(value));
						},
						message : '请输入数字或字母'
					},
					numAndLen : {// 只能是数字,，而且有长度限制
						validator : function(value, param) {
							if (!(/^[0-9]+$/i.test($.trim(value)))) {
								$.fn.validatebox.defaults.rules.numAndLen.message = '请输入数字';
								return false;
							} else {
								var len = $.trim(value).length;
								if (len != param[0]) {
									$.fn.validatebox.defaults.rules.numAndLen.message = '输入的数字必须是{0}位';
									return false;
								} else {
									return true;
								}
							}

						}
					},
					maxLenAndNotNull : {
						validator : function(value, param) {
							if (!limitMaxLenB(value, param[0])) {
								$.fn.validatebox.defaults.rules.maxLenAndNotNull.message = '最大长度是{0}';
								return false;
							} else {
								var len = $.trim(value).length;
								if (len == 0) {
									$.fn.validatebox.defaults.rules.maxLenAndNotNull.message = '不能输入空格';
									return false;
								} else {
									return true;
								}
							}

						}
					},
					unnormal : {// 验证是否包含空格和非法字符
						validator : function(value) {
							return /.+/i.test(value);
						},
						message : '输入值不能为空和包含其他非法字符'
					},
					username : {// 验证用户名
						validator : function(value) {
							return /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i.test($
									.trim(value));
						},
						message : '用户名不合法（字母开头，允许6-16字节，允许字母数字下划线）'
					},
					faxno : {// 验证传真
						validator : function(value) {
							// return /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[
							// ]){1,12})+$/i.test(value);
							return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i
									.test($.trim(value));
						},
						message : '传真号码格式不正确，请检查!!!'
					},
					zip : {// 验证邮政编码
						validator : function(value) {
							return /^[1-9]\d{5}$/i.test($.trim(value));
						},
						message : '邮政编码格式不正确!!!'
					},
					ip : {// 验证IP地址
						validator : function(value) {
							return /d+.d+.d+.d+/i.test($.trim(value));
						},
						message : 'IP地址格式不正确!!!'
					},
					name : {// 验证姓名，可以是中文或英文
						validator : function(value) {
							return /^[\u0391-\uFFE5]+$/i.test(value)
									| /^\w+[\w\s]+\w+$/i.test($.trim(value));
						},
						message : '请输入姓名,可以是中文或英文'
					},
					carNo : {
						validator : function(value) {
							return /^[\u4E00-\u9FA5][\da-zA-Z]{6}$/.test($
									.trim(value));
						},
						message : '车牌号码无效（例：粤J12350）'
					},
					carenergin : {
						validator : function(value) {
							return /^[a-zA-Z0-9]{16}$/.test($.trim(value));
						},
						message : '发动机型号无效(例：FG6H012345654584)'
					},
					email : {
						validator : function(value) {
							return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
									.test($.trim(value));
						},
						message : '请输入有效的电子邮件账号(例：abc@126.com)'
					},
					msn : {
						validator : function(value) {
							return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
									.test($.trim(value));
						},
						message : '请输入有效的msn账号(例：abc@hotnail(msn/live).com)'
					},
					same : {
						validator : function(value, param) {
							value = $.trim(value);
							if ($("#" + param[0]).val() != "" && value != "") {
								return $("#" + param[0]).val() == value;
							} else {
								return true;
							}
						},
						message : '两次输入的密码不一致！'
					},
					safepass : {
						validator : function(value, param) {
							return safePassword($.trim(value));
						},
						message : '密码由字母或者数字组成，至少6位，最大20位'
					},
					equalTo : {
						validator : function(value, param) {
							return $.trim(value) == $(param[0]).val();
						},
						message : '两次输入的密码不一至'
					},
					dateNotEarlier : { // 判断日期是否大于等于传的开始日期，该验证用于结束日期,added by
										// linfux
						validator : function(value, param) {
							return compareDate(value, param[0]);
						},
						message : '结束日期不能小于开始日期{0}'
					},
					phoneOrMobile : {
						validator : function(value, param) {
							var value = $.trim(value);
							return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i
									.test(value)
									|| checkMobile(value);
						},
						message : '请输入正确的电话/手机号码'
					},
					numberFixLength : {// 固定长度且为数字，使用:validType="numberFixLength[8]",added
										// by linfux
						validator : function(value, param) {
							return (/^[0-9]+$/i.test(value))
									&& ($.trim(value).length == param[0]);
							// return (/^[0-9a-zA-Z]+$/i.test(value)) &&
							// ($.trim(value).length==param[0]);
						},
						message : '请输入数字且位数为{0}'
					},
					numberCharFixLength : {// 固定长度且为数字，使用:validType="numberFixLength[8]",added
											// by linfux
						validator : function(value, param) {
							// return (/^[0-9]+$/i.test(value)) &&
							// ($.trim(value).length==param[0]);
							return (/^[0-9a-zA-Z]+$/i.test(value))
									&& ($.trim(value).length == param[0]);
						},
						message : '请输入数字或字母且位数为{0}'
					},
					numberMax : {// 固定值且为数字，使用:validType="numberMax[8]",added
									// by linfux
						validator : function(value, param) {
							return (/^[0-9]+$/i.test(value))
									&& (parseInt($.trim(value)) <= parseInt(param[0]))
									&& value != '0' && value != '00';
						},
						message : '可分配线路数剩余为:{0},请输入数字,且数值不为0!'
					},
					numberLessThan : {// 不超过指定值的数字，使用:validType="numberLessThan[100]",小于100的数值
						validator : function(value, param) {
							return (/^[0-9]+$/i.test(value))
									&& (parseInt($.trim(value)) <= parseInt(param[0]))
									&& parseInt($.trim(value)) != 0;
						},
						message : '请输入不超过{0}的数字!'
					},
					isHalfChars : {// 请输字母数字.的组合！added by linjc
						validator : function(value) {
							return /^[0-9a-zA-Z.]+$/i.test($.trim(value));
						},
						message : '请输字母数字的组合！'
					},
					isHalfCharsForFactory : {// 请输字母数字.的组合！added by linjc
						validator : function(value) {
							return /^[0-9a-zA-Z._]+$/i.test(value);
						},
						message : '请输字母数字的组合！'
					},
					isNull : {
						validator : function(value) {
							var len = $.trim(value).length;
							if (len <= 0) {
								return false;
							} else {
								return true;
							}
						},
						message : '不能输入空格！'
					},
					noBlank : {
						validator : function(value) {
							if (value.indexOf(' ') > -1) {
								return false;
							} else {
								return true;
							}
						},
						message : '不能包含空格！'
					}

				});

/* 密码由字母和数字组成，至少6位 */
var safePassword = function(value) {
	// return
	// !(/^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/.test(value));
	return (/^[0-9a-zA-Z]{6,20}$/.test(value));
}

var checkPhone = function(value) {
	return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i
			.test(value);
}

var checkMobile = function(value) {
	return /^(13|15|18)\d{9}$/i.test(value);
}

/**
 * 限制最大的字节数，中文两位 用法如 onkeyup="return limitMaxByte(this,this.maxlength)"
 */
function limitMaxByte(obj, maxByte) {
	var val = obj.value;// alert(val);alert(maxByte);
	maxByte = obj.maxLength;// js不能用maxlength,页面可以用maxlength,maxLength
	var i = 0, sum = 0;
	var index = 0;// alert(maxByte);alert(val);
	for (i = 0; i < val.length; i++) {
		if ((val.charCodeAt(i) >= 0) && (val.charCodeAt(i) <= 255))
			sum = sum + 1;
		else
			sum = sum + 2;
		if (sum > maxByte) {
			obj.value = val.substring(0, i);
			return false;
		}
	}
	return true;
}

/**
 * 限制最大的字节数，中文两位 用法如 onkeypress="return limitMaxLenB(this.value,10)"
 */
function limitMaxLenB(val, maxLenB) {
	var i = 0, sum = 0;
	for (i = 0; i < val.length; i++) {
		if ((val.charCodeAt(i) >= 0) && (val.charCodeAt(i) <= 255))
			sum = sum + 1;
		else
			sum = sum + 2;
	}
	if (sum > maxLenB)
		return false;
	else
		return true;
}

/**
 * 
 * 验证字符串必需以参数str开头
 * 
 */
String.prototype.startWith = function(str) {
	if (str == null || str == "" || this.length == 0
			|| str.length > this.length)
		return false;
	if (this.substr(0, str.length) == str)
		return true;
	else
		return false;
	return true;
}

/* 去除字符串首尾空格 */
function Trim(his) {
	// 找到字符串开始位置
	Pos_Start = -1;
	for ( var i = 0; i < his.length; i++) {
		if (his.charAt(i) != " ") {
			Pos_Start = i;
			break;
		}
	}
	// 找到字符串结束位置
	Pos_End = -1;
	for ( var i = his.length - 1; i >= 0; i--) {
		if (his.charAt(i) != " ") {
			Pos_End = i;
			break;
		}
	}
	// 返回的字符串
	Str_Return = ""
	if (Pos_Start != -1 && Pos_End != -1) {
		for ( var i = Pos_Start; i <= Pos_End; i++) {
			Str_Return = Str_Return + his.charAt(i);
		}
	}
	return Str_Return;
}

/* 获取值的长度，中文两位 */
function getMaxLength(value1) {
	var iCount = 0;
	var length = value1.length;
	for ( var i = 0; i < length; i++) {
		if (value1.charCodeAt(i) < 0 || value1.charCodeAt(i) > 255)
			iCount++;// double char+1
		iCount++;
	}
	return iCount;
}

// 分支机构模态窗按钮事件 regId为取值控件的id
function queryReg(regId, regName, regEntireId) {
	var retValue = openDialogFrame(getRootPath()
			+ "/core/reginfo/RegInfo-query.jsp", "", "400", "300");
	if (retValue != undefined) {

		// var reg = retValue.split("_");
		$('#' + regId).val(retValue.reg_id);
		$('#' + regName).val(retValue.reg_name);
		if (regEntireId != undefined) {
			$('#' + regEntireId).val(retValue.reg_entire_id);
		}
	}
}
function clearReg(regId, regName, regEntireId) {
	$('#' + regId).val('');
	$('#' + regName).val('');
	if (regEntireId != undefined) {
		$('#' + regEntireId).val('');
	}
}

function defaultQueryReg() {
	$.ajax({
		type : "POST",
		url : "initDataForMerchInfo.do",
		data : "param=idRegId,regEntireId", // idOrgId,idMerchStatus
		success : function(data) {
			if (data.idRegId && data.regEntireId) {
				var str = data.idRegId.split("(");
				$("#idRegId").val(str[1].substring(0, str[1].length - 1));
				$("#idRegName").val(data.idRegId);
				$("#idRegEntireId").val(data.regEntireId);
			}

		}
	});
}

/*
 * 获取总公司分支机构号，added by linfux on 2012-08-21
 * 在页面加载时候调用该方法onload="getRootRegId('queryForm');"，并通过
 * $("#idRootRegId").val()获取机构号
 */
function getRootRegId(formId) {
	$
			.ajax({
				type : "POST",
				url : "getRootRegId.do",
				data : "",
				success : function(data) {
					if (data && data.rootRegId) {
						if (formId) {
							$('#' + formId)
									.append(
											'<input type="hidden" id="idRootRegId"  name="idRootRegId">');
							$("#idRootRegId").val(data.rootRegId);
						} else {
							$("#ff")
									.append(
											'<input type="hidden" id="idRootRegId"  name="rootRegId">');
							$("#idRootRegId").val(data.rootRegId)
						}
					}
				}
			});
}

// 查询选择计划信息，传入的id为取值控件的id
function selectPlan(idPlanCode, idPlanName) {// 选择计划
	var retValue = openDialogFrame(getRootPath()
			+ '/core/taskinfo/PlanDef-index.jsp', '', "800", "650");
	if (retValue != undefined) {
		var plan = retValue.split("_");
		$('#' + idPlanCode).val(plan[0]);
		$('#' + idPlanName).val(plan[1]);
	}
}

/*
 * 比例两日期大小，DateOne>=DateTwo 返回true 日期格式2011-04-12，也可以带时间(如2011-04-12
 * 11:1:11)，但只比较日期
 */
function compareDate(DateOne, DateTwo) {
	var OneMonth = DateOne.substring(5, DateOne.lastIndexOf("-"));
	var OneDay = DateOne.substring(DateOne.lastIndexOf("-") + 1, 10);
	var OneYear = DateOne.substring(0, DateOne.indexOf("-"));
	var TwoMonth = DateTwo.substring(5, DateTwo.lastIndexOf("-"));
	var TwoDay = DateTwo.substring(DateTwo.lastIndexOf("-") + 1, 10);
	var TwoYear = DateTwo.substring(0, DateTwo.indexOf("-"));
	if (Date.parse(OneMonth + "/" + OneDay + "/" + OneYear) >= Date
			.parse(TwoMonth + "/" + TwoDay + "/" + TwoYear)) {
		return true;
	} else {
		return false;
	}
}

// 生成sequenceId，页面使用
// sequencename,sequence的名称,element页面元素，承载sequence的值
function getSequence(sequencename, element) {
	var param = "sequeceId=" + sequencename;
	$.ajax({
		type : "POST",
		url : "getMaxId.do",
		data : param,
		success : function(data) {
			$("#" + element).val(data);
		},
		error : function(data) {
			msgShow("获取Id错误", data, "error");
		}
	});

}

// 获取对象属性,用于查看对象属性,for test
function getObjectProp(obj) {
	var ret = "Properties:\n";
	for ( var prop in obj) {
		var val = obj[prop];
		if (typeof (val) === "function") {
			ret += (prop + "()");
		} else {
			ret += prop + ":" + val;
		}
		ret += ";\n";
	}
	alert(ret);
}
// 判断主键是否存在，传入主键键名 键值 判断方法
// 传入参数FieldName为数据库XML文件中获取参数的名称，如果是复合主键，请用|隔开，如regId|regName
// 传入参数FieldValue为参数名称对应的值，如果是复合主键，请用|隔开，顺序与FieldName对应
// 传入参数func为XML文件中获取页面记录数的方法命
// 例如checkPKIsExist("regId",value,"listRegInfoForPageCount")
// 该方法返回三种参数 true代表已经存在 false代表不存在 exception代表异常，均为字符串形式
function checkPKIsExist(FieldName, FieldValue, func) {
	var flag = "exception";
	$.ajax({
		type : "POST",
		async : false,
		url : "isExist.do",
		data : "FieldName=" + FieldName + "&FieldValue=" + FieldValue
				+ "&func=" + func,
		success : function(data) {
			if (data.exist) {
				flag = "true";
			} else {
				flag = "false"
			}
		}
	});
	return flag;

}

function initDate() {
	var head = document.getElementsByTagName("head").item(0);
	var script = document.createElement("script");
	script.src = getRootPath() + "/js/DatePicker/WdatePicker.js";
	head.appendChild(script);
}

Date.prototype.Format = function(formatStr) {
	var str = formatStr;
	var Week = [ '日', '一', '二', '三', '四', '五', '六' ];

	str = str.replace(/yyyy|YYYY/, this.getFullYear());
	str = str.replace(/yy|YY/,
			(this.getYear() % 100) > 9 ? (this.getYear() % 100).toString()
					: '0' + (this.getYear() % 100));

	str = str.replace(/MM/, (this.getMonth() + 1) > 9 ? (this.getMonth() + 1)
			.toString() : '0' + (this.getMonth() + 1));
	str = str.replace(/M/g, this.getMonth() + 1);

	str = str.replace(/w|W/g, Week[this.getDay()]);

	str = str.replace(/dd|DD/, this.getDate() > 9 ? this.getDate().toString()
			: '0' + this.getDate());
	str = str.replace(/d|D/g, this.getDate());

	str = str.replace(/hh|HH/, this.getHours() > 9 ? this.getHours().toString()
			: '0' + this.getHours());
	str = str.replace(/h|H/g, this.getHours());
	str = str.replace(/mm/, this.getMinutes() > 9 ? this.getMinutes()
			.toString() : '0' + this.getMinutes());
	str = str.replace(/m/g, this.getMinutes());

	str = str.replace(/ss|SS/, this.getSeconds() > 9 ? this.getSeconds()
			.toString() : '0' + this.getSeconds());
	str = str.replace(/s|S/g, this.getSeconds());

	return str;
}

// 初始化根据厂商选择型号数据
function initDataForModelInfo(param) {
	$.ajax({
		type : "POST",
		url : "initDataForModelInfo.do",
		data : "param=" + param, // 参数可以是idFidSelect,idMidSelect,idDllDir
		success : function(data) {
			if (data.idFidSelect) {// 对idFidSelect(厂商）进行赋值
				var option;
				for ( var i = 0; i < data.idFidSelect.length; i++) {
					option = new Option(data.idFidSelect[i].F_NAME,
							data.idFidSelect[i].FID);
					document.getElementById("idFidSelect").options.add(option);
					// option += "<option value=" + data.idFidSelect[i].FID +">"
					// + data.idFidSelect[i].F_NAME+ "</option>";
				}
				// $("#idFidSelect").append(option);
			}
			if (data.idMidSelect) { // 对idMidSelect(主机型号）进行赋值
				for ( var i = 0; i < data.idMidSelect.length; i++) {
					option = new Option(data.idMidSelect[i].MID_NAME,
							data.idMidSelect[i].MID);
					document.getElementById("idMidSelect").options.add(option);
				}
			}

			if (data.idDllDir) {//
				$("#idDllDir").val(data.idDllDir);
				$("#dllDirDefaultValue").val(data.idDllDir);
			}

		}
	});
}

// 根据厂商(FID)改变主机型号
function changeModelByFID(fId) {

	$.ajax({
		type : "POST",
		url : "getModelInfoByFID.do",
		data : "FID=" + fId,
		success : function(data) {
			var option;
			$("#idMidSelect").empty();

			option = new Option("请选择终端型号", "");
			document.getElementById("idMidSelect").options.add(option);

			if (data.idMidSelect) {
				$.each(data.idMidSelect, function(idx, item) {
					option = new Option(item.MID_NAME, item.MID);
					document.getElementById("idMidSelect").options.add(option);
				});
			}
		}
	});
}

// 查找商户窗口
function selectMerch(id) {
	var retValue = openDialogFrame(getRootPath()
			+ "/core/aposquery/MerchInfo-index.jsp", "", "800", "500");
	if (retValue) {
		$("#" + id).val(retValue);
	}
}
function clearMerch(id) {
	$('#' + id).val("");
}

// 设置模块id和名称
function setModuleNameAndId(formId) {
	$(document)
			.ready(
					function() {
						var k = window.dialogArguments;
						if (k.tmsModuleTitle && k.tmsModuleId) {
							if (formId) {
								$('#' + formId)
										.append(
												'<input type="hidden" id="idTmsModuleTitle"  name="tmsModuleTitle"><input type="hidden" id="idTmsModuleId" name="tmsModuleId">');
								$('#' + formId).find("#idTmsModuleTitle").attr(
										"value", k.tmsModuleTitle);// find方式设置，只能通过find方式获取
								$('#' + formId).find("#idTmsModuleId").attr(
										"value", k.tmsModuleId);
							} else {
								$("#ff")
										.append(
												'<input type="hidden" id="idTmsModuleTitle"  name="tmsModuleTitle"><input type="hidden" id="idTmsModuleId" name="tmsModuleId">');
								$("#ff > #idTmsModuleTitle").attr("value",
										k.tmsModuleTitle);
								$("#ff > #idTmsModuleId").attr("value",
										k.tmsModuleId);
							}

							// alert($("#idTmsModuleTitle").attr("value")+"#####%%%%%"+$("#idTmsModuleId").attr("value"));
						}
					});

}

function setModuleNameAndIdFromTab(formId) {
	$(document)
			.ready(
					function() {
						var tab = top.tabpanel.tabs('getSelected');
						tmsJ5ModuleTitle = tab.panel('options').title;
						tmsJ5ModuleId = tab.panel('options').tabId;
						if (tmsJ5ModuleTitle && tmsJ5ModuleId) {
							if (formId) {
								$('#' + formId)
										.append(
												'<input type="hidden" id="idTmsModuleTitle"  name="tmsModuleTitle"><input type="hidden" id="idTmsModuleId" name="tmsModuleId">');
								$('#' + formId).find("#idTmsModuleTitle").attr(
										"value", tmsJ5ModuleTitle);// find方式设置，只能通过find方式获取
								$('#' + formId).find("#idTmsModuleId").attr(
										"value", tmsJ5ModuleId);
							} else {
								$("#ff")
										.append(
												'<input type="hidden" id="idTmsModuleTitle"  name="tmsModuleTitle"><input type="hidden" id="idTmsModuleId" name="tmsModuleId">');
								$("#ff > #idTmsModuleTitle").attr("value",
										tmsJ5ModuleTitle);
								$("#ff > #idTmsModuleId").attr("value",
										tmsJ5ModuleId);
							}

							// alert($("#idTmsModuleTitle").attr("value")+"#####%%%%%"+$("#idTmsModuleId").attr("value"));
						}
					});

}

// 扩展tab的可用和不可以用方法
$.extend($.fn.tabs.methods, {
	disableTab : function(jq, index) {
		return jq.each(function() {
			var tab = $(this).tabs('getTab', index).panel('options').tab;
			tab.addClass('tabs-disabled').unbind('.tabs');
			tab.find('a.tabs-close').unbind('.tabs');
		});
	},
	enableTab : function(jq, index) {
		return jq.each(function() {
			var tab = $(this).tabs('getTab', index).panel('options').tab;
			tab.addClass('tabs-enabled').bind('.tabs');
			tab.find('a.tabs-close').bind('.tabs');
		});
	}
});

// 数据载入成功之后，清掉所有选中的数据
$.extend($.fn.datagrid.defaults, {
	onLoadSuccess : function(data) {
		if (data.timeout) {
			alert("未登录或登录超时，请重新登录！");
			window.location.href = getRootPath() + "/login.jsp";
		} else {
			$(this).datagrid('clearSelections');
		}
	}

});

// $.extend($.fn.datagrid.defaults.view ,{
// onAfterRender: function(target){
// if($('#'+target.id)){
// alert( $('#'+target.id).datagrid('getPanel').panel('height'));
// $('#'+target.id).datagrid('getPanel').panel('expand');
// }
// }

// });

// trim()方法
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, '');
};

(function($, undefined) {
	$.fn.isRequired = function() {
		var required;
		if (document.querySelector) {
			required = $(this).attr("required");
			if (required === undefined || required === false) {
				return undefined;
			}
			return "required";
		} else {
			required = $(this).attr("required");
			return required;
			// alert(required);
			// var outer = $(this).get(0).outerHTML, part = outer.slice(0,
			// outer.search(/\/?['"]?>(?![^<]*<['"])/));
			// return /\srequired\b/i.test(part)? "required": undefined;
		}
	};
})(jQuery);

$(function() {
	$("input[type='text'],textarea").keyup(function() {

		var str = [ '$', '%', '^', '&', '*', '<', '>', '~', '￥', '《', '》' ];
		if ($(this).attr('name') == 'AD_CONTENT') {
			// str = ['#', '$', '%', '^', '&', '*', '<',
			// '>','~','￥','《','》','（','）','(',')','?','\'','"'];
			str = [ '$', '%', '^', '&', '*', '<', '>', '~', '￥', '《', '》' ];
		}
		var id = $(this).attr("id");
		var count = 0;
		if (id == "idItemtext") {
			return;
		}
		for ( var i = 0; i < str.length; i++) {
			while ($(this).val().indexOf(str[i]) >= 0) {
				// alert("输入内容不能包含： '" + str[i] + "' 字符！");
				// alert(id);
				count++;
				$(this).val($(this).val().replace(str[i], ""));

				// return;
			}
		}
		if (count > 0) {
			alert("输入内容含有特殊字符!");
		}
	});

	// $("input[type='text'],textarea").isRequired();

});

/*
 * $(function () { $("input[type='text'],textarea").keyup(function () { var
 * rs=new RegExp("[`~%!@#^=''?~！@#￥……&——‘”“'？*()（），,。.、<> 《》]");
 * if(rs.test($(this).val())){ alert("输入内容不能包含特殊字符！"); } }); });
 */

$.fn.panel.defaults = $.extend({}, $.fn.panel.defaults, {
	onBeforeDestroy : function() {

		var frame = $('iframe', this);

		if (frame.length > 0) {

			frame[0].contentWindow.document.write('');

			frame[0].contentWindow.close();

			frame.remove();

			if ($.browser.msie) {

				CollectGarbage();

			}

		}

	}

});

$(function() {
	var colorArray = new Array();
	var tb = $(".formTable").find("tr");
	$(".formTable").find("col").each(function(i, k) {
		if ($(this).attr("class") == "leftCol") {
			colorArray.push(i);
		}
	});

	$(tb).each(
			function(p, v) {
				for ( var j = 0; j < colorArray.length; j++) {
					// alert(j+ $(".formTable
					// tr").find("td").get(colorArray[j]).innerHTML);
					// alert($(tb).eq(p).find("td").eq(colorArray[j]).html());
					var tbInner = $(tb).eq(p).find("td").eq(colorArray[j]);
					if (!$(tbInner).find("div").attr("style")) {
						$(tbInner).html(
								'<div style="text-align:right;">'
										+ tbInner.html() + "</div>");
					}
				}
			});

});

/*
 * 返回界面 @param {} dataTableId
 */
function backTable(dataTableId, actionPath) {
	var date = new Date();
	$('#' + dataTableId).datagrid('clearSelections');
	var param = "flag=" + date.getTime();
	$('#' + dataTableId).datagrid('options').url = getRootPath() + "/"
			+ actionPath + ".do?" + param;// 改变它的url
	$('#' + dataTableId).datagrid('load');
	('load');
}

$.extend($.fn.validatebox.methods, {
	remove : function(jq, newposition) {
		return jq.each(function() {
			$(this).removeClass("validatebox-text validatebox-invalid").unbind(
					'focus').unbind('blur');
		});
	},
	reduce : function(jq, newposition) {
		return jq.each(function() {
			var opt = $(this).data().validatebox.options;
			$(this).addClass("validatebox-text").validatebox(opt);
		});
	}
});