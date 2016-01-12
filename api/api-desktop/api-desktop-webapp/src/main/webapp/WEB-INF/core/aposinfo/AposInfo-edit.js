//分配报到策略
function addStrategy() {
	var aposList = $('#idAposId').val();
	if(aposList=="") {
		msgShow("提示消息","请先添加应用终端","info");
		return false;
	}
	var retValue = openDialogFrame(getRootPath()+'/core/aposinfo/Strategy-query.jsp','','850','400');
	if(retValue!=undefined) {
		var tmsModuleId = window.dialogArguments.tmsModuleId;
		var tmsModuleTitle = window.dialogArguments.tmsModuleTitle;
		
		$.getJSON("addStrategyAposBind.do",
			{APOS_ID:aposList,STRATEGY_ID:retValue, tmsModuleId:tmsModuleId, tmsModuleTitle:escape(tmsModuleTitle)},
			function(data) {
				if (null != data && null != data.status && "" != data.status&&data.status=="true") {
					msgShow('提示消息',data.message,'info');
					$('#idStrategyId').val(retValue);
					$('#idFlag').val('true');
				} else {
					if(data.message==null || data.message=="") {
						msgShow('提示消息',"策略分配失败",'warning');
					}else{
						msgShow('提示消息',data.message,'warning');
					}
				}
			});
		
	}
}

//选择报到策略
function selectStrategy() {
	var retValue = openDialogFrame(getRootPath()+'/core/aposinfo/Strategy-query.jsp','','800','300');
	if($('#idStrategyId').val()==""){
		if(retValue!=undefined) {
			$('#idStrategyId').val(retValue);
		}
	}else{
		if($('#idStrategyId').val()==retValue){
			$('#idStategyTag').val("same");
		}else{
			$('#idStategyTag').val("undif");
			if(retValue!=undefined) {
				$('#idStrategyId').val(retValue);
			}
		}
		
	}
}

//返回
function doBack() {
	if(validateApos()!='true') return false;
	
	if($('#idFlag').val()=='true') {
		window.returnValue='true';
	}
	$('#idIsCheck').val('false');
	window.close();
}

//修改应用终端
function updateApos() {
	$('#ff').form('submit',{
        url:'updateAposInfo.do',
	    onSubmit:function(){
	        return $(this).form('validate');
	    },
	    success:function(data){
	    	var myObject = eval('(' + data + ')');
	    	
	       	if(myObject.status=="true"){
	       		msgShow("信息提示","修改成功","info");
				$('#idFlag').val("true");
				$('#idNextSignTime').val(myObject.NEXT_SIGN_TIME);
				//$('#btnStraSel').hide();
				$('#btnStraClr').hide();
				//$('#btnUpdateApos').attr('disabled',true);
	        }else if(myObject.status=="false"){
	        	msgShow("信息提示",myObject.message,"error");
	        	
	        }
	    }
	});
}

$(function(){
	setModuleNameAndId();

	//获取参数
	var k=window.dialogArguments;
	var param = k.par;
	
	$.getJSON("queryAposInfo.do",param,function(data){
		$.each(data.rows,function(idx,item){
			$('#idAposId').val(item.APOS_ID);
			$('#idRegId').val(item.REG_ID);
			$('#idRegEntireId').val(item.REG_ENTIRE_ID);
			$('#idRegName').val(item.REG_NAME);
			$('#idStrategyId').val(item.STRATEGY_ID);
			$('#idNextSignTime').val(item.NEXT_SIGN_TIME);
			
			if(item.STRATEGY_ID==null) {
				$('#btnStraSel').show();
				$('#btnStraClr').show();
			}else{
				$('#btnStraSel').show();
				//$('#btnStraSel').hide();
				$('#btnStraClr').hide();
				$('#btnUpdateApos').attr('disabled',false);
			}
			
			//加载应用终端应用明细
			$('#idAposAppInfo').datagrid({
				url:"listAposAppInfo.do?APOS_ID="+item.APOS_ID,
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:false,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				rownumbers:true,
				//pagination:true,
				//pageSize:10,
				frozenColumns:[[
			              {field:'ck',checkbox:true},
			              {field:'FIELDS',title:'FIELDS',hidden:true},
			              {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
					{title:'应用编号',field:'APP_ID',align:'center',width:80,sortable:true},
					{title:'应用名称',field:'APP_NAME',align:'center',width:120,sortable:true,
						formatter:function(value,rowData,rowIndex) {
							if(rowData.MASTER_APP_FLAG=='1') {
								return value+'(主应用)';
							}else{
								return value;
							}
						}
					},
					{title:'应用版本',field:'APP_VER',align:'center',width:80,sortable:true},
					{title:'应用参数',field:'PARAM_MODEL_ID',align:'center',width:100,sortable:true,
						formatter:function(value,rowData,rowIndex) {
							return '<input type="button" class="btn_grid" onclick="setupAppParam(\''+rowData.APOS_ID+'\',\''+rowData.APP_ID+'\')" value="参数设置"/>';
						}
					},
					{title:'商户',field:'MERCH_ID',align:'center',width:260,sortable:true,
						styler:function(value,rowData,rowIndex){
							if(value!=null && value.length<15) {
								return "color:#ccc;";
							}
						},
						formatter:function(value,rowData,rowIndex) {
							var retString;
							if(rowData.MERCH_NAME!=null) 
								retString = rowData.MERCH_NAME+"("+rowData.MERCH_ID+")";
							else
								retString = rowData.MERCH_ID;
							if(rowData.APP_ID!=null && rowData.APP_ID!='00000000') {
								retString += "&nbsp;&nbsp;";
								retString += "<a href='javascript:void(0)' style='color:blue;' onclick='modifyMerchId(\""+rowData.APOS_ID+"\",\""+rowData.APP_ID+"\",\""+rowData.TERMINAL_ID+"\")'>修改</a>";
							}
							return retString;
						}
					},
					{title:'终端号',field:'TERMINAL_ID',align:'center',width:100,sortable:true,
						formatter:function(value,rowData,rowIndex) {
							var retString="";
							if(value!=null) retString += value;
							if(rowData.APP_ID!=null && rowData.APP_ID!='00000000') {
								retString += "&nbsp;&nbsp;";
								retString += "<a href='javascript:void(0)' style='color:blue;' onclick='modifyTerminalId(\""+rowData.APOS_ID+"\",\""+rowData.APP_ID+"\",\""+rowData.MERCH_ID+"\",\""+value+"\")'>修改</a>";
							}
							return retString;
						}
					},
					{title:'操作',field:'SYS_ID',width:100,
						formatter:function(value,rowData,rowIndex) {
							if(rowData.APP_ID!=null && rowData.APP_ID=='00000000') {
								return '<input type="button" class="btn_grid" onclick="editAposAppInfo(\''+rowData.APOS_ID+'\',\''+rowData.APP_ID+'\')" value="修改"/>';
							}else{
								var retString = '<input type="button" class="btn_grid" style="margin-right:2px;" onclick="editAposAppInfo(\''+rowData.APOS_ID+'\',\''+rowData.APP_ID+'\')" value="修改"/>';
								retString += '<input type="button" class="btn_grid" onclick="delAposAppInfo(\''+rowData.APOS_ID+'\',\''+rowData.APP_ID+'\')" value="删除"/>';
								return retString;
							}
						}
					}
				]]
			});
		});
	});
});