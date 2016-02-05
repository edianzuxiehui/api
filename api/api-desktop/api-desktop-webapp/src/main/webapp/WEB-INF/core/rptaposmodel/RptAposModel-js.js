	$(function(){
			defaultQueryReg();
		         var d=new Date();
		         var starttm = d.Format("YYYY-MM-DD");  
		         //$("#idBeginDate").val(starttm);
		         $("#idEndDate").val(starttm);
			
	
		});
		
		function insRow(data){
		 	var total = $('#idRptAposModel').datagrid('getData').total
		 	var paramRow = {row:{REG_NAME:'<font style="font-size:15px;font-weight:bold;">总装机量</font>',NUM:total}}
			$('#idRptAposModel').datagrid('insertRow',paramRow);
		}
		
		 /*
		 输入参数为表头title,查询的id,页面参数,queryInfo,sql取值的
		 */
		 function doexport(){
		 	var title=escape(escape("分支机构,终端型号,装机数量"));
			var selectId="listRptAposModel";
			var beginDate = $("#idBeginDate").val();
			if(beginDate!='') beginDate += ' 00:00:00';
			var endDate = $("#idEndDate").val();
			if(endDate!='') endDate += ' 23:59:59';
			var queryInfo="{'regEntireId':'"+$("#idRegEntireId").val()+"','beginDate':'"+beginDate+"','endDate':'"+endDate+"'}";
			var sqlcols="REG_NAME,MID_NAME,NUM";
			var filename="aposmodel";	
			exportExcel(title,selectId,queryInfo,sqlcols,filename);
		 }
		 
		 function exportExcel(title,selectId,queryInfo,sqlcols,filename){
		  var param={'title':title,'selectId':selectId,'queryInfo':queryInfo,'sqlcols':sqlcols,'filename':filename};
		  //var param={'title':title,'selectId':selectId,'queryInfo':queryInfo};
		  //var str = JSON.stringify(param); 
		  var param="title="+title+"&selectId="+selectId+"&queryInfo="+queryInfo+"&sqlcols="+sqlcols+"&filename="+filename

		  
		  window.open(getRootPath()+"/exportexcel.do?"+param);
		 
		 }
		 
		 //@author laixr
		 function excelExport() {
			var beginDate = $.trim($('#idBeginDate').val());
			var endDate = $.trim($('#idEndDate').val());
			var regEntireId = $.trim($('#idRegEntireId').val());
			var param = "REG_ENTIRE_ID="+regEntireId+"&flag="+(new Date()).getTime()+"&BEGIN_DATE="+beginDate+"&END_DATE="+endDate;
		 	window.open(getRootPath()+"/exportRptAposModel.do?"+param);
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
	
