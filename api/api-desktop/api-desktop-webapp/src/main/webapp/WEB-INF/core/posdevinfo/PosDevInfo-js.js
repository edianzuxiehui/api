var processFlag =false;//用于控制进度条	
$(function(){
		
			$('#idPosDevInfo').datagrid({
				//title:'实体终端管理',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listPosDevInfo.do',
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
			//{title:'实体终端编号',field:'DEV_ID',align:'center',width:100,sortable:true},
			//{title:'数据来源',field:'DATA_SOURCE',align:'center',width:100,sortable:true},
			{title:'终端型号',field:'MID',align:'center',width:140,sortable:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:150,sortable:true},
			{title:'实体终端状态',field:'DEV_STATUS',align:'center',width:150,sortable:true},
			{title:'入库时间',field:'IN_DATE',align:'center',width:190,sortable:true},
			{title:'分支机构',field:'REG_ID',align:'center',width:215,sortable:true},
			{title:'备注',field:'DESC_TXT',align:'center',width:150,sortable:true}
				]]
			});
			var param = window.dialogArguments;
			 if(!param||!param.par){//主界面或增加界面
				 initFidData();
			 }
				$(".export_toolbar").attr('disabled', true);
		});
		
		//初始化厂家数据，reffer to ModelInfo-js.js
		function initFidData(fid){
		     $.ajax({
			   type: "POST",
			   url: "initDataForModelInfo.do",
			   data: "param=idFidSelect", //参数可以是idFidSelect,idMidSelect,idDllDir
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
			     if(fid){
			    	 $("#idFidSelect").val(fid);
			    	 if(processFlag){
			    		 showProcess(false);//防止进度条一直存在
			    	 }
			    	 processFlag = true;
			     }
			   } 
			  }); 
		}
		
        //根据厂商(FID)改变主机型号
        function changeModelByFID(fid,mid){
              if(fid==""){
               $("#idMidSelect").empty();
			    option = new Option("请选择主机型号","");
			    document.getElementById("idMidSelect").options.add(option);
               return;
              }
		   	   $.ajax({
			   type: "POST",
			   url: "getModelInfoByFID.do",
			   data: "FID="+fid,       
			  success: function(data){
				   var option;
				   $("#idMidSelect").empty();
				   
				   option = new Option("请选择主机型号","");
				   document.getElementById("idMidSelect").options.add(option);
				   
				   if(data.idMidSelect){
				     $.each(data.idMidSelect,function(idx,item){ 
				         option = new Option(item.MID_NAME,item.MID);  
	                    document.getElementById("idMidSelect").options.add(option);
				     });
				    }
				   if(mid){
					   $("#idMidSelect").val(mid);
				    	 if(processFlag){
				    		 showProcess(false);//防止进度条一直存在
				    	 }
				    	 processFlag = true;
				   }
			   } 
			  }); 
		}