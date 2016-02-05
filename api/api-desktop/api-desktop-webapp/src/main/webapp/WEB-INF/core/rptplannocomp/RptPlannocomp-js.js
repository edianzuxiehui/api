$(function() {

	$('#idRptPlannocomp')
			.datagrid(
					{
						title : '任务过期统计报表',
						iconCls : 'icon-save',
						fit : true,
						nowrap : false,
						striped : true,
						collapsible : true,
						url : 'listRptPlannocomp.do',
						sortName : 'KEYID',
						sortOrder : 'desc',
						remoteSort : false,
						idField : 'KEYID',
						pageSize : 20,
						pagination : false,
						rownumbers : false,
						toolbar : [ {
							id : 'btnexport',
							text : '导出Excel',
							iconCls : 'icon-save',
							handler : function() {
								$('#btnsave').linkbutton('enable');

								var title = escape(escape("计划名称,应用终端号,主应用商户号,终端号,硬件系列号,终端型号,联系人,联系电话"));
								var selectId = "listRptPlannocomp";
								var time = $("#idValidDate").val()
										+ " 23:59:59";
								if ($("#idValidDate").val() == "") {
									time = "";
								}
								var plancode = $("#idPlanCode").val();
								if (plancode == "") {
									plancode = "";
								}
								var queryInfo = "{'planCode':'" + plancode
										+ "','regentirId':'"
										+ $("#idRegEntireId").val()
										+ "','validDate':'" + time + "'}";
								var sqlcols = "PLAN_NAME,APOS_ID,MERCHID,TERMINAL_ID,MID_NAME,SERIAL_NO,CONNECTER,OPER_CALLNO";
								var filename = "plannocomplete";
								exportExcel(title, selectId, queryInfo,
										sqlcols, filename);
							}
						} ],
						columns : [ [ {
							title : '计划名称',
							field : 'PLAN_NAME',
							align : 'center',
							width : 100,
							sortable : true
						}, {
							title : '应用终端号',
							field : 'APOS_ID',
							align : 'center',
							width : 100,
							sortable : true
						}, {
							title : '主应用商户号',
							field : 'MERCHID',
							align : 'center',
							width : 100,
							sortable : true
						}, {
							title : '终端号',
							field : 'TERMINAL_ID',
							align : 'center',
							width : 100,
							sortable : true
						}, {
							title : '终端型号',
							field : 'MID_NAME',
							align : 'center',
							width : 100,
							sortable : true
						}, {
							title : '硬件系列号',
							field : 'SERIAL_NO',
							align : 'center',
							width : 100,
							sortable : true
						}, {
							title : '联系人',
							field : 'CONNECTER',
							align : 'center',
							width : 100,
							sortable : true
						}, {
							title : '联系电话',
							field : 'OPER_CALLNO',
							align : 'center',
							width : 100,
							sortable : true
						} ] ]
					});

});

/*
 * 输入参数为表头title,查询的id,页面参数,queryInfo,sql取值的
 */

function exportExcel(title, selectId, queryInfo, sqlcols, filename) {
	var param = {
		'title' : title,
		'selectId' : selectId,
		'queryInfo' : queryInfo,
		'sqlcols' : sqlcols,
		'filename' : filename
	};
	// var param={'title':title,'selectId':selectId,'queryInfo':queryInfo};
	// var str = JSON.stringify(param);
	var param = "title=" + title + "&selectId=" + selectId + "&queryInfo="
			+ queryInfo + "&sqlcols=" + sqlcols + "&filename=" + filename

	window.open(getRootPath() + "/exportexcel.do?" + param);

}

function initDataForAppInfo(param) {
	$.ajax({
		type : "POST",
		url : "initDataForAppInfo.do",
		data : "param=" + param, // idOrgId,idMerchStatus
		success : function(data) {
			if (data.idRegId) {
				var str = data.idRegId.split("(");
				$("#idRegId").val(str[1].substring(0, str[1].length - 1));
				$("#idRegName").val(data.idRegId);

			}
			if (data.idAppId) {
				$("#idAppId").val(data.idAppId);

			}
			if (data.idRegEntireId) {
				$("#idRegEntireId").val(data.idRegEntireId);

			}
		}
	});

}

function doexport() {
	var title = escape(escape("计划名称,应用终端号,主应用商户号,终端号,终端型号,硬件系列号,联系人,联系电话"));
	var selectId = "listRptPlannocomp";
	var time = $("#idValidDate").val() + " 23:59:59";
	if ($("#idValidDate").val() == "") {
		time = "";
	}
	var plancode = $("#idPlanCode").val();
	var queryInfo = "{'planCode':'" + plancode + "','regentirId':'"
			+ $("#idRegEntireId").val() + "','validDate':'" + time + "'}";
	var sqlcols = "PLAN_NAME,APOS_ID,MERCHID,TERMINAL_ID,MID_NAME,SERIAL_NO,CONNECTER,OPER_CALLNO";
	var filename = "plannocomplete";
	exportExcel(title, selectId, queryInfo, sqlcols, filename);
}
