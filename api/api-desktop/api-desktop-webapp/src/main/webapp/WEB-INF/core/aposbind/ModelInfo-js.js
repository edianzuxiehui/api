	$(function(){
		   if(document.getElementById('idModelInfo')){
			$('#idModelInfo').datagrid({
				title:'终端型号列表',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listModelInfo.do',
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
			{title:'终端型号',field:'MID',align:'center',width:150,sortable:true},
			{title:'终端型号名称',field:'MID_NAME',align:'center',width:100,sortable:true},
			{title:'厂商',field:'F_NAME',align:'center',width:150,sortable:true},
			{title:'基本配置',field:'BASE_CONFIG',align:'center',width:150,sortable:true},
			{title:'可选配置',field:'OPT_CONFIG',align:'center',width:150,sortable:true},
			{title:'应用程序目录',field:'APP_DIR',align:'center',width:150,sortable:true},
			{title:'厂商DLL路径',field:'DLL_DIR',align:'center',width:240,sortable:true}
	
				]]
			});
			  //初始化数据
			  initDataForModelInfo('idFidSelect');
		   
		   }	
		});
		
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
				 
				 if(data.idDllDir){//
				   $("#idDllDir").val(data.idDllDir);
				   $("#dllDirDefaultValue").val(data.idDllDir);
				}
				
			   } 
			  }); 
		}




		 $.extend($.fn.validatebox.defaults.rules, {
		     dllStart: {
		        validator: function (value, param) {
		            return $("#idDllDir").val().startWith(document.getElementById("dllDirDefaultValue").value);
		        },
		      message: function(){
		        return  '厂商DLL路径必需以'+document.getElementById("dllDirDefaultValue").value+'开头';
		      }
		    },
	        ismodelChars : {// 请输字母数字-的组合！added by linjc
               validator : function(value) {
               return  /^[0-9a-zA-Z-]+$/i.test(value);
             },
              message : '请输字母数字-的组合！'
            }
		    
		  });
 
         //根据厂商(FID)改变主机型号
         function changeModelByFID(fid){
              
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
			   } 
			  }); 
		}

         function checkExistModelInfo(mid){
           if(mid == ""){
             return;
           }
		    var flag =  checkPKIsExist("mid",mid,"checkExistModelInfo");
			if(flag=="true"){
			     $("#idExist").val(flag);
				 msgShow("提示","您所输入的主机型号已经存在，请修改!!!","error");
			}else if(flag ="false") {
				 $("#idExist").val("");
			}
	   }
	   
	   
	 