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
	<title>修改实体终端</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript" src="core/aposbind/PosDevInfo-js.js"></script>
	<script type="text/javascript" src="core/aposbind/ModelInfo-js.js"></script>
	<script type="text/javascript" src="core/aposbind/UpdateAPMSComm-js.js"></script>
    <script type="text/javascript">
		setModuleNameAndId();
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addPosDevInfo(){
			$('#ff').form('submit',{
		        url:'updateAPMSPosDev.do',
			    onSubmit:function(){
			        return $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       
			        
			        //这种错误情况下方式不关闭窗口	 
			       if(myObject.status=="true"){
			       		 parent.$('#idMid').attr("value",$('#idMidSelect').val());
						 msgShow("修改","修改实体终端成功，请点击【下一步】修改应用终端","info");
			        }else if(myObject.status=="false"){
			        	msgShow("修改",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		}
		
	</script>
</head>
<body class="easyui-layout" fit="true">
		<div region="center"  fit="true" title="信息录入" >
			<form id="ff" method="post">
				<table class="formTable" style="width:95%;">
				<col  width="30%" class="leftCol"/>
				<col width="70%" >

						<!-- 	<tr>
								<td>终端编号</td>
								<td>
									<input type="text" class="readonly" readonly  name="DEV_ID" id="idDevId" maxlength="12" />
								</td>
							</tr>
 					-->
 					<input type="hidden" name="DEV_ID" id="idDevId"/>
							<tr>
								<td>厂商</td>
								<td>
									<select  name="FID" id="idFidSelect" maxlength="15" style="width:53%" onchange="changeModelByFID(this.value);">
									   <option value="">请选择终端厂商</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>主机型号</td>
								<td>
									<select type="text" class="easyui-validatebox" required name="MID" id="idMidSelect" maxlength="20" style="width:53%" required="true">
									 <option value="">请选择主机型号</option>
									</select>								
									<!--  <select   name="MID" id="idMidSelect" maxlength="20" style="width:30%" required="true">
									</select>-->
								</td>
							</tr>
							<tr>
								<td>硬件序列号</td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="numberorchar" name="SERIAL_NO" id="idSerialNo" maxlength="30" />
								</td>
							</tr>
							<tr>
								<td>分支机构</td>
								<td>
									<input type="hidden"   name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId"/>
									<input type="text" class="easyui-validatebox"  required="true" style="background-color: #EEEEEE" readonly name="REG_ID" id="idRegName" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId');"/>
								</td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<textarea class="easyui-validatebox" rows="3" cols="25" onkeyup="return limitMaxByte(this,this.maxlength)" name="DESC_TXT" id="idDescTxt" maxlength="100"></textarea>
								</td>
							</tr>
						</table>	
			</form>
	  </div>
					<div region="south"   style="text-align:right;height:45px;" class="toolbarHeader">
						<input type="button" id="idCommitBtn" class="btn_grid" style="height:30px;font-size: 15px;" value=" 确 认 " onclick="addPosDevInfo()"/>
						<input type="button" id="idNextBtn" class="btn_grid" style="height:30px;font-size: 15px;" value=" 下一步 " onclick="doNext()"/>
					</div>
</body>
</html>
