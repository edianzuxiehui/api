<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
<head>
  <base href="<%=basePath%>">
	<title></title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript">
	var titleName ='';
	var colName ='';
	var sqlId='';
	var expFileName='';
	$(function(){
		var url = document.location.toString(); 
		var queryFlag = url.substring(url.indexOf("queryFlag=")+10);
		$('#idQueryFlag').val(queryFlag);
	    //var d=new Date();
	    //var starttm = d.Format("YYYY-MM-DD");  
	    //$("#idEndDate1").val(starttm);
		if(queryFlag=='init'){
			colName = '装机数量';
		}else if(queryFlag=='change'){
			colName = '换机数量';
		}else if(queryFlag=='recycle'){
			colName = '撤机数量';
		}
	    	//加载当前登录人员机构信息
		    $.ajax({
				   type: "POST",
				   url: "initDataForMerchInfo.do",
				   data: "param=idRegId,regEntireId",       //idOrgId,idMerchStatus
				    success: function(data){
				    if(data.idRegId&&data.regEntireId){
				       var str  = data.idRegId.split("(");
				       $("#idRegId").val(str[1].substring(0,str[1].length-1));
				       $("#idRegName").val(data.idRegId);
				       $("#idRegEntireId").val(data.regEntireId);
				       
				       $("#idOperRegId").val(str[1].substring(0,str[1].length-1));
				       $("#idOperRegEntireId").val(data.regEntireId);
				    }
				  
				   } 
				  });
	});
	
    function queryInfo(){
			if($('#idBeginDate').val()!="" && $('#idEndDate').val()!="" && $('#idBeginDate').val()>$('#idEndDate').val()){
				msgShow("提示","选择的开始时间大于结束时间，请重新选择!","info");
			}else{	
		 	    clearSelect('idAposChangeTraceReport');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		        var date=new Date();
				var param="flag="+date.getTime()
					+"&QUERY_REG_ENTIRE_ID="+$.trim($('#idRegEntireId').val())
					+"&queryFlag="+$.trim($('#idQueryFlag').val())
					+"&BEGIN_DATE="+$('#idBeginDate').val()
					+"&END_DATE="+$('#idEndDate').val();			   
				//$('#idAposChangeTraceReport').datagrid('options').url = "listAposChangeTraceReport.do?"+param;// 改变它的url  
				//$("#idAposChangeTraceReport").datagrid('load');

				$.getJSON("listAposChangeTraceReport.do?"+param, function(data){
					//$('#idReportBody').layout('collapse','north');  
					
					$('#idReportTitle').html(titleName);  
					if($('#idBeginDate').val()!=''){
						$("#idQueryBeginDate").html('开始日期：'+$('#idBeginDate').val());
					}else{
						$("#idQueryBeginDate").html('');
					}
					if($('#idEndDate').val()!=''){
						$("#idQueryEndDate").html('结束日期：'+$('#idEndDate').val());
					}else{
						$("#idQueryEndDate").html('');
					}
					$("#idtblhead").show();
					
					$("#tbl").empty();
					$("#tbl").append('<thead bgcolor="#EEEEEE">'
							  +'<th width="40%">分支机构</th>'
							  +'<th width="30%">'+colName+'</th>'
							  +'<th width="30%">详情</th></thead>');
					
					$.each(data, function(i,item){
						$("#tbl").append('<tr ><td>'+item.REG_NAME+'</td>'
								+'<td>'+item.NUM+'</td>'
								+'<td align="center">'
									+'<input id="detail'+item.KEYID+'" type="button" class="btn_grid" value="详情查看" '
									+'onclick="javascript:listAposChangeTraceReportDetail(\''+item.REG_ID+'\')\"/>&nbsp;&nbsp;'
									+'<input id="export'+item.KEYID+'" type="button" class="btn_grid" value="导出明细" '
									+'onclick="javascript:exportAposChangeTraceReportDetail(\''+item.REG_ID+'\')\"/>'
								+'</td></tr>');
			    	});
				}); 
				
				//条件选了可能不点查询，主界面不变，但条件需要带到详情，所以要特殊处理
				$('#idRegEntireId1').val($('#idRegEntireId').val());
				$('#idBeginDate1').val($('#idBeginDate').val());
				$('#idEndDate1').val($('#idEndDate').val());
				$('#idRegName1').val($('#idRegName').val());
				$('#idRegId1').val($('#idRegId').val());
			}
		}
	  function listAposChangeTraceReportDetail(regId){
		  var queryFlag = $('#idQueryFlag').val();
		  var beginDate = $('#idBeginDate1').val();
		  var endDate = $('#idEndDate1').val();
		  var REG_NAME = $('#idRegName1').val();//仅仅为了详情界面显示
		  var QUERY_REG_ID = $('#idRegId1').val();
    	  var param={'queryFlag':queryFlag,'REG_ID':regId,'BEGIN_DATE':beginDate,'END_DATE':endDate,'REG_NAME':REG_NAME,'QUERY_REG_ID':QUERY_REG_ID};
		  openDialogFrame('<%=basePath%>core/aposchangetrace/AposChangeTrace-report-detail.jsp',param,"900","540");
	  }  
	  
	  function exportAposChangeTraceReportDetail(regId){
		  var queryFlag = $('#idQueryFlag').val();
		  var beginDate = $('#idBeginDate1').val();
		  var endDate = $('#idEndDate1').val();
		  var REG_NAME = $('#idRegName1').val();//仅仅为了详情界面显示
		  var QUERY_REG_ID = $('#idRegId1').val();
		  
		  var sqlCols = "APOS_ID,CREATE_DATE,OLD_SERIAL_NO,OLD_MID,MERCH_ID,TERMINAL_ID,REG_NAME";
		  var titles ="";
		  if(queryFlag=='init'){
				expFileName="aposchangetrace-detailreport-init";
				titles ="应用终端号,装机时间,硬件序列号,主机型号,主应用商户,主应用终端号,分支机构";
			}else if(queryFlag=='change'){
				expFileName="aposchangetrace-detailreport-change";
				titles ="应用终端号,换机时间,硬件序列号,主机型号,主应用商户,主应用终端号,分支机构";
			}else if(queryFlag=='recycle'){
				expFileName="aposchangetrace-detailreport-recycle";
				titles ="应用终端号,撤机时间,硬件序列号,主机型号,主应用商户,主应用终端号,分支机构";
			}
		  titles=escape(escape(titles));
    	  var param='isExport=1&fields='+sqlCols+'&titles='+titles+'&fileName='+expFileName+'&queryFlag='+queryFlag+'&REGID='+regId+'&BEGINDATE='+beginDate+'&ENDDATE='+endDate+'&REGNAME='+escape(escape(REG_NAME))+'&QUERYREGID='+QUERY_REG_ID;
		  window.open(getRootPath()+"/listAposChangeTraceReportDetail.do?"+param);
	  }  
	  
	 function doexport(){		
			var queryFlag = $('#idQueryFlag').val();
			var operRegId = $("#idOperRegId").val();
			var subfix="";
			
			var rootRegId = $('#idRootRegId').val();//alert('rootRegId'+rootRegId);alert(operRegId);
			if(operRegId==rootRegId){
				subfix = "Corp";
			}else{
				subfix="Branch";
			}
			if(queryFlag=='init'){
				colName = '装机数量';
				titleName = '装机统计';
				sqlId="listAposChangeTraceReportFor"+subfix+"Init";
				expFileName="aposchangetrace-report-init";
			}else if(queryFlag=='change'){
				colName = '换机数量';
				titleName = '换机统计';
				sqlId="listAposChangeTraceReportFor"+subfix+"Change";
				expFileName="aposchangetrace-report-change";
			}else if(queryFlag=='recycle'){
				colName = '撤机数量';
				titleName = '撤机统计';
				sqlId="listAposChangeTraceReportFor"+subfix+"Recycle";
				expFileName="aposchangetrace-report-recycle";
			}
		
			var title="分支机构,"+colName;
			title=escape(escape(title));
			
			var endDate='';
			if($("#idEndDate").val()==""){
			    endDate = new Date().Format("YYYY-MM-DD HH:MM:SS");  
			}else{
				endDate = $("#idEndDate").val()+" 23:59:59";
			}
			
			//选择机构为空，默认为登录人员机构
			var regEntireId = $("#idRegEntireId").val();
			if(regEntireId==""){
				regEntireId = $("#idOperRegEntireId").val();  
			}
			
			var queryInfo="{'queryRegEntireId':'"+regEntireId
				+"','queryFlag':'"+$("#idQueryFlag").val()
				+"','beginDate':'"+$('#idBeginDate').val()
				+"','endDate':'"+endDate+"'}";//alert(queryInfo);
			var sqlcols="REG_NAME,NUM";
			var param="title="+title+"&sqlId="+sqlId+"&queryInfo="+queryInfo+"&sqlcols="+sqlcols+"&filename="+expFileName
			window.open(getRootPath()+"/exportExcel.do?"+param);
		}
	 
		function cleardata(){
			var queryFlag = $('#idQueryFlag').val();
			var operRegEntireId = $('#idOperRegEntireId').val();
			var operRegId = $('#idOperRegId').val();
			var rootRegId = $('#idRootRegId').val();
			
			$('#queryForm').form('clear');
			
			$('#idQueryFlag').val(queryFlag);
			$('#idOperRegEntireId').val(operRegEntireId);
			$('#idOperRegId').val(operRegId);
			$('#idRootRegId').val(rootRegId);
		}
	</script>
</head>

<body class="easyui-layout" fit="true" id="idReportBody" onload="getRootRegId('queryForm');">
<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
	<div region="north" style="height:55px;position:relative;background:#EEEEEE" title=""  split="true">  
		<form id="queryForm">
			<table class="formTable" style="width:95%;">
				<col  width="9%" class="leftCol"/>
				<col width="10%" >
				<col  width="9%" class="leftCol"/>
				<col width="10%" >
				<col  width="9%" class="leftCol"/>
				<col width="30%" >
				<col  width="16%" class="leftCol"/>
				<col width="7%" align="right">
				<input type="hidden" id="idQueryFlag" name="queryFlag"/>
				
				<!-- 条件选了可能不点查询，主界面不变，但条件需要带到详情，所以要特殊处理-->
				<input type="hidden" name="BEGIN_DATE1" id="idBeginDate1" />
				<input type="hidden" name="END_DATE1" id="idEndDate1" />
				<input type="hidden" name="REG_ENTIRE_ID1" id="idRegEntireId1" />
				<input type="hidden" name="REG_NAME1" id="idRegName1" />
				<input type="hidden" name="REG_ID1" id="idRegId1" />

				<!-- 保存登录人员机构信息，用于excel导出区别总分公司登录人员 -->
				<input type="hidden" name="OPER_REG_ENTIRE_ID" id="idOperRegEntireId" />
				<input type="hidden" name="OPER_REG_ID" id="idOperRegId" />				
							<tr>
								<td>开始日期</td>
								<td>
									<input type="text" name="BEGIN_DATE" id="idBeginDate" maxlength="19" class="Wdate readonly" readonly onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:14em"/>
								</td>
								<td>结束日期</td>
								<td>
									<input type="text" name="END_DATE" id="idEndDate" maxlength="19" class="Wdate readonly" readonly onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:14em"/>
								</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId"/>
									<input type="text" class="" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" style="width:9em"/>
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId')"/>
								</td>
								<td>
								<input id="idQuery" type="button" class="btn_grid" value="查 询" onclick="queryInfo()"/>
								<input id="idReset" type="button" class="btn_grid" value="重 置" onclick="cleardata()"/>
								</td>
								<td>
								<input id="idToExcel" type="button" class="btn_grid" value="导出Excel" onclick="doexport()"/>
								</td>
							</tr>
						</table>
					</form>
	     </div>
	     
		<div region="center" style="text-align:center"  >  
			<table width="90%"  border="0" cellspacing="0" cellpadding="5"  >
			  <tr>
			    <td colspan="2" align="center" id="idReportTitle" class="reportTitle" height="50"> </td>
			  </tr>
			  <tr id="idtblhead"style="display:none">
			    <td colspan="1" id="idQueryBeginDate"></td>
			    <td colspan="1" id="idQueryEndDate"></td>
			  </tr>
			</table>
			
			<table width="90%"  border="0" cellspacing="0" cellpadding="5" class="report" id="tbl" >		
			</table>
	   </div>
</body>

</html>
