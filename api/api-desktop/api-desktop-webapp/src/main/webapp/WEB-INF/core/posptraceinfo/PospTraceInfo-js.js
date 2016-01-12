	$(function(){
		
			$('#idPospTraceInfo').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listPospTraceInfo.do',
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
			//{title:'通知流水号',field:'POSP_TRACE_ID',align:'center',width:100,sortable:true},
			{title:'商户编码',field:'MERCHNAME',align:'center',width:130,sortable:true},
			{title:'终端号',field:'TERMINAL_ID',align:'center',width:100,sortable:true},
			{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:100,sortable:true},
			{title:'终端型号',field:'MID_NAME',align:'center',width:100,sortable:true},
			//{title:'任务分配id',field:'TASK_SYS_ID',align:'center',width:100,sortable:true},
			//{title:'通知信息',field:'POSP_NOTICEE_INFO',align:'center',width:100,sortable:true},
			{title:'建立时间',field:'CREATE_DATE',align:'center',width:130,sortable:true},
			{title:'同步标记',field:'SYNC_FLAG',align:'center',width:100,sortable:true},
			{title:'同步时间',field:'POSP_SYNC_TIME',align:'center',width:130,sortable:true},
			//{title:'同步批次号',field:'POSP_SYNC_BATCHID',align:'center',width:100,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:100,sortable:true},
			{title:'详情',field:'Detail',align:'center',width:100,formatter:function(value,rowData,rowIndex){
						return '<input type="button" class="btn_grid" value="详细信息" onclick="javascript:pospinfo_detail(\''+rowData.POSP_TRACE_ID+'\')\ "/>';
						}}
				]],
				toolbar:[{
					text:"删除",
					iconCls:'icon-remove',
					handler:delPospTask
				}],
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
		
		function delPospTask(){
		    var rows = $('#idPospTraceInfo').datagrid('getSelections');
		    var num = rows.length;
		    var ids = null;
		    if(num < 1){
			  msgShow('提示消息','请选择你要删除的记录!','info');
			  return;
		    }
		    for(var i = 0; i < num; i++){
				if(rows[i].POSP_SYNC_TIME){
					 msgShow('提示消息',"有任务已经同步，不能删除！",'error');
					 return false;
				} 
			}
			
			
			 deleteNoteById("idPospTraceInfo","delPospTraceInfo.do", "");
		}
		
		
	   function pospinfo_detail(posptraceId){
		var param={'POSP_TRACE_ID':posptraceId};
  		var returnValue= openDialogFrame(getRootPath()+"/core/posptraceinfo/posptrace-view.jsp",param,"650","500");
		}
		
				
		   function initDataForAppInfo(param){
		    $.ajax({
			   type: "POST",
			   url: "initDataForAppInfo.do",
			   data: "param="+param,       //idOrgId,idMerchStatus
			  success: function(data){
			    if(data.idRegId){
			       var str  = data.idRegId.split("(");
			       $("#idRegId").val(str[1].substring(0,str[1].length-1));
			       $("#idRegName").val(data.idRegId);
			       
			    }
			     if(data.idAppId){
			       $("#idAppId").val(data.idAppId);
			    
			    }
			    if(data.idRegEntireId){
			       $("#idRegEntireId").val(data.idRegEntireId);
			    
			    }
			   } 
			  }); 
			
	}
		
		
		
		  function initDataForDevAppFile(param){
		    $.ajax({
			   type: "POST",
			   url: "initDataForDevAppFile.do",
			   data: "param="+param,       //idOrgId,idMerchStatus
			  success: function(data){
			    var option; 
			    //对idAppId进行赋值
			   if(data.idAppId){
			     $.each(data.idAppId,function(idx,item){ 
		            // option += "<option value=" + data.idOrgId[i].ORG_ID +">" + data.idOrgId[i].ORG_NAME+ "</option>";
			         option = new Option(item.APP_NAME,item.APP_ID);                       
                     document.getElementById("idAppId").options.add(option);
			     });
			    }
			     if(data.idMid){ 
			       $.each(data.idMid,function(idx,item){ 
			            // option += "<option value=" + data.idOrgId[i].ORG_ID +">" + data.idOrgId[i].ORG_NAME+ "</option>";
				         option = new Option(item.MID_NAME,item.MID);                       
	                     document.getElementById("idMid").options.add(option);
			      });
				 } 
				 if(data.idTempFilePath){ 
			       $("#idTempFilePath").val(data.idTempFilePath);
				 } 
				 /*
				 //对id_sort_tbl_dev_app_file进行赋值
			    if(data.id_sort_tbl_dev_app_file){//data.id_sort_tbl_dev_app_file的数据格式为--->APP_ID:应用编码,APP_VER:应用版本,APP_FILE_PATH:存放程序文件夹名,REAL_APPNAME:实际模块名,REAL_APPVER:实际版本
			      var  strs1  = data.id_sort_tbl_dev_app_file.split(",");
			      for(var i = 0 ;i < strs1.length; i++){
			         var strs2 = strs1[i].split(":");
			         option = new Option(strs2[1],strs2[0]);                       
                     document.getElementById("id_sort_tbl_dev_app_file").options.add(option); 
			      }
			    }
			    */
			   } 
			  }); 
			
		}
