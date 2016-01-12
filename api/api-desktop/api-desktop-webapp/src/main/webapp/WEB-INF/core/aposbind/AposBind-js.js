	$(function(){
		
			$('#idAposInfo').datagrid({
				title:'',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listBindedAposInfo.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
				pagination:true,
				singleSelect:true,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用终端号',field:'APOS_ID',align:'center',width:120,sortable:true},
			{title:'主应用商户号',field:'MERCH_ID',align:'center',width:170,sortable:true},
			{title:'主应用商户名称',field:'MERCH_NAME',align:'center',width:170,sortable:true},
			{title:'主应用终端号',field:'TERMINAL_ID',align:'center',width:120,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:160,sortable:true},
			{title:'装机完成状态',field:'COMPLET_NAME',align:'center',width:90,sortable:true},
			{title:'主机型号',field:'MID',align:'center',width:160,sortable:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:160,sortable:true}
			//{title:'数据来源',field:'DATA_SOURCE_NAME',align:'center',width:80,sortable:true},
			//{title:'操作',field:'CREATE_POS_TIME',align:'center',width:100,sortable:true,
			//	formatter:function(value,rowData,rowIndex){ 
			//			if(rowData.DATA_SOURCE=="2"){
			//				 return '<input type="button" class="btn_grid" value="修改明细" onclick="updateDetail(\''+rowData.APOS_ID+'\',\''+rowData.DEV_ID+'\')"/>';
			//			}
            //            return "";  
            //        } 
			//
			//
			//}
			
				]],
				toolbar:[{
					text:"<a style='font-weight:700'>绑定实体终端</a>",
					iconCls:'icon-add',
					handler:doAposBindDev
				},{
					text:"<a style='font-weight:700'>解除绑定终端</a>",
					iconCls:'icon-remove',
					handler:doRemoveBindDev
				},{
					text:"<a style='font-weight:700'>重新绑定终端</a>",
					iconCls:'icon-redo',
					handler:doReBindDev
				}]
			});
			defaultQueryReg();
			var tab = top.tabpanel.tabs('getSelected');
			var moduleTitle=tab.panel('options').title;
	  		var moduleId=tab.panel('options').tabId;
			$("#idTmsModuleTitle").attr("value",moduleTitle);
			$("#idTmsModuleId").attr("value",moduleId);
	
		});
		 
		function doAposBindDev() {
			var retValue=openDialogFrame(getRootPath()+"/core/aposbind/AposBindDev.jsp","","1000","500");
			if(retValue=="true"){
			msgShow("绑定","绑定成功!","info");
				clearSelect('idAposInfo');
				flashTable("idAposInfo");
			}else if(retValue=="false"){
			   msgShow("绑定","终端绑定失败，请检查数据!","error");
			}
		}
		function updateDetail(aposId,devId){
			//APMS参数指定应用终端修改页面点击'返回'按钮，选中下一个标签页
			var retValue=openDialogFrame(getRootPath()+"/core/aposbind/UpdateAPMSDetail.jsp",{APOS_ID:aposId,DEV_ID:devId,APMS:true},"950","550");
			if(retValue=="true"){
				msgShow('提示消息',"应用终端["+aposId+"]信息修改成功！！",'info');
				clearSelect('idAposInfo');
				flashTable("idAposInfo");
			}
		}
		
		
		function doRemoveBindDev(){
			var rowsapos = $('#idAposInfo').datagrid('getSelections');
			
			var ids = null;
			var fields=null;
			if(rowsapos.length < 1){
				msgShow('提示消息','请选择你要解除绑定的应用终端!','info');
			}else{
				if(rowsapos[0].COMPLET_FLAG !="0"){
					msgShow('提示消息','你要解除绑定的应用终端已经完成装机!','info');
				}else{
					param ="APOSID=" + rowsapos[0].APOS_ID+"&DEVID=" + rowsapos[0].DEV_ID+"&MID=" + rowsapos[0].MID;
				  	param += "&tmsModuleTitle="+escape(escape($('#idTmsModuleTitle').val()))+"&tmsModuleId="+escape(escape($('#idTmsModuleId').val()));
				  	$.getJSON("aposUnBindDev.do",param,function(data){
				  		if(data.status =="false"){
				  			msgShow('提示消息',data.message,'info');
				  		}else{
				  			msgShow('提示消息',"应用终端["+rowsapos[0].APOS_ID+"]解除绑定成功！！",'info');
				  			clearSelect('idAposInfo');
				  			flashTable("idAposInfo");
				  		}
					});
				}
			}
		}
		
		function doReBindDev(){
			var rowsapos = $('#idAposInfo').datagrid('getSelections');
			
			var ids = null;
			var fields=null;
			if(rowsapos.length < 1){
				msgShow('提示消息','请选择你要解除绑定的应用终端!','info');
			}else{
				if(rowsapos[0].COMPLET_FLAG !="0"){
					msgShow('提示消息','你要解除绑定的应用终端已经完成装机!','info');
				}else{
					var retValue=openDialogFrame(getRootPath()+"/core/aposbind/AposBindPosDevInfo.jsp","","800","500");
					if(retValue!=undefined){
						var dev = retValue.split("_");
						param ="APOSID=" + rowsapos[0].APOS_ID+"&DEVID=" + rowsapos[0].DEV_ID+"&MID=" + rowsapos[0].MID;
						param +="&NEWDEVID=" + dev[0]+"&NEWMID=" + dev[1];
					  	param += "&tmsModuleTitle="+escape(escape($('#idTmsModuleTitle').val()))+"&tmsModuleId="+escape(escape($('#idTmsModuleId').val()));
					  	$.getJSON("aposReBindDev.do",param,function(data){
					  		if(data.status =="false"){
					  			msgShow('提示消息',data.message,'info');
					  		}else{
					  			msgShow('提示消息',"应用终端["+rowsapos[0].APOS_ID+"]绑定实体终端成功！！",'info');
					  			clearSelect('idAposInfo');
					  			flashTable("idAposInfo");
					  		}
						});
						
					}
					
				}
			}
		}
