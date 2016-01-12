	function viewAposDetail(aposId,dataSource) {
		//参数t指示不显示APMS信息
		if(dataSource=='1')//本系统
			var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposInfo-view.jsp","APOS_ID="+aposId+"&t=1","850","350");
		if(dataSource=='2')//APMS
			var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposInfo-view.jsp","APOS_ID="+aposId,"850","350");
	}
	
	function viewMerchInfo(merchId) {
		var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/MerchInfo-view.jsp","MERCH_ID="+merchId,"600","260");
	}
	
	$(function(){
		
			$('#idAposInfo').datagrid({
				//title:'应用终端管理',
				//iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAposInfo.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:10,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用终端号',field:'APOS_ID',align:'center',width:150,sortable:true},
			{title:'主应用商户号',field:'MERCH_ID',align:'center',width:150,sortable:true,
				formatter:function(value,rowData,rowIndex) {
					if(value==null) {
						return "";
					}else if(rowData.MERCH_ID!=null && rowData.MERCH_ID=="T"+rowData.APOS_ID){
						return '<div style="color:red;">商户未配置</div>';
					}else{
						return '<a href="javascript:void(0)" onclick="viewMerchInfo(\''+rowData.MERCH_ID+'\')" style="color:blue;">'+value+'</a>';
					}
				}
			},
			{title:'主应用商户名',field:'MERCH_NAME',align:'center',width:150,sortable:true,
				styler:function(value,rowData,rowIndex){
					if(rowData.MERCH_ID!=null && rowData.MERCH_ID=="T"+rowData.APOS_ID) {
						return 'color:#ccc;';
					}
				},
				formatter:function(value,rowData,rowIndex) {
					if(value==null) {
						return "";
					}else{
						return '<a href="javascript:void(0)" onclick="viewMerchInfo(\''+rowData.MERCH_ID+'\')" style="color:blue;">'+value+'</a>';
					}
				}
			},
			{title:'主应用终端',field:'TERMINAL_ID',align:'center',width:100,sortable:true,
				styler:function(value,rowData,rowIndex){
					if(value!=null && value.length!=8) {
						return 'color:#ccc;';
					}
				},
				formatter:function(value,rowData,rowIndex) {
					if(value==null||value=="") {
						return '<div style="color:red;">终端号未配置</div>';
					}else{
						return value;
					}
				}
			},
			{title:'生成时间',field:'INPUT_TIME',align:'center',width:150,sortable:true},
			{title:'主机型号',field:'MID',align:'center',width:150,sortable:true,hidden:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:150,sortable:true,hidden:true},
			//{title:'APMS建议的厂商',field:'APMS_FACTORY',align:'center',width:100,sortable:true},
			//{title:'APMS建议的型号',field:'APMS_MID',align:'center',width:100,sortable:true},
			//{title:'APMS建议的序列号',field:'APMS_SERIALNO',align:'center',width:110,sortable:true},
			//{title:'数据来源',field:'DATA_SOURCE',align:'center',width:55,sortable:true,
			//	formatter:function(value,rowData,rowIndex) {
			//		if(value=='1') {
			//			return '本系统';
			//		}else if(value=='2') {
			//			return 'APMS';
			//		}else{
			//			return '';
			//		}
			//	}
			//},
			{title:'明细',field:'DETAIL',align:'center',width:100,sortable:true,
				formatter:function(value,rowData,rowIndex) {
					return '<input type="button" class="btn_grid" value="明细" onclick="viewAposDetail(\''+rowData.APOS_ID+'\',\''+rowData.DATA_SOURCE+'\')"/>';
				}
			},
			{title:'装机状态',field:'COMPLET_FLAG',align:'center',width:100,sortable:true,
				formatter:function(value,rowData,rowIndex) {
					if(value=='0') {
						return "未完成";
					}else if(value=='1') {
						return "完成";
					}else{
						return "补登状态";
					}
				}
			},
			{title:'单位编码',field:'REG_ID',align:'center',width:100,sortable:true,hidden:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:250,sortable:true},
			{title:'布放地址',field:'APOS_ADDR',align:'center',width:140,sortable:true,hidden:true},
			{title:'策略ID',field:'STRATEGY_ID',align:'center',width:100,sortable:true,hidden:true}
				]],
			rowStyler:function(rowIndex,rowData) {
				if(rowData.STRATEGY_ID==null) {
					return 'color:#0000CD;';
				}
				if(rowData.MERCH_ID==null) {
					return 'color:#FF3030;';
				}
			}
			});
			
			//defaultQueryReg();//初始化分支机构
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
		});
		
