$(function() {

	$('#idRptPlancomp')
			.datagrid(
					{
						title : '任务完成情况',
						iconCls : 'icon-save',
						fit : true,
						nowrap : false,
						striped : true,
						collapsible : true,
						url : 'listRptPlancomp.do',
						sortName : 'KEYID',
						sortOrder : 'desc',
						remoteSort : false,
						idField : 'KEYID',
						pageSize : 20,
						pagination : false,
						rownumbers : true,
						toolbar : [ {
							id : 'btnexport',
							text : '导出Excel',
							iconCls : 'icon-save',
							handler : function() {
								$('#btnsave').linkbutton('enable');

								var title = escape(escape("计划代码,计划名称,任务总数,已完成数,未完成数,执行率"));
								var selectId = "listRptPlancomp";
								var time = $("#idEndDate").val() + " 23:59:59";
								var beginDate = $("#idBeginDate").val();
								if (beginDate != "") {
									beginDate = beginDate + " 00:00:00";
								}
								var plancode = $("#idPlanCode").val();
								if (plancode == "") {
									plancode = "";
								}
								var queryInfo = "{'planCode':'" + plancode
										+ "','regentirId':'"
										+ $("#idRegEntireId").val()
										+ "','beginDate':'" + beginDate
										+ "','endDate':'" + time + "'}";
								var sqlcols = "PLAN_CODE,PLAN_NAME,ALLCOUNT,COMPLET,UNCOMPLET,RATE";
								var filename = "plancomplete";
								exportExcel(title, selectId, queryInfo,
										sqlcols, filename);
							}
						} ],
						columns : [ [ {
							title : ' ',
							field : 'DESC',
							align : 'center',
							width : 200,
							sortable : true
						}, {
							title : '计划代码',
							field : 'PLAN_CODE',
							align : 'center',
							width : 100,
							sortable : true
						}, {
							title : '计划名称',
							field : 'PLAN_NAME',
							align : 'center',
							width : 100,
							sortable : true
						}, {
							title : '任务总数',
							field : 'ALLCOUNT',
							align : 'center',
							width : 100,
							sortable : true
						}, {
							title : '已完成的',
							field : 'COMPLET',
							align : 'center',
							width : 100,
							sortable : true
						}, {
							title : '未完成',
							field : 'UNCOMPLET',
							align : 'center',
							width : 100,
							sortable : true
						}, {
							title : '执行率',
							field : 'RATE',
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
	var title = escape(escape("计划代码,计划名称,任务总数,已完成数,未完成数,执行率"));
	var selectId = "listRptPlancomp";
	var time = $("#idEndDate").val() + " 23:59:59";
	if ($("#idEndDate").val() == "") {
		time = "";
	}
	var beginDate = $("#idBeginDate").val();
	if (beginDate != "") {
		beginDate = beginDate + " 00:00:00";
	}
	var plancode = $("#idPlanCode").val();
	if (plancode == "") {
		plancode = "";
	}
	var queryInfo = "{'planCode':'" + plancode + "','regentirId':'"
			+ $("#idRegEntireId").val() + "','beginDate':'" + beginDate
			+ "','endDate':'" + time + "'}";
	var sqlcols = "PLAN_CODE,PLAN_NAME,ALLCOUNT,COMPLET,UNCOMPLET,RATE";
	var filename = "plancomplete";
	exportExcel(title, selectId, queryInfo, sqlcols, filename);
}