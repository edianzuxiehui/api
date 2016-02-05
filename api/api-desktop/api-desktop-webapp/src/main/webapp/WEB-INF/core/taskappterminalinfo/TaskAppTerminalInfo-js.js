	//初始化应用下拉框	 
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
			    $("#idAppId").val($("#idAppId1").val());//保证加载完后再设置值
				
			    //修改页面应用不可选
			    var k=window.dialogArguments; //alert(k.par.srcFlag);
				if(k.par.srcFlag==undefined){
					$("#idAppId").attr("disabled",true);
				}
			  }
			} 
		  }); 
		}
		function changeAppVerInfo(appId){
			if(!appId){
				$("#idAppVer").empty();
				   option = new Option("请选择应用版本","");
				   document.getElementById("idAppVer").options.add(option);
				$("#idParamModelId").empty();
				   option = new Option("请选择参数模板","");
				   document.getElementById("idParamModelId").options.add(option);
				return false;
			}
		   $.ajax({
			   type: "POST",
			   url: "listAppverForCombox.do",
			   data: "APP_ID="+appId,       
			  success: function(data){
			   var option;
			   $("#idAppVer").empty();
			   
			   option = new Option("请选择应用版本","");
			   document.getElementById("idAppVer").options.add(option);
			   
			   if(data){
				   data=eval("("+data+")");
			     $.each(data,function(idx,item){ 
			         option = new Option(item.APP_VER,item.APP_VER);  
                     document.getElementById("idAppVer").options.add(option);
			     });
			   $("#idAppVer").val($("#idAppVer1").val());//保证加载完后再设置值
			    }
			   } 
			  }); 
			  $.ajax({
			   type: "POST",
			   url: "getParamModuleName.do",
			   data: "APP_ID="+appId,       
			  success: function(data){
			   var option;
			   $("#idParamModelId").empty();
			   option = new Option("请选择参数模板","");
			   option1=new Option("空模板","T000000000");
			   document.getElementById("idParamModelId").options.add(option);
			   document.getElementById("idParamModelId").options.add(option1);
			   if(data.idparamodId){
			     $.each(data.idparamodId,function(idx,item){ 
			         option = new Option(item.PARAMMODEL_NAME,item.PARAM_MODEL_ID);  
                     document.getElementById("idParamModelId").options.add(option);
			     });
			     $("#idParamModelId").val($("#idParamModelId1").val());//保证加载完后再设置值
			    }
			   } 
			  });
		}	
		
	  function selMerch(){
		var retValue=openDialogFrame(getRootPath()+"/core/merchinfo/merchinfo-query.jsp","","800","500");
		if(retValue!=undefined){//alert(retValue);
			$('#idMerchId').val(retValue.merchId);
			$('#idMerchName').val(retValue.merchName);
		}
	  }	
	  
		/*
	  验证应用
		1、主应用更新标志不能为删除
		2、删除应用，参数更新标志必须为删除
		3、新增应用，参数更新标志必须为新增
	*/	
	function validApp(){
		if($('#idUpdateDate').val()==""){
			msgShow('任务应用信息','更新时间不能为空','info');
			return false;
		}
		
		if($("#idAppId").val()=='00000000' && $("#idAppUpdateFlag").val()=='4'){
			msgShow("任务应用","TMS管理器应用不能删除!","error");
			return false;
		}
		if($("#idAppId").val()=='00000000' && $("#idMasterAppFlag").val()=='1'){
			msgShow("任务应用","TMS管理器应用不能是主应用!","error");
			return false;
		}	
		
		if($("#idMasterAppFlag").val()=='1' && $("#idAppUpdateFlag").val()=='4'){
			msgShow("任务应用",'主应用不能删除!',"error");
			return false;
		}
		if($("#idAppUpdateFlag").val()=='4'&&$("#idParamUpdateFlag").val()!='4'){
			msgShow("任务应用",'删除应用，参数更新标志必须为删除!',"error");
			return false;
		}
		if($("#idAppUpdateFlag").val()=='1'&&$("#idParamUpdateFlag").val()!='1'){
			msgShow("任务应用",'新增应用，参数更新标志必须为更新!',"error");
			return false;
		}
		
		if($("#idAppUpdateFlag").val()!='4'){//应用非删除，必须输入商户终端号
			if($("#idAppId").val()!='00000000'){
				if($("#idMerchId").val()==''){
					msgShow("任务应用",'请选择商户!',"error");
					return false;
				}
				if(Trim($("#idTerminalId").val())==''){//非管理器应用必须输入终端号
					msgShow("任务应用",'请输入终端号!',"error");
					return false;
				}else{
					var val = Trim($("#idTerminalId").val());
					if(!(/^[0-9a-zA-Z]+$/i.test(val))) {
						msgShow("任务应用","终端号请输入数字或字母,且为8位!","error");
						return false;
					}
					if(val.length!=8){
						msgShow("任务应用","终端号位数为8位,请确认！!","error");
						return false;
					}
				}
			}			
		}
		
    	var curDate = new Date().Format("YYYY-MM-DD hh:mm:ss");//alert(curDate);
    	var updateDate = $('#idUpdateDate').val();
    	if(updateDate!='0000-00-00 00:00:00'&&!compareDate(updateDate,curDate)){
    		msgShow('任务应用','更新时间不能小于当前时间！','info');
    		return false;
    	}
    	
		return true;
	}
	
	    /*根据应用提取原应用终端的商户终端号，在增加应用中使用*/
		function getAposMerchTermAc2AppId(appId){
			   var aposId = $("#idAposId").val();
			   $.ajax({
				   type: "POST",
				   url: "getAposMerchTermAc2AppId.do",
				   data: "APOS_ID="+aposId+"&APP_ID="+appId,       
				   success: function(data){
					   data =$.parseJSON(data);//将json字符串转为对象
					   if(appId=='00000000'&&!data.MERCH_ID){
						   $.messager.alert("任务应用","原应用终端数据有问题，TMS管理器应用不存在!","error",function(){
							   self.close();
						   });
					   }
					   $("#idMerchId").val(data.MERCH_ID);
					   $("#idMerchName").val(data.MERCH_NAME);
					   if(data.MERCH_NAME==null||data.MERCH_NAME=='null'||Trim(data.MERCH_NAME)==''){
						   $("#idMerchName").val(data.MERCH_ID);
					   }
					   $("#idTerminalId").val(data.TERMINAL_ID);
				   } 
				}); 
			   
			    //管理器应用不能输入商户终端号
				if($("#idAppId").val()=='00000000'){
					$('#idChoose').attr('disabled','true');
					$('#idTerminalId').attr('disabled','true');
					$('#idTerminalId').css('background-color','#EEEEEE');
				}else{
					$('#idChoose').removeAttr('disabled');//只要有disabled，不管值为多少都不可用
					$('#idTerminalId').removeAttr('disabled');
					$('#idTerminalId').css('background-color','#FFFFFF');
				}
			}		  