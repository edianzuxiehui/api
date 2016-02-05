	$(function(){
		
			$('#idPosUploadErrorList').datagrid({
				//title:'预警信息',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listPosUploadErrorList.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:10,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                //{field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true},
			{title:'发生日期',field:'OCCUR_DATE',align:'center',width:180,sortable:true},
			{title:'主应用商户号',field:'MERCH_ID',align:'center',width:120,sortable:true,
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
			{title:'主应用商户名称',field:'MERCH_NAME',align:'center',width:120,sortable:true},
			{title:'主应用终端',field:'TERMINAL_ID',align:'center',width:70,sortable:true,
				styler:function(value,rowData,rowIndex){
					if(value!=null && value.length!=8) {
						return 'color:#ccc;';
					}
				}
			},
			{title:'异常信息说明',field:'DESC_TXT',align:'center',width:100,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:200,sortable:true},
			{title:'详细信息',field:'FUNCTION',align:'center',width:100,sortable:true,
					formatter:function(value,rowData,rowIndex){ 
                       // var a='<a style=\'color:red\'   href="javascript:showDetail(\''+ rowData.SYS_ID+ '\')">详细信息</a>'
                        var a='<input type="button" class="btn_grid" value=" 详 情 " onclick="showDetail(\''+ rowData.ONLINE_ID+ '\')"/>';
                        return a;  
                    }
			},
			{title:'变更基准信息',field:'FUNCTION1',align:'center',width:150,sortable:false,
				formatter:function(value,rowData,rowIndex){
					var param = "{APOS_ID:"+rowData.APOS_ID+",MERCH_ID:"
								+rowData.MERCH_ID+",TERMINAL_ID:"+rowData.TERMINAL_ID+"}";
					var a='<input type="button" class="btn_grid" value="变更基准信息" onclick="updateTel(\''+ param +'\',\''+ rowData.ONLINE_ID +'\',\''+rowData.MERCH_NAME+'\')"/>';
					return a;
				}
			}
				]]
			});
	
		});
		
		function updateTel(param,ONLINE_ID,merchName){
			param=eval('(' +param+')');
			param.MERCH_NAME=merchName;
			param.ONLINE_ID=ONLINE_ID;
			var retValue=openDialogFrame(getRootPath()+"/core/posuploaderrorlist/AposInfo-edit.jsp",param,"350","240");
			if(retValue=="true"){
				msgShow("修改","修改成功!","info");
				flashTable("idAppInfo");
			}else if(retValue=="false"){
		       msgShow("修改","修改失败!","error");
		    }
		}
		
		function showDetail(ONLINE_ID){
			var retValue=openDialogFrame(getRootPath()+"/core/posuploaderrorlist/PosUploadErrorList-info.jsp","SYS_ID="+ONLINE_ID,"650","460");
		}
		
	
	function viewMerchInfo(merchId) {
		var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/MerchInfo-view.jsp","MERCH_ID="+merchId,"600","260");
	}
