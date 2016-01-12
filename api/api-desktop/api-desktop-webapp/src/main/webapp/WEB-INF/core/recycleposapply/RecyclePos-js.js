	$(function(){
		
			$('#idAposInfo').datagrid({
				title:'',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listRecyePos.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:10,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	               // {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			//{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true},
			
				{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true, formatter:function(value,rowData,rowIndex){ 
					    var data='<a style="color:blue;" href="javascript:showAposInfo('+rowData.APOS_ID+')\">'+rowData.APOS_ID+'</a>';
                        return data;  
                    } },
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
				}},
			{title:'主应用商户名称',field:'MERCH_NAME',align:'center',width:120,sortable:true},
			{title:'主应用终端号',field:'TERMINAL_ID',align:'center',width:100,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:100,sortable:true},
			{title:'撤机申请状态',field:'APOS_VALID',align:'center',width:100,sortable:true,
				formatter:function(value,rowData,rowIndex){
					var a="";
					if(value=="1"){
						a="未申请";
					}else if(value=="2"){
						a="<font color='red'>已申请</font>";
					}
					return a;
				}
			},
			{title:'主机型号',field:'MID',align:'center',width:140,sortable:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:140,sortable:true},
			{title:'装机完成时间',field:'CREATE_POS_TIME',align:'center',width:140,sortable:true},
			{title:'操作',field:'FUNCTION',align:'center',width:140,sortable:true,
			 formatter:function(value,rowData,rowIndex){
			 			var a="";
			 		    if(rowData.APOS_VALID=="1"){
			 				//a='<input type="button" class="btn_grid" value="撤机" onclick="unbindDevId(\''+ rowData.APOS_ID+ '\',\''+rowData.DEV_ID+ '\')"/>';
			 			   a='<input type="button" class="btn_grid" value="撤机申请" onclick="recyePosApply(\''+ rowData.APOS_ID+ '\',\''+rowData.SERIAL_NO+ '\',\''+rowData.MID+ '\',\'' +rowData.MERCH_ID+ '\',\'' + rowData.TERMINAL_ID +  '\',\''+ rowData.DEV_ID+'\',\'' + rowData.REG_ID +  '\',\'' + rowData.REG_ENTIRE_ID +  '\')"/>';
			 			}else if(rowData.APOS_VALID=="2"){
			 				a='<input type="button" class="btn_grid" value="申请撤销" onclick="recyePosApplyCancle(\''+ rowData.APOS_ID+ '\',\''+rowData.SERIAL_NO+ '\',\''+rowData.MID+ '\',\'' +rowData.MERCH_ID+ '\',\'' + rowData.TERMINAL_ID +  '\',\''+ rowData.DEV_ID+'\',\'' + rowData.REG_ID +  '\',\'' + rowData.REG_ENTIRE_ID +  '\')"/>';
			 			}
                        return a;  
                    }  
			} 
				]]
			
			});
			
			initDataForModelInfo('idFidSelect');
			
			//初始化数据
			function initDataForModelInfo(param){
			     $.ajax({
				   type: "POST",
				   url: "initDataForModelInfo.do",
				   data: "param="+param, //参数可以是idFidSelect,idMidSelect,idDllDir
				   success: function(data){ 
				     if(data.idFidSelect){//对idFidSelect(厂商）进行赋值
					     var option;
					     for(var i = 0 ; i< data.idFidSelect.length; i++){
					        option  = new Option(data.idFidSelect[i].F_NAME,data.idFidSelect[i].FID);                       
	                        document.getElementById("idFidSelect").options.add(option);
	                      //  option += "<option value=" + data.idFidSelect[i].FID +">" + data.idFidSelect[i].F_NAME+ "</option>";
					     }
					     //$("#idFidSelect").append(option);
				     }
				     if(data.idMidSelect){ //对idMidSelect(主机型号）进行赋值
					     for(var i = 0 ; i< data.idMidSelect.length; i++){
					        option=new Option(data.idMidSelect[i].MID_NAME,data.idMidSelect[i].MID);                       
	                        document.getElementById("idMidSelect").options.add(option);
					     }
					 }   
					
				   } 
				  }); 
			}
	
		});
		 

		function recyePosApply(APOS_ID,SERIAL_NO,MID,MERCH_ID,TERMINAL_ID,DEV_ID,REG_ID,REG_ENTIRE_ID){
			$.messager.confirm('确认', "您确定要申请撤机吗?", function(r){
				if(r){ 
	                //var param = {APOS_ID:APOS_ID,SERIAL_NO:SERIAL_NO,MID:MID,MERCH_ID:MERCH_ID,TERMINAL_ID:TERMINAL_ID,DEV_ID:DEV_ID};
	        	    $.ajax({
					   type: "POST",
					   url: "recyclePosApply.do",
					   data: {APOS_ID:APOS_ID,SERIAL_NO:SERIAL_NO,MID:MID,MERCH_ID:MERCH_ID,TERMINAL_ID:TERMINAL_ID,DEV_ID:DEV_ID,tmsModuleTitle:tmsJ5ModuleTitle,tmsModuleId:tmsJ5ModuleId,REG_ID:REG_ID,REG_ENTIRE_ID:REG_ENTIRE_ID},       
					  success: function(data){
						  if (data !=null) {
								if(data.status=="false"){
									msgShow('提示消息',data.message,'error');
								}else{
								  
									msgShow('提示消息',data.status,'info');
									flashTable("idAposInfo");
						        }
						  } else {
									msgShow('提示消息','操作失败，请检查！','warning');
						  }
					   } 
					  }); 
					
				}
			});
		}
		
		function recyePosApplyCancle(APOS_ID,SERIAL_NO,MID,MERCH_ID,TERMINAL_ID,DEV_ID,REG_ID,REG_ENTIRE_ID){
			$.messager.confirm('确认', "您确定要撤销撤机申请吗?", function(r){
				if(r){ 
	                //var param = {APOS_ID:APOS_ID,SERIAL_NO:SERIAL_NO,MID:MID,MERCH_ID:MERCH_ID,TERMINAL_ID:TERMINAL_ID,DEV_ID:DEV_ID};
	        	    $.ajax({
					   type: "POST",
					   url: "recyclePosApplyCancle.do",
					   data: {APOS_ID:APOS_ID,SERIAL_NO:SERIAL_NO,MID:MID,MERCH_ID:MERCH_ID,TERMINAL_ID:TERMINAL_ID,DEV_ID:DEV_ID,tmsModuleTitle:tmsJ5ModuleTitle,tmsModuleId:tmsJ5ModuleId,REG_ID:REG_ID,REG_ENTIRE_ID:REG_ENTIRE_ID},       
					  success: function(data){
						  if (data !=null) {
								if(data.status=="false"){
									msgShow('提示消息',data.message,'error');
								}else{
								  
									msgShow('提示消息',data.status,'info');
									flashTable("idAposInfo");
						        }
						  } else {
									msgShow('提示消息','操作失败，请检查！','warning');
						  }
					   } 
					  }); 
					
				}
			});
		}
		
		
		function showAposInfo(APOS_ID){
	  
	      var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposInfo-view.jsp","APOS_ID="+APOS_ID,"850","450");
	   }
		
		function viewMerchInfo(merchId) {
			var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/MerchInfo-view.jsp","MERCH_ID="+merchId,"600","260");
		}
		
		
	
