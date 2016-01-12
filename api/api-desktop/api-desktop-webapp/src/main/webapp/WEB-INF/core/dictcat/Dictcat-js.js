$(function() {

	$('#idDictcat').datagrid({
		title : '数据字典大项',
		iconCls : 'icon-save',
		fit : true,
		nowrap : false,
		striped : true,
		collapsible : true,
		url : 'listDictcat.do',
		sortName : 'KEYID',
		sortOrder : 'desc',
		remoteSort : false,
		idField : 'KEYID',
		pageSize : 20,
		pagination : true,
		rownumbers : true,
		onClickRow : genDictItem,
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
			title : '数据大项编码',
			field : 'CATCODE',
			align : 'center',
			width : 180,
			sortable : true
		}, {
			title : '数据大项内容',
			field : 'CATTEXT',
			align : 'center',
			width : 180,
			sortable : true
		} ] ]
	});

	$(".import_toolbar").attr('disabled', true);
	$(".export_toolbar").attr('disabled', true);
});

function genDictItem(rowIndex, rowData) {
	$('#idDictcat').datagrid("clearSelections");
	$('#idDictcat').datagrid('selectRow', rowIndex);

	$('#idDictitem').datagrid({
		title : rowData.CATTEXT,
		iconCls : 'icon-save',
		fit : true,
		nowrap : false,
		striped : true,
		collapsible : true,
		url : 'listDictitem.do?CATCODE=' + escape(escape(rowData.CATCODE)),
		sortName : 'KEYID',
		sortOrder : 'desc',
		remoteSort : false,
		idField : 'KEYID',
		pageSize : 20,
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
			title : '数据大项编码',
			field : 'CATCODE',
			align : 'center',
			width : 180,
			sortable : true,
			hidden : true
		}, {
			title : '数据细项编码',
			field : 'ITEMCODE',
			align : 'center',
			width : 160,
			sortable : true
		}, {
			title : '数据细项内容',
			field : 'ITEMTEXT',
			align : 'center',
			width : 165,
			sortable : true,
			formatter : function(value, row, index) {
				return unescape(value);
			}
		} ] ],
		toolbar : [ {
			text : "增加",
			iconCls : 'icon-add',
			handler : addDictItem
		}, {
			text : "修改",
			iconCls : 'icon-edit',
			handler : updateDictItem
		}, {
			text : "删除",
			iconCls : 'icon-remove',
			handler : delDictItem
		} ]
	});

	var selected = $('#idDictitem').datagrid('getSelected');
	if (selected) {
		$('#idDictitem').datagrid("clearSelections");
	}
}

function addDictItem() {
	var tt = $('#idDictcat').datagrid('getSelected');
	var retValue = openDialogFrame(getRootPath()
			+ "/core/dictcat/Dictitem-add.jsp?CATCODE="
			+ escape(escape(tt.CATCODE)), "", "350", "180");
	if (retValue == "true") {
		msgShow("新增", "新增成功!", "info");
		flashTable("idDictitem");
	} else if (retValue == "false") {
		msgShow("新增", "新增失败!", "error");
	}
}

function updateDictItem() {

	var ids = updateValidate("idDictitem");
	if (ids) {
		var retValue = openDialogFrame(getRootPath()
				+ "/core/dictcat/Dictitem-edit.jsp", ids, "350", "180");
		if (retValue == "true") {
			msgShow("修改", "修改成功!", "info");
			flashTable("idDictitem");
		} else if (retValue == "false") {
			msgShow("修改", "修改失败!", "error");
		}
	}
}
function delDictItem() {
	deleteNoteById("idDictitem", "delDictitem.do", "");

}

function deleteById(dataTableId, requestURL, confirmMessage) {
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
				for (var i = 0; i < num; i++) {
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
						$('#idDictitem').datagrid('getPanel').panel('close');

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