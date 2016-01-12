	$(function(){
			initDataForModelInfoInPosDevInfo('idFidSelect,idMidSelect');
		});
		
		//初始化厂家型号数据，reffer to ModelInfo-js.js
		function initDataForModelInfoInPosDevInfo(param){
		     $.ajax({
			   type: "POST",
			   url: "initDataForModelInfo.do",
			   data: "param="+param, //参数可以是idFidSelect,idMidSelect,idDllDir
			   beforeSend :function(){
			   	 var k=window.dialogArguments; 
				 if(k&&k.par){
			    	showProcess(true,"加载终端型号","加载终端型号中...");
			     }
			    },
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
			     if(data.idMidSelect){ //对idFidSelect(主机型号）进行赋值
				     for(var i = 0 ; i< data.idMidSelect.length; i++){
				        option=new Option(data.idMidSelect[i].MID_NAME,data.idMidSelect[i].MID);                       
                        document.getElementById("idMidSelect").options.add(option);
				     }
				 }   
				 
				 //修改页面使用，在下拉框数据等准备完毕后，设置值
				 var k=window.dialogArguments; 
				 if(k&&k.par){
				  	var param=k.par;
					$.getJSON("queryAPMSPosDev.do",param,function(data){
						if(data.status && data.status=="false"){
					    	$.messager.alert("修改",data.message,"error",function(){
					    		self.close();
					    	});
					    	return false;
					 	}
					       
						$.each(data.rows,function(idx,item){
							$("#idDevId").val($.trim(item.DEV_ID));
							$("#idDataSource").val($.trim(item.DATA_SOURCE));
							$("#idMidSelect").val($.trim(item.MID));
							$("#idSerialNo").val($.trim(item.SERIAL_NO));
							//$("#idDevStatus").val($.trim(item.DEV_STATUS));
							$("#idInDate").val($.trim(item.IN_DATE));
							$("#idRegId").val($.trim(item.REG_ID));
							$("#idRegEntireId").val($.trim(item.REG_ENTIRE_ID));
							$("#idRegName").val($.trim(item.REG_NAME));
							$("#idDescTxt").val($.trim(item.DESC_TXT));
							parent.$('#idMid').attr("value",$('#idMidSelect').val());
						});
		            }); 
		            
		            //根据型号定位厂家
		            $.getJSON("queryModelInfo.do",param,function(data){
		            	$("#idFidSelect").val(data.rows[0].FID);
		            }); 
		            
		         }	
				  showProcess(false);//防止进度条一直存在
			   } 
			  }); 
		}		