	$(function(){
		  var k=window.dialogArguments; 
		  var param=k.par;
		  if(!param){
		  	msgShow("统计明细","传递参数为空!","error");
		  	return;
		  }
		  var reg_name = param.REG_NAME;
		  var mid_name = param.MID_NAME;
		  
		$('#idRptAposModelDetail').datagrid({
				title:'统计明细',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listRptAposModelDetail.do',
				queryParams:param,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                //{field:'ck',checkbox:false},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
							{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true},
							{title:'装机时间',field:'CREATE_POS_TIME',align:'center',width:150,sortable:true},
							{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:100,sortable:true},
							{title:'终端型号',field:'MID_NAME',align:'center',width:100,sortable:true,
								formatter:function(value,rowData,rowIndex) {
									return mid_name;
								}
							},
							{title:'主应用商户',field:'MERCH_ID',align:'center',width:100,sortable:true},
							{title:'主应用终端号',field:'TERMINAL_ID',align:'center',width:100,sortable:true},
							{title:'分支机构',field:'REG_NAME',align:'center',width:200,sortable:true,
								formatter:function(value,rowData,rowIndex) {
									return reg_name;
								}
							}
								]]
				});
		});

		function doExportForModel(){
		  var k=window.dialogArguments; 
		  var param=k.par;
		  if(!param){
		  	msgShow("统计明细","传递参数为空!","error");
		  	return;
		  }
		  
    	  var param1='isExport=1&REGID='+param.REG_ID+'&BEGINDATE='+param.BEGIN_DATE+'&ENDDATE='+param.END_DATE+'&REGNAME='+escape(escape(param.REG_NAME))+'&MID='+param.MID+'&MIDNAME='+escape(escape(param.MID_NAME));
		  window.open(getRootPath()+"/listRptAposModelDetail.do?"+param1);
		}