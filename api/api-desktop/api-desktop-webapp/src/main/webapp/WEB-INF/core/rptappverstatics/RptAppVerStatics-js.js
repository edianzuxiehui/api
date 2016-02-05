	$(function(){
			initDataForAppInfo('idRegId,idRegEntireId');
			$('#pp').hide();
		});
		
		
		 /*
		 输入参数为表头title,查询的id,页面参数,queryInfo,sql取值的
		 */
		 
		 function doexport(){
		 	if($('#queryForm').form('validate')){
		 		var title=escape(escape("应用终端号,主应用商户号,主应用终端号,终端型号,应用,应用版本,分支机构"));
				var selectId="listRptAppVerStatics";
				var queryInfo="{'regentirId':'"+$("#idRegEntireId").val()+"','appVer':'"+$("#idAppVer").val()+"','appId':'"+$("#idAppId").val()+"'}";
				var sqlcols="APOS_ID,MERCH_ID,TERMINAL_ID,MID_NAME,APP_NAME,APP_VER,REG_NAME";
				var filename="appverstatics";	
				exportExcel(title,selectId,queryInfo,sqlcols,filename);
			 	
		 	}
		 	
		 }
		 
		 function exportExcel(title,selectId,queryInfo,sqlcols,filename){
		  var param={'title':title,'selectId':selectId,'queryInfo':queryInfo,'sqlcols':sqlcols,'filename':filename};
		  var param="title="+title+"&selectId="+selectId+"&queryInfo="+queryInfo+"&sqlcols="+sqlcols+"&filename="+filename
		  window.open(getRootPath()+"/exportexcel.do?"+param);
		 
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
	function queryApp(idAppId,idAppName) {	
	var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AppInfo-query.jsp","","650","400");
	if(retValue!=undefined) {
		var i = retValue.indexOf('_');
		var appId = retValue.substring(0,i);
		var appName = retValue.substring(i+1);
		$('#'+idAppId).val(appId);
		$('#'+idAppName).val(appName);
		//当所选择应用为多应用管理器时，禁用商户输入域
		
		//设置应用版本列表
		$.getJSON('listAppverForCombox.do',{APP_ID:appId},function(data){
			if(data!=null) {
				$('#idAppVer').empty();
				$('#idAppVer').append('<option value="">请选择应用版本</option>');
				for(var i=0;i<data.length;i=i+1) {
					$('#idAppVer').append('<option value="'+data[i].APP_VER+'">'+data[i].APP_VER+'</option>');
				}
			}
		});
	}
}
		