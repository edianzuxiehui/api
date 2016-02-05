	$(function(){
		
			$('#idPosAdvertising').datagrid({
				//title:'终端广告管理',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listPosAdvertising.do',
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
			{title:'应用名称',field:'APP_NAME',align:'center',width:150,sortable:true,
				formatter:function(value,rowData,rowIndex){
					if(rowData.APP_NAME ==null || rowData.APP_NAME==""){
						return "<a style='font-weight:700'>所有应用</a>";
					}
					return rowData.APP_NAME;
				}
			
			},
			{title:'商户',field:'MERCH_NAME',align:'center',width:150,sortable:true,
				formatter:function(value,rowData,rowIndex){
					if(rowData.MERCH_NAME ==null || rowData.MERCH_NAME==""){
						return "<a style='font-weight:700'>所有商户</a>";
					}
					return rowData.MERCH_NAME;
				}
			},
			{title:'分支机构',field:'REG_NAME',align:'center',width:200,sortable:true},
			{title:'结束时间',field:'END_DATE',align:'center',width:150,sortable:true},
			{title:'广告信息',field:'AD_CONTENT',align:'center',width:250,sortable:true}
				]]
			});
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
	
		});
		
		
		
		function queryApp(idAppId,idAppName,idAppFlag){
			var param="showComplexAppTag=Y";
			var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AppInfoAdvertis-query.jsp",param,"600","400");
			if(retValue!=undefined) {
				var i = retValue.indexOf('_');
				var appId = retValue.substring(0,i);
				var appName = retValue.substring(i+1);
				$('#'+idAppId).val(appId);
				$('#'+idAppName).val(appName+"("+appId+")");
				$('#'+idAppFlag).val('');
			}
		}
		
		function clearApp(idAppId,idAppName,idAppFlag){
			$('#'+idAppId).val('');
			$('#'+idAppName).val('');
			$('#'+idAppFlag).val('');
		}
		function allApp(idAppId,idAppName,idAppFlag){
			$('#'+idAppFlag).val('1');
			$('#'+idAppName).val('所有应用');
		}
		function selectMerchInfo(idAppId,idMerchName,idMerchFlag){
			var retValue=openDialogFrame(getRootPath()+"/core/posadvertising/MerchInfo-Query.jsp","","800","500");
			if(retValue){
			   	var reg = retValue.split("_");
				$('#'+idAppId).val(reg[0]);
				$('#'+idMerchName).val(reg[1]);
				$('#'+idMerchFlag).val('');
			}
		}
		function clearMerchInfo(ididAppId,idMerchName,idMerchFlag){
      		$('#'+ididAppId).val("");
      		$('#'+idMerchName).val("");
      		$('#'+idMerchFlag).val("");
   	 	}
   	 	
   	 	function allMerchInfo(idMerchFlag,idMerchName){
      		$('#'+idMerchFlag).val("1");
      		$('#'+idMerchName).val("所有商户");
   	 	}