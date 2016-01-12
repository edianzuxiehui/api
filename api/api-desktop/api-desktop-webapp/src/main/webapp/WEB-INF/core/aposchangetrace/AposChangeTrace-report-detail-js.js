	$(function(){
		  var k=window.dialogArguments; 
		  var param=k.par;
		  if(!param){
		  	msgShow("统计明细","传递参数为空!","err");
		  	return;
		  }

			var queryFlag = param.queryFlag;//alert(queryFlag);
			var colName ='';
			if(queryFlag=='init'){
				colName = '装机时间';
			}else if(queryFlag=='change'){
				colName = '换机时间';
			}else if(queryFlag=='recycle'){
				colName = '撤机时间';
			}
			
			//$('#idQueryFlag').val(param.queryFlag);
			//$('#idRegEntireId').val(param.REG_ID);
			//$('#idBeginDate').val(param.BEGIN_DATE);
			//$('#idEndDate').val(param.END_DATE);
			//$('#idRegName').val(param.REG_NAME);
			  
		//alert(queryFlag);
		$('#idAposChangeTraceReportDetail').datagrid({
				//title:'明细查询',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAposChangeTraceReportDetail.do',
				queryParams:param,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[	
				          	{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true},
							{title:colName,field:'CREATE_DATE',align:'center',width:130,sortable:true},
							{title:'硬件序列号',field:'OLD_SERIAL_NO',align:'center',width:140,sortable:true},
							{title:'主机型号',field:'OLD_MID',align:'center',width:100,sortable:true},
							{title:'主应用商户',field:'MERCH_ID',align:'center',width:100,sortable:true},
							{title:'主应用终端号',field:'TERMINAL_ID',align:'center',width:100,sortable:true},
							{title:'分支机构',field:'REG_NAME',align:'center',width:186,sortable:true}
								]]
				});
		});
