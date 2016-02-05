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
    <script type="text/javascript" src="core/rptappverstatics/RptAppVerStatics-js.js"></script>
	<script type="text/javascript">
				
		
		
		function queryInfo(){
		
			if($('#queryForm').form('validate')){
				//var date=new Date();
				//var param="flag="+date.getTime()+"&REG_ENTIRE_ID="+escape(escape($.trim($('#idRegEntireId').val())))+"&APP_ID="+escape(escape($.trim($('#idAppId').val())))+"&APP_VER="+escape(escape($.trim($('#idAppVer').val())))+"&ask_flag=1";			   
				//$('#idRptAppVerStatics').datagrid('options').url = "listRptAppVerStatics.do?"+param;// 改变它的url  
				//$("#idRptAppVerStatics").datagrid('load');
				var date=new Date();
				var starttm = date.Format("YYYY-MM-DD"); 
				$("#Idquerytm").html(starttm);
				  $("#tbl").empty();
				  $("#idtblhead").show();
				  //$('#idplanbody').layout('collapse','north');  
				  $("#tbl").append('<thead bgcolor="#EEEEEE"> <th width="15%">应用终端号</th><th width="20%">主应用商户号</th><th width="15%">主应用终端号</th><th width="10%">终端型号</th><th width="10%">应用</th><th width="10%">应用版本</th><th width="20%">分支机构</th></thead>');
				  var pageSize = 10;//设置初始页面大小
				  var regEntireId = $.trim($('#idRegEntireId').val());
				  var appId = $.trim($('#idAppId').val());
				  var appVer = $.trim($('#idAppVer').val());
				  var param="flag="+date.getTime()+"&REG_ENTIRE_ID="+escape(escape(regEntireId))+"&APP_ID="+escape(escape(appId))+"&APP_VER="+escape(escape(appVer))+"&ask_flag=1"+"&page=1&rows="+pageSize;
				  $.getJSON("listRptAppVerStatics.do?"+param, function(data){
					$.each(data.rows, function(i,item){
					$("#tbl").append('<tr ><td>'+item.APOS_ID+'</td><td>'+item.MERCH_ID+'</td><td>'+item.TERMINAL_ID+'</td><td>'+(item.MID_NAME==null?' ':item.MID_NAME)+'</td><td>'+item.APP_NAME+'</td><td>'+(item.APP_VER==null?' ':item.APP_VER)+'</td><td>'+item.REG_NAME+'</td></tr>');
				  	});
				  	//$("#tbl").append('<tr ><td colspan="2" style="background-color:#EEEEEE;font-weight: 700;">总装机量</td><td>'+data.total+'</td></tr>');
				  	//$("#tbl").append('<thead bgcolor="#EEEEEE"> <th colspan="2" width="66%">总计</th><th colspan="5" width="33%">'+data.total+'</th></thead>');
				  	if(data.total>0) {
				  		$("#tbl").append('<thead bgcolor="#EEEEEE"> <th colspan="2" align="right" style="text-align:right;">总计:&nbsp;&nbsp;  </th><th colspan="5" align="left" style="text-align:left;">&nbsp;  '+data.total+'</th></thead>');
				  		$('#pp').pagination({
							total:data.total,
							pageSize:pageSize,
							onSelectPage:function(pageNumber,pageSize) {
								nextPage(pageNumber, pageSize, regEntireId, appId, appVer);
							}
						});
						$('#pp').show();
				  	}else{
				  		$('#pp').hide();
				  	}
				  	
				  });
			}
		    
			
		}
		
		function nextPage(pageNumber, pageSize, regEntireId, appId, appVer) {
			
			$('#pp').pagination('loading');
			var date=new Date();
			var param="flag="+date.getTime()+"&REG_ENTIRE_ID="+escape(escape(regEntireId))+"&APP_ID="+escape(escape(appId))+"&APP_VER="+escape(escape(appVer))+"&ask_flag=1"+"&page="+pageNumber+"&rows="+pageSize;
			$.getJSON("listRptAppVerStatics.do?"+param, function(data){
				if(data!=null) {
					$('#tbl').empty();
					$("#tbl").append('<thead bgcolor="#EEEEEE"> <th width="15%">应用终端号</th><th width="20%">主应用商户号</th><th width="15%">主应用终端号</th><th width="10%">终端型号</th><th width="10%">应用</th><th width="10%">应用版本</th><th width="20%">分支机构</th></thead>');
					$.each(data.rows, function(i,item){
						$("#tbl").append('<tr ><td>'+item.APOS_ID+'</td><td>'+item.MERCH_ID+'</td><td>'+item.TERMINAL_ID+'</td><td>'+(item.MID_NAME==null?' ':item.MID_NAME)+'</td><td>'+item.APP_NAME+'</td><td>'+(item.APP_VER==null?' ':item.APP_VER)+'</td><td>'+item.REG_NAME+'</td></tr>');
					});
					$("#tbl").append('<thead bgcolor="#EEEEEE"> <th colspan="2" align="right" style="text-align:right;">总计:&nbsp;&nbsp;  </th><th colspan="5" align="left" style="text-align:left;">&nbsp;  '+data.total+'</th></thead>');
				}
				$('#pp').pagination('loaded');
			});
			
		}
		
		function cleardata(){
			$('#queryForm').form('clear');
			initDataForAppInfo('idRegId,idRegEntireId');
		}
	</script>
</head>

<body class="easyui-layout" id="idplanbody"  >
<script type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
	    <div  region="north" style="height: 50px;position:relative;background:#EEEEEE" title=""   split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col width="8%" class="leftCol"/>
				<col width="22%" >
				<col  width="5%" class="leftCol"/>
				<col width="22%" >
				<col  width="8%" class="leftCol"/>
				<col width="15%" >
				<col width="25%">

				
							<tr>
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden"   name="REG_ENTIRE_ID" id="idRegEntireId" maxlength="50" />
									<input type="text" size="15"  class="easyui-validatebox" required="true"  style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>

								</td>
							
								<td>应用</td>
								<td>
								    
									
								<input type="hidden" name="APP_ID" id="idAppId" value=""/>
								<input type="text" name="APP_NAME" id="idAppName"  required="true" size="15"  readonly class="readonly easyui-validatebox" required="true" />
								<input type="button" class="btn_grid" value=" 选 择 " id="btnQueryApp" onclick="queryApp('idAppId','idAppName');"/>
									
								</td>
							
								<td>应用版本</td>
								<td>
									<select  class="easyui-validatebox" name="APP_VER" id="idAppVer" style="width: 135px;" >
									 <option value="">请选择应用版本</option>
									</select>
								</td>
								<td >
								<input id="idQuery" type="button" class="btn_grid" value="  查  询  " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value="  重  置  " onclick="cleardata()"/>
								<input id="idToExcel" type="button" class="btn_grid" value="导出Excel" onclick="doexport()"/>
								</td>
							</tr>
						
						</table>
					</form>
	     </div>
		<div region="center" style="text-align:center"  >  
			<table width="90%"  border="0" cellspacing="0" cellpadding="5"  >
			  <tr>
			    <td align="center" class="reportTitle" height="50" colspan="2" > 应用版本统计报表 </td>
			  </tr>
			  <tr id="idtblhead"style="display:none">
			    <td colspan="2"> 查询日期：<label id="Idquerytm"></label> </td>
			  </tr>
			</table>
			
			<table width="100%"  border="0" cellspacing="0" cellpadding="5" class="report" id="tbl" >
			
			</table>
			<div id="pp" style="background:#efefef;border:1px solid #ccc;" ></div>
	   </div>
	    
</body>

</html>
