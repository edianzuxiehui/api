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
	<title>新增实体终端</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript" src="core/posdevinfo/PosDevInfo-js.js"></script>
		<script type="text/javascript">
		setModuleNameAndId();
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addPosDevInfo(){
			$('#ff').form('submit',{
		        url:'addPosDevInfo.do',
			    onSubmit:function(){
			        return $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       //这种方式直接关闭窗口，返回true或者false给主窗口
			       // window.close();
			       // window.returnValue=myObject.status; 
			        
			        //这种错误情况下方式不关闭窗口	 
			       if(myObject.status=="true"){
						 window.close();
			        	 window.returnValue=myObject.status; 
			        }else if(myObject.status=="false"){
			        	msgShow("新增",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		}

	</script>
</head>
<body class="easyui-layout" fit="true" onload="defaultQueryReg();">
		<div region="center"  fit="true" title="信息录入" >
			<form id="ff" method="post">
			 <table class="formTable" style="width:100%;">
				<col  width="30%" class="leftCol"/>
				<col width="70%" >
							<tr>
								<td>厂商<font color="red">*</font></td>
								<td>
									<select  name="FID" id="idFidSelect" maxlength="15" style="width:53%" onchange="changeModelByFID(this.value);">
									   <option value="">请选择终端厂商</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>终端型号名称<font color="red">*</font></td>
								<td>
									<select type="text" class="easyui-validatebox" required="true" name="MID" id="idMidSelect" maxlength="20" style="width:53%" required="true">
									 <option value="">请选择主机型号</option>
									</select>
								</td>
							<tr>
								<td>硬件序列号<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="numberorchar" name="SERIAL_NO" id="idSerialNo" maxlength="30" />
								</td>
							</tr>
							<tr>
								<td>分支机构<font color="red">*</font></td>
								<td>
									<input type="hidden" class="easyui-validatebox"  required="true" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId"/>
									<input type="text" class="easyui-validatebox"  required="true" style="background-color: #EEEEEE" readonly name="REG_ID" id="idRegName" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId');"/>
								</td>
							</tr>
							<tr><td>备注</td>
								<td>
									<textarea class="easyui-validatebox" rows="3" cols="25" onkeyup="return limitMaxByte(this,this.maxlength)" name="DESC_TXT" id="idDescTxt" maxlength="100"></textarea>
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addPosDevInfo()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="cleardata()">重置</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
