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
  <base target="_self">
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
    <script type="text/javascript" src="core/rptaposmodel/RptAposModel-js.js"></script>
	<script type="text/javascript">
				
		
		
		function queryInfo(){
			if(!$('#queryForm').form('validate')) return false;
			if($('#idBeginDate').val()!="" && $('#idEndDate').val()!="" && $('#idBeginDate').val()>$('#idEndDate').val()){
				msgShow("提示","选择的开始时间大于结束时间，请重新选择!","info");
			}else{
				  var time="";
				  var beginDate = $.trim($('#idBeginDate').val());
				  if(beginDate!=""){
				  	time = beginDate+" - ";
				  }else{
				  	time = "截止";
				  }
				  var endDate = $.trim($('#idEndDate').val());
				  if(endDate!=""){
				  	time += endDate;
				  }
				  $("#Idquerytm").html(time);
				  $("#tbl").empty();
				  $("#idtblhead").show();
				  //$('#idplanbody').layout('collapse','north');
				  var date=new Date();
				  var  param="flag="+date.getTime()+"&REG_ENTIRE_ID="+escape(escape($.trim($('#idRegEntireId').val())))+"&BEGIN_DATE="+escape(escape(beginDate))+"&END_DATE="+escape(escape(endDate));			   
				  $.getJSON("listRptAposModel.do?"+param, function(data){
				  	if(data!=null) {
				  		var midArray = new Array();
				  		var midNameArray = new Array();
				  		for(var i=0; i<data.rows.length; i++) {
				  			var mid = data.rows[i].MID;
				  			var midName = data.rows[i].MID_NAME;
				  			
				  			if(getIndexFromArray(midArray,mid)==-1) {
				  				midArray.push(mid);
				  				midNameArray.push(midName);
				  			}
				  		}
				  		
				  		//转换生成结果数据
				  		var rowsArray = new Array();
				  		for(var i=0; i<data.rows.length; i++) {
				  			var row = data.rows[i];
				  		
				  			var o;
				  			var flag = false; //是否新增数组元素
				  			if(rowsArray.length==0 || rowsArray[rowsArray.length-1].reg_id!= row.REG_ID) {
				  				o = new Object();
				  				o.reg_id = row.REG_ID;
				  				o.reg_name = row.REG_NAME;
				  				o.dist = new Array(midArray.length);
				  				initNumberArray(o.dist);//初始化数组
				  				
				  				flag = true;
				  			}else{
				  				o = rowsArray[rowsArray.length-1];
				  			}
				  			
				  			var index = getIndexFromArray(midArray,row.MID);
				  			o.dist[index]=row.COUNT;
				  			
				  			if(flag) {
				  				rowsArray.push(o);
				  			}
				  		}
				  		
				  		//显示结果数据
				  		var html = '<thead bgcolor="#EEEEEE"><th>分支机构</th>';
				  		for(var i=0; i<midNameArray.length; i++) {
				  			html += '<th>'+midNameArray[i]+'</th>';
				  		}
				  		html += '<th>总计</th></thead>';
				  		$("#tbl").append(html);
				  		for(var i=0; i<rowsArray.length; i++) {
				  			var o = rowsArray[i];
				  			var str = '<tr><td>'+o.reg_name+'</td>';
				  			for(var j=0;j<o.dist.length;j++) {
				  				if(o.dist[j]=='0'){
				  					str +='<td>'+o.dist[j]+'</td>'
				  				}else{
				  					str += '<td><a href="javascript:void(0)" style="color:blue;text-decoration:none;" onclick="viewDetails(\''+o.reg_id+'\',\''+o.reg_name+'\',\''+midArray[j]+'\',\''+midNameArray[j]+'\',\''+beginDate+'\',\''+endDate+'\')">'+o.dist[j]+'</a></td>';
				  				}
				  			}
				  			str += '<td>'+sumArray(o.dist)+'</td></tr>';
				  			$("#tbl").append(str);
				  		}
				  	}else{
				  		msgShow('提示','查询数据出错','error');
				  	}
				  });
			}
		}
		
		function viewDetails(reg_id,reg_name,mid,mid_name,beginDate,endDate) {
    	  	var param={'REG_ID':reg_id,'REG_NAME':reg_name,'BEGIN_DATE':beginDate,'END_DATE':endDate,'MID':mid,'MID_NAME':mid_name};
		  	openDialogFrame(getRootPath()+'/core/rptaposmodel/RptAposModel-detail.jsp',param,"900","540");
		}
		
		//从数组中返回item的索引，不存在返回-1
		function getIndexFromArray(array,item) {
			for(var i=0; i<array.length; i++) {
				if(array[i]==item) return i;
			}
			return -1;
		}
		
		//数组和，数组array必须为数值数组
		function sumArray(array) {
			var sum = 0;
			for(var i=0; i<array.length; i++) {
				sum += array[i];
			}
			return sum;
		}
		
		//初始化数值数组的元素为0
		function initNumberArray(array) {
			for(var i=0; i<array.length; i++) {
				array[i] = 0;
			}
		}
		
		function cleardata(){
			$('#queryForm').form('clear');
			
			defaultQueryReg();
		         var d=new Date();
		         var starttm = d.Format("YYYY-MM-DD");  
		         $("#idEndDate").val(starttm);
		}
	</script>
</head>

<body class="easyui-layout" id="idplanbody"  >
<script type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
	    <div  region="north" style="height: 50px;position:relative;background:#EEEEEE" title=""   split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col width="7%" class="leftCol"/>
				<col width="22%" >
				<col  width="7%" class="leftCol"/>
				<col width="18%" >
				<col  width="7%" class="leftCol"/>
				<col width="18%" >
				<col width="26%">

				
							<tr>
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden"   name="REG_ENTIRE_ID" id="idRegEntireId" maxlength="50" />
									<input type="text" class="easyui-validatebox" size="15" required="true" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>

								</td>
							
								<td>开始时间</td>
								<td>
								<input name="BEGIN_DATE" id="idBeginDate" class="Wdate" type="text"  onClick="WdatePicker()" readonly="reandonly" >
								</td>
							
								<td>结束时间</td>
								<td>
								<input name="END_DATE" id="idEndDate" class="Wdate" required="true" type="text"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="reandonly" >
								</td>
								<td >
									<input id="idQuery" type="button" class="btn_grid" value="查 询" style="height:24px;" onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 "  style="height:24px;"  onclick="cleardata()"/>
									<input id="idToExcel" type="button" class="btn_grid" value="导出Excel" style="height:24px;" onclick="excelExport()"/>
								</td>
							</tr>
						
							
							
						</table>
					</form>
	     </div>
		<div region="center" style="text-align:center"  >  
			<table width="90%"  border="0" cellspacing="0" cellpadding="5"  >
			  <tr>
			    <td align="center" class="reportTitle" height="50" colspan="2" > 终端型号分布统计报表 </td>
			  </tr>
			  <tr id="idtblhead"style="display:none">
			    <td colspan="2"> 查询日期：<label id="Idquerytm"></label> </td>
			  </tr>
			</table>
			
			<table width="90%"  border="0" cellspacing="0" cellpadding="5" class="report" id="tbl" >
			
			</table>
	   </div>
	    
</body>

</html>
