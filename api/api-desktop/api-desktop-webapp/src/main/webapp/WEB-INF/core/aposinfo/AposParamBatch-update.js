var lastIndex;
var validParamValueFlag = true;// 用于防止一行编辑验证值有问题，点击其他行，出现2行可编辑
$(function() {

	var k = window.dialogArguments;
	var param = k.par;
	if (param) {
		// alert(param);
	} else {
		msgShow("参数模板", "传递参数为空!", "err");
		return;
	}
	setModuleNameAndId();
	$('#idBatchParamModelDetail').datagrid(
			{
				title : '批量参数修改',
				iconCls : 'icon-save',
				fit : true,
				nowrap : false,
				striped : true,
				collapsible : true,
				url : 'listAppBatchParamsValue.do',
				queryParams : param,
				sortName : 'KEYID',
				sortOrder : 'asc',
				singleSelect : true,
				remoteSort : false,
				idField : 'KEYID',
				pageSize : 15,
				pagination : true,
				rownumbers : true,
				frozenColumns : [ [ {
					field : 'ck',
					checkbox : true
				}, {
					field : 'FIELDS',
					title : 'FIELDS',
					hidden : true
				}, {
					title : 'KEYID',
					field : 'KEYID',
					hidden : true
				} ] ],
				columns : [ [ {
					title : '应用名称',
					field : 'APP_NAME',
					align : 'center',
					width : 80,
					sortable : true
				}, {
					title : '参数项编号',
					field : 'PARAM_ID',
					align : 'center',
					width : 80,
					sortable : true
				}, {
					title : '参数名称',
					field : 'PARAM_NAME',
					align : 'center',
					width : 180,
					sortable : true
				}, {
					title : '参数类型',
					field : 'DATA_TYPE',
					align : 'center',
					width : 80,
					sortable : true
				}, {
					title : '参数长度',
					field : 'VALUE_LEN',
					align : 'center',
					width : 80,
					sortable : true
				}, {
					title : '参数值',
					field : 'PARAM_VALUE',
					align : 'center',
					width : 203,
					editor : "text"
				}, {
					title : '参数模版',
					field : 'DEF_VALUE',
					align : 'center',
					width : 203,
					sortable : true
				}, {
					title : '备注',
					field : 'DESC_TXT',
					align : 'center',
					width : 203,
					sortable : true
				} ] ],
				toolbar : [ {
					id : 'btnBatchSaveParamValueDetail',
					text : '批量保存',
					iconCls : 'icon-ok',
					handler : function() {
						$('#idBatchParamModelDetail').datagrid('endEdit',
								lastIndex);
						btnBatchSaveParamValue(param);
					}
				} ],
				onClickCell : function(rowIndex, field, value) {
					// alert('onDblClickCell' + lastIndex);
					// alert(rowIndex);
					$('#idBatchParamModelDetail')
							.datagrid('endEdit', lastIndex);
					if (field == 'PARAM_VALUE'
							&& (validParamValueFlag || rowIndex == lastIndex)) {// rowIndex==lastIndex用于防止编辑一行有问题，直接点另一行删除时，出现不能继续编辑的bug
						$('#idBatchParamModelDetail').datagrid('beginEdit',
								rowIndex);
						lastIndex = rowIndex;
						$(".datagrid-editable-input").off();
						$(".datagrid-editable-input").keydown(
								function(e) {
									if (e.which == 13) {
										$('#idBatchParamModelDetail').datagrid(
												'endEdit', rowIndex);
									}
								});
					}
				},
				onAfterEdit : function(rowIndex, rowData, changes) {// 参数值修改退出时,要能自动提交,不需点击更新按钮,只有一行数据时点其他列提交
					var paramValue = Trim(rowData.PARAM_VALUE);
					if (paramValue == "") {
						return true;
					}

					if (validParamValue(rowData, rowIndex)) {// alert('commit:'+rowIndex);
					}
				}
			});

});
// 批量保存修改数据
function btnBatchSaveParamValue(queryParam) {
	var obj = new Object();
	var rows = $('#idBatchParamModelDetail').datagrid('getRows');
	var num = rows.length;
	// alert('记录数是'+num);
	var ids = null;
	var fields = null;
	if (num < 1) {
		msgShow('提示消息', '无记录需要保存!', 'info');
	} else {

		$.messager.confirm('确认', '是否保存修改数据？',
				function(r) {
					// alert('choose result is '+r);
					if (r) {
						for ( var i = 0; i < num; i++) {
							// alert('row is '+rows[i]);
							if (null == ids || i == 0) {
								if (validPostParamValue(rows[i])) {

									ids = $.trim(rows[i].PARAM_ID);
									fields = $.trim(rows[i].PARAM_VALUE);
								}
							} else {
								if (validPostParamValue(rows[i])) {
									ids = $.trim(ids) + "]]"
											+ $.trim(rows[i].PARAM_ID);
									fields = $.trim(fields) + "]]"
											+ $.trim(rows[i].PARAM_VALUE);
								}
							}
						}
						// alert('cycle result ids '+ids);
						// alert('cycle result fields '+fields);
						if ($.trim(ids) == "") {
							msgShow('提示消息', '无修改数据记录需要保存!', 'info');
							return;
						}

						obj.PARAM_IDS = ids; // 被修改的数据ID集合 "]]"分割
						obj.PARAM_VALUES = fields; // 被修改的数据值集合 ']]"分割
						// obj.tmsModuleId=tmsModuleId;
						// obj.tmsModuleTitle=tmsModuleTitle;
						// alert('setup two ');
						var obj2 = $.extend({}, queryParam, obj);
						// alert('setup two 2 '+obj2);
						// printObject(obj2); //打印出提交参数
						// alert('setup three ');
						$.post('updateBatchParamValues.do', obj2,
								function(data) {
									// alert(data);
									// alert(data[message]);
									// alert(data.status);
									// alert(data.updateRow);
									// msgShow("提示消息",
									// "批量修改成功,更新"+data.updateRow+"条数据",
									// "info");
									var obj3 = eval('(' + data + ')');
									// alert(obj3.status);
									if (obj3.status && obj3.status == "true") {
										var fullmessage = obj3.message + ",更新"
												+ obj3.updateRow + "条数据！";
										// alert(fullmessage);
										msgShow("提示消息", fullmessage, "info");
									} else {
										msgShow("提示消息", obj3.message, "info");
									}

								});

					}
				});
	}
}

function printObject(obj) {
	var temp = "";
	for ( var i in obj) {// 用javascript的for/in循环遍历对象的属性
		temp += i + ":" + obj[i] + "\n";
	}
	alert(temp);// 结果：cid:C0 \n ctext:区县
}

function validPostParamValue(data) {
	if ($.trim(data.PARAM_VALUE) == "") {
		return false;
	} else {
		return true;
	}
}

function validParamValueFail(rowIndex) {
	// alert(lastIndex+","+rowIndex);
	$('#idBatchParamModelDetail').datagrid('endEdit', lastIndex);
	$('#idBatchParamModelDetail').datagrid('beginEdit', rowIndex);
	lastIndex = rowIndex;
	validParamValueFlag = false;
}
// 验证参数值
function validParamValue(rowData, rowIndex) {
	// 参数配置中不允许配置商户号、终端号
	if (rowData.PARAM_ID == "01000001" || rowData.PARAM_ID == "01000005") {
		msgShow("参数模板明细", "终端号、商户号请在应用里修改!", "info");
		validParamValueFail(rowIndex);
		return false;
	}
	// alert("paramValue="+form1.param_Value.value);
	var paramValue = Trim(rowData.PARAM_VALUE);
	if (paramValue == "" && rowData.PARAM_ID != "16000006"
			&& rowData.PARAM_ID != "16000007") {
		msgShow("参数模板明细", "参数值不能为空", "info");
		validParamValueFail(rowIndex);
		return false;
	}
	var i = paramValue.indexOf("]]");
	if (i > -1) {
		msgShow("参数模板明细", "不能输入]]字符", "info");
		validParamValueFail(rowIndex);
		return false;
	}
	var j = paramValue.indexOf("[]");
	if (j > -1) {
		msgShow("参数模板明细", "不能输入[]字符", "info");
		validParamValueFail(rowIndex);
		return false;
	}
	var k = paramValue.indexOf("{}");
	if (k > -1) {
		msgShow("参数模板明细", "不能输入{}字符", "info");
		validParamValueFail(rowIndex);
		return false;
	}
	var len = rowData.VALUE_LEN;
	// alert(paramValue);alert(paramValue.length);alert(rowData.VALUE_LEN);alert(getMaxLength(rowData.PARAM_VALUE));
	if (getMaxLength(paramValue) > len) {// 注意这里paramValue不能用rowData.PARAM_VALUE代替!!!!
		msgShow("参数模板明细", "参数值长度不能大于参数长度！", "info");
		validParamValueFail(rowIndex);
		return false;
	}

	var type = rowData.DATA_TYPE;
	if (type == "数字") {
		if (!(/^\d+(\.\d+)?$/i.test(paramValue))) {
			msgShow("参数模板明细", "参数值请输入数字", "info");
			validParamValueFail(rowIndex);
			return false;
		}
	}
	if (rowData.PARAM_ID == "12000017") {
		if (paramValue.length < 10) {
			msgShow("参数模板明细", "TPDU参数必须大于等于10位", "info");
			validParamValueFail(rowIndex);
			return false;
		}
	}
	validParamValueFlag = true;
	return true;
}
