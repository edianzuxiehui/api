	$(function(){
		
			$('#idAposInfo').datagrid({
				title:'',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listChangeableAposInfo.do',
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
			{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true,
				styler:function(value,rowData,rowIndex){
					return 'color:#ccc;';
				},
				formatter:function(value,rowData,rowIndex) {
					if(value==null) {
						return "";
					}else{
						return '<a href="javascript:void(0)" onclick="viewAposDetail(\''+rowData.APOS_ID+'\')" style="color:blue;">'+value+'</a>';
					}
				}
			},
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
			{title:'主应用终端号',field:'TERMINAL_ID',align:'center',width:100,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:100,sortable:true},
			{title:'原主机型号',field:'MID',align:'center',width:140,sortable:true},
			{title:'原硬件序列号',field:'SERIAL_NO',align:'center',width:140,sortable:true},
			{title:'目标主机型号',field:'NEW_MID',align:'center',width:140,sortable:true},
			{title:'目标硬件序列号',field:'NEW_SERIAL_NO',align:'center',width:140,sortable:true},
			{title:'授权状态',field:'AUTH_FLAG_NAME',align:'center',width:80,sortable:true},
			{title:'装机完成时间',field:'CREATE_POS_TIME',align:'center',width:140,sortable:true},
			{title:'操作',field:'FUNCTION',align:'center',width:200,sortable:true,
				formatter:function(value,rowData,rowIndex){
					var a="";
				 	if(rowData.AUTH_FLAG=="1"){
				 		a='<input type="button" class="btn_grid" value="更换实体终端" onclick="changeDev(\''+ rowData.APOS_ID+ '\',\''+rowData.DEV_ID+'\',\''+rowData.MID+'\',\''+rowData.SERIAL_NO+'\')"/>';
				 		//a+='  <input type="button" class="btn_grid" value="撤销" onclick="bindDevId(\''+ rowData.APOS_ID+ '\',\''+rowData.MID+'\')"/>';
				 	}
	                return a;  
                }  
			} 
				]],
				toolbar:[{
					text:"<a style='font-weight:700'>换机授权</a>",
					iconCls:'icon-add',
					handler:doAuth
				},{
					text:"<a style='font-weight:700'>撤销授权	</a>",
					iconCls:'icon-remove',
					handler:doRemoveAuth
				},{
					text:"<a style='font-weight:700'>本机换本机</a>",
					iconCls:'icon-add',
					handler:doAuthSelfChange
				},{
					text:"<a style='font-weight:700'>撤销本机换本机</a>",
					iconCls:'icon-remove',
					handler:doRemoveAuthSelfChange
				}]
			});
	
		});
		 
		function bindDevId(aposid,mid){	
			//传入参数0表示绑定操作
			var devid=openDialogFrame(getRootPath()+"/core/aposbind/AposBindPosDevInfo.jsp?aposid="+aposid+"&mid="+mid,"","800","500");
			if(devid!=undefined){
				
				
				var tab = top.tabpanel.tabs('getSelected');
				tmsJ5ModuleTitle=tab.panel('options').title;
		  		tmsJ5ModuleId=tab.panel('options').tabId;
				
				$.getJSON("aposBindDev.do?tmsModuleTitle="+escape(tmsJ5ModuleTitle),{APOSID:aposid,DEVID:devid,Oper:'0',tmsModuleId:tmsJ5ModuleId},function(data){
					if (data !=null) {
						if(data.status=="false"){
							msgShow('提示消息',data.message,'error');
						}else{
							msgShow('提示消息',data.message,'info');
							clearSelect('idAposInfo');
							flashTable("idAposInfo");
						}
					} else {
						msgShow('提示消息','操作失败，请检查！','warning');
					}
				});
			}
				
			
		}
		function changeDev(aposId,oldDevId,oldMID,oldSno){	
			//传入参数0表示绑定操作
			var param = {"oldMID":oldMID,"oldSno":oldSno};
			var devmid=openDialogFrame(getRootPath()+"/core/aposchange/AposBindDev.jsp",param,"800","500");
			if(devmid!=undefined){
				var tab = top.tabpanel.tabs('getSelected');
				tmsJ5ModuleTitle=tab.panel('options').title;
		  		tmsJ5ModuleId=tab.panel('options').tabId;
		  		var id = devmid.split("_");
				$.getJSON("aposChangeDev.do?tmsModuleTitle="+escape(escape(tmsJ5ModuleTitle)),{APOSID:aposId,DEVID:id[0],MID:id[1],OLDDEVID:oldDevId,OLDMID:oldMID,tmsModuleId:tmsJ5ModuleId},function(data){
					if (data !=null) {
						if(data.status=="false"){
							msgShow('提示消息',data.message,'error');
						}else{
							msgShow('提示消息',data.message,'info');
							clearSelect('idAposInfo');
							flashTable("idAposInfo");
						}
					} else {
						msgShow('提示消息','操作失败，请检查！','warning');
					}
				});
			}
				
			
		}
		
		function doAuth(){
		
			var rows = $('#idAposInfo').datagrid('getSelections');
			var ids="";
			var fields=null;
			if(rows){
				var num = rows.length;
			    if(num < 1){
					msgShow('提示消息','请选择你要授权换机操作的应用终端!','info');
			    }else{
					for(var i = 0; i < num; i++){
						if(rows[i].AUTH_FLAG =="1"){
							msgShow('提示消息','应用终端['+rows[i].APOS_ID+']已经授权了换机操作!','info');
							return;
						}
						ids+=rows[i].APOS_ID+","
					}
					ids = ids.substring(0,ids.length-1);
					var authflag = "1";
					var tab = top.tabpanel.tabs('getSelected');
					tmsJ5ModuleTitle=tab.panel('options').title;
			  		tmsJ5ModuleId=tab.panel('options').tabId;
					$.getJSON("aposAuth.do",{APOSIDS:ids,AUTHFLAG:authflag,tmsModuleTitle:escape(tmsJ5ModuleTitle),tmsModuleId:tmsJ5ModuleId},function(data){
						if (data !=null) {
							if(data.status=="false"){
								msgShow('提示消息',data.message,'error');
							}else{
								msgShow('提示消息',data.message,'info');
								clearSelect('idAposInfo');
								flashTable("idAposInfo");
							}
						} else {
							msgShow('提示消息','操作失败，请检查！','warning');
						}
					});
			    }
			}
			flashTable("idAposInfo");
		}
		
		function doRemoveAuth(){
		
			var rows = $('#idAposInfo').datagrid('getSelections');
			var ids="";
			var fields=null;
			if(rows){
				var num = rows.length;
			    if(num < 1){
					msgShow('提示消息','请选择你要授权换机操作的应用终端!','info');
			    }else{
					for(var i = 0; i < num; i++){
						if(rows[i].AUTH_FLAG =="0"){
							msgShow('提示消息','应用终端['+rows[i].APOS_ID+']并没有授权换机操作，无法撤销!','info');
							return;
						}
						ids+=rows[i].APOS_ID+","
					}
					ids = ids.substring(0,ids.length-1);
					var authflag = "0";
					var tab = top.tabpanel.tabs('getSelected');
					tmsJ5ModuleTitle=tab.panel('options').title;
			  		tmsJ5ModuleId=tab.panel('options').tabId;
					$.getJSON("aposAuth.do",{APOSIDS:ids,AUTHFLAG:authflag,tmsModuleTitle:escape(tmsJ5ModuleTitle),tmsModuleId:tmsJ5ModuleId},function(data){
						if (data !=null) {
							if(data.status=="false"){
								msgShow('提示消息',data.message,'error');
							}else{
								msgShow('提示消息',data.message,'info');
								flashTable("idAposInfo");
							}
						} else {
							msgShow('提示消息','操作失败，请检查！','warning');
						}
					});
			    }
			}
			clearSelect('idAposInfo');
			flashTable("idAposInfo");
		}
		function doAuthSelfChange(){
			var rows = $('#idAposInfo').datagrid('getSelections');
			var ids="";
			var fields=null;
			if(rows){
				var num = rows.length;
			    if(num < 1){
					msgShow('提示消息','请选择你要授权换机操作的应用终端!','info');
			    }else if(num>1){
			    	msgShow('提示消息','本机换本机授权换机操作只能选择一台应用终端!','info');
			    }else{
					if(rows[0].AUTH_FLAG =="1"){
						msgShow('提示消息','应用终端['+rows[0].APOS_ID+']已经授权了换机操作!','info');
						return;
					}
					ids=rows[0].APOS_ID;
					var authflag = "2";
					var devflag = "1";
					var changeflag = "1";
					var tab = top.tabpanel.tabs('getSelected');
					tmsJ5ModuleTitle=tab.panel('options').title;
			  		tmsJ5ModuleId=tab.panel('options').tabId;
					$.getJSON("aposSelfChangeAuth.do",{APOSID:ids,AUTHFLAG:authflag,DEVSTATUS:devflag,CHANGESTATUS:changeflag,tmsModuleTitle:escape(tmsJ5ModuleTitle),tmsModuleId:tmsJ5ModuleId},function(data){
						if (data !=null) {
							if(data.status=="false"){
								msgShow('提示消息',data.message,'error');
							}else{
								msgShow('提示消息',data.message,'info');
								flashTable("idAposInfo");
							}
						} else {
							msgShow('提示消息','操作失败，请检查！','warning');
						}
					});
			    }
			}
			clearSelect('idAposInfo');
			flashTable("idAposInfo");
		}
		function doRemoveAuthSelfChange(){
			var rows = $('#idAposInfo').datagrid('getSelections');
			var ids="";
			var fields=null;
			if(rows){
				var num = rows.length;
			    if(num < 1){
					msgShow('提示消息','请选择你要授权换机操作的应用终端!','info');
			    }else if(num>1){
			    	msgShow('提示消息','本机换本机授权换机操作只能选择一台应用终端!','info');
			    }else{
					if(rows[0].AUTH_FLAG =="1"){
						msgShow('提示消息','应用终端['+rows[0].APOS_ID+']已经授权了换机操作!','info');
						return;
					}
					if(rows[0].AUTH_FLAG != "2"){
						msgShow('提示消息','应用终端['+rows[0].APOS_ID+']没有授权本机换本机，无法撤销!!!','info');
						return;
					}
					ids=rows[0].APOS_ID;
					var authflag = "0";
					var devflag = "2";
					var changeflag = "0";
					var tab = top.tabpanel.tabs('getSelected');
					tmsJ5ModuleTitle=tab.panel('options').title;
			  		tmsJ5ModuleId=tab.panel('options').tabId;
					$.getJSON("aposSelfChangeAuth.do",{APOSID:ids,AUTHFLAG:authflag,DEVSTATUS:devflag,CHANGESTATUS:changeflag,tmsModuleTitle:escape(tmsJ5ModuleTitle),tmsModuleId:tmsJ5ModuleId},function(data){
						if (data !=null) {
							if(data.status=="false"){
								msgShow('提示消息',data.message,'error');
							}else{
								msgShow('提示消息',data.message,'info');
								flashTable("idAposInfo");
							}
						} else {
							msgShow('提示消息','操作失败，请检查！','warning');
						}
					});
			    }
			}
			clearSelect('idAposInfo');
			flashTable("idAposInfo");
		}
		
		
		function viewAposDetail(aposId) {
			var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposInfo-view.jsp","APOS_ID="+aposId+"&t=1","850","450");
		}
		
		function viewMerchInfo(merchId) {
			var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/MerchInfo-view.jsp","MERCH_ID="+merchId,"600","260");
		}