	$(function(){
		   if(document.getElementById('idDevAppFile')){
			$('#idDevAppFile').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listDevAppFile.do',
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
			{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:120,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:100,sortable:true},
			{title:'主机型号',field:'MID',align:'center',width:100,sortable:true},
			{title:'程序文件路径',field:'APP_FILE_PATH',align:'center',width:140,sortable:true},
			{title:'实际程序名',field:'REAL_APPNAME',align:'center',width:120,sortable:true},
			{title:'实际版本号',field:'REAL_APPVER',align:'center',width:120,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:150,sortable:true},
			{title:'备注',field:'DESC_TXT',align:'center',width:140,sortable:true}
				]]
			});
			initDataForDevAppFile('idAppId,idFid,idMid,id_sort_tbl_dev_app_file');
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
		 }	
	   
		});
		
		
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
			     if(data.idFid){ 
			       $.each(data.idFid,function(idx,item){ 
			            // option += "<option value=" + data.idOrgId[i].ORG_ID +">" + data.idOrgId[i].ORG_NAME+ "</option>";
				         option = new Option(item.F_NAME,item.FID);                       
	                     document.getElementById("idFid").options.add(option);
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
		
        //根据厂商(FID)改变主机型号
        function changeModelByFID(fid,mid){
              if(fid==""){
               $("#idMid").empty();
			    option = new Option("请选择主机型号","");
			    document.getElementById("idMid").options.add(option);
               return;
              }
		   	   $.ajax({
			   type: "POST",
			   url: "getModelInfoByFID.do",
			   data: "FID="+fid,       
			  success: function(data){
				   var option;
				   $("#idMid").empty();
				   
				   option = new Option("请选择主机型号","");
				   document.getElementById("idMid").options.add(option);
				   
				   if(data.idMidSelect){
				     $.each(data.idMidSelect,function(idx,item){ 
				         option = new Option(item.MID_NAME,item.MID);  
	                    document.getElementById("idMid").options.add(option);
				     });
				    }
				  
			   } 
			  }); 
		}
		
		//增加上传按钮
		 var t = 0; 
		 function addFile(){
		    var parent = document.getElementById("more"); 
		    var br = document.createElement("br"); 
		    var input = document.createElement("input"); 
		    var button = document.createElement("input"); 
		    input.type = "file"; 
		    t = t+1;
		    input.name = "uploadFile[" + t + "].file"; 
		    input.size = "30"; 
		    button.type = "button"; 
		    button.value = "删除"; 
		
		    button.onclick = function() 
		    { 
		     parent.removeChild(br); 
		     parent.removeChild(input); 
		     parent.removeChild(button); 
		    
		    }; 
		    parent.appendChild(br); 
		    parent.appendChild(input); 
		    parent.appendChild(button); 

         }
		
		function changeAppVerInfo(appId){
		   	   $.ajax({
			   type: "POST",
			   url: "getAppVerInfoIdAndName.do",
			   data: "APP_ID="+appId,       
			  success: function(data){
			   var option;
			   $("#idAppVer").empty();
			   
			   option = new Option("请选择应用版本","");
			   if(document.getElementById("idAppVer")){
			   	document.getElementById("idAppVer").options.add(option);
			   }
			   if(data.idAppVer){
			     $.each(data.idAppVer,function(idx,item){ 
			        // option += "<option value=" + data.idOrgId[i].ORG_ID +">" + data.idOrgId[i].ORG_NAME+ "</option>";
			         option = new Option(item.APP_VER,item.APP_VER);  
                     if(document.getElementById("idAppVer")){
                     document.getElementById("idAppVer").options.add(option);
                     }
			     });
			    }
			   } 
			  }); 
		}
		
		function openUpLoadPage(AddOrUpdate){
		   var idAppId= $('#idAppId').val();
		    var idAppVer;
		    if(AddOrUpdate =='update_devAppFile'){
		      idAppVer = $("#idAppVer").val();
		    }else {
		      idAppVer = $("#idAppVer").find("option:selected").text();
		    
		    }
		   var idMid= $('#idMid').val();
		   if(idAppId ==""){
		     alert("请选择应用编号");
		     return;
		   }else if($("#idAppVer").val()==""){
		      alert("请选择应用版本");
		      return;
		   }else if(idMid==""){
		     alert("请选择主机型号");
		      return;
		   }
		   //新增的时候判断主键是否唯一
		   if(AddOrUpdate =='add_devAppFile'){
		       var flag = true;
		       $.ajax({
			   type: "POST",
			   url: "checkExistDevAppFile.do",
			   data:"APP_ID="+idAppId+"&APP_VER="+idAppVer+"&MID="+idMid,
			   async:false,
			   success: function(data){
			     if(data.isExist){
			         msgShow("新增",data.isExist,"error");
			         flag = false;
			     }
			   } 
			  }); 
			  if(!flag){
			   return flag;
			  }
		   }
		    var param = "APP_ID="+idAppId+"&APP_VER="+idAppVer+"&MID="+escape(escape($.trim(idMid)))+"&AddOrUpdate="+AddOrUpdate;
			var retValue = openDialogFrame(getRootPath()+"/core/devappfile/UploadFileForDevAppFile.jsp",param,"400","470");
			if(retValue.status){
			   $("#idRealAppname").val(retValue.idRealAppname);//实际程序名 
			   $("#idRealAppver").val(retValue.idRealAppver);//实际版本
			   $("#idAppFilePath").val(retValue.idAppFilePath);//
			   $("#idAppDir").val(retValue.idAppDir);//
			   $("#idAppFilePath").val($("#idAppId").val()+$("#idAppVer").val());//程序文件路径
			   $("#idTempFilePath").val(retValue.idTempFilePath);//存放文件的临时目录
			   $("#idDeletePath").val(retValue.idDeletePath);//删除目录
			   $("#uploadSuccess").show();
			   if(AddOrUpdate =='add_devAppFile'){//新增成功后禁用下拉框
				   $("#idAppId").next().remove();$("#idAppId").hide();$("#idAppId").after("<input style='width: 50%' value='"+$("#idAppId").find("option:selected").text()+"' readonly>");
				   $("#idAppVer").next().remove();$("#idAppVer").hide();$("#idAppVer").after("<input style='width: 50%' value='"+$("#idAppVer").find("option:selected").text()+"' readonly>");
				   $("#idFid").next().remove();$("#idFid").hide();$("#idFid").after("<input style='width: 50%' value='"+$("#idFid").find("option:selected").text()+"' readonly>");
				   var nextObj=$("#idMid").next();
					if(nextObj.attr("type")!="button"){
						$("#idMid").next().remove();
					}
				   $("#idMid").hide();$("#idMid").after("<input style='width: 33%'  value='"+$("#idMid").find("option:selected").text()+"' readonly>");
			   }
			   
		    }else if(retValue.message){
		       //显示错误信息
			   msgShow("上传uns",retValue.message,"error");
			   $("#idRealAppname").val("");//实际程序名 
			   $("#idRealAppver").val("");//实际版本
			   $("#idAppFilePath").val("");//
			   $("#idAppDir").val("");//
			   $("#idAppFilePath").val("");//程序文件路径
			   $("#idTempFilePath").val("");//存放文件的临时目录
			   $("#idDeletePath").val("");//删除目录
			   $("#uploadSuccess").hide();
		   }
		}
		
		
		//点击取消按钮将删除临时文件
		function cancel(){
		   var delPath = $("#idDeletePath").val();
		  // alert(delPath);
		   if(delPath!=""){
		   //删除临时文件
		    $.ajax({
			   type:"get",
			   url:"deleteTempFile.do",
			   data:"delPath="+delPath,       
			   success: function(data){
			   } 
			  }); 
		   }  
		   window.close();
			  
		}
		 //验证是否有修改程序文件的权限，下级是不可以修改上级的共享的程序文件
		function checkModifyDevAppFileAuthority(){
		  	var regName = $('#idDevAppFile').datagrid('getSelected').REG_NAME;
			var str = regName.split("(");//得到regId;
			var regId = str[1].substring(0,str[1].length-1);
			var flag = true;
			$.ajax({
			   type: "POST",
			   url: "checkModifyDevAppFileAuthority.do",
			   data: "REG_ID="+regId,  
			   async: false,    
			  success: function(data){
			          flag = data.authority;
			   } 
			  }); 
			 return flag;
		
		}
		

