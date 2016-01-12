	$(function(){
		  var k=window.dialogArguments; 
		  var param= null;
		  if(k.par){
		  	param=k.par;
		  	$('#idStrategyId').val(param.STRATEGY_ID);
          }else{
         	return ;
          }		
			$('#idStrategyDist').datagrid({
				title:'已分配策略应用终端',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'strategyDist.do',
				queryParams:param,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用终端编号',field:'APOS_ID',align:'center',width:80,sortable:true,
				formatter:function(value,rowData,rowIndex){ 
			         if(value == null || value==''){
			           return "";
			         }else {
					    var data='<a style="color:blue;" href="javascript:showAposInfo(\''+rowData.APOS_ID+'\')">'+rowData.APOS_ID+'</a>';
                        return data;  
                     }   
                }
			
			},
			{title:'终端型号',field:'MID',align:'center',width:'80',sortable:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:'80',sortable:true},
			{title:'下次报道时间',field:'NEXT_SIGN_TIME',align:'center',width:'100',sortable:true},
			{title:'报道截止时间',field:'LAST_SIGN_END_TIME',align:'center',width:'100',sortable:true},			
			{title:'分支机构',field:'REG_NAME',align:'center',width:'105',sortable:true}
				]]
			});
			
		});

		
		function showAposInfo(APOS_ID){
	   		var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposInfo-view.jsp","APOS_ID="+APOS_ID+"&t=1","850","450");
		}