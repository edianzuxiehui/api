<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String regIdAndRegName = (String)request.getSession().getAttribute("regIdAndRegName");
String regName = regIdAndRegName.substring(0,regIdAndRegName.indexOf("(")).trim();
String regId = regIdAndRegName.substring(regIdAndRegName.indexOf("(")+1,regIdAndRegName.length()-1).trim();

String regEntireId = (String)request.getSession().getAttribute("regEntireId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
<head>
  <base href="<%=basePath%>">
  <base target="_self">
	<title>新增权限组</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>

		<script type="text/javascript">
		setModuleNameAndId();
		 
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addRealrole(){
			$('#ff').form('submit',{
		        url:'addRealrole.do',
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
<body class="easyui-layout" fit="true">
					<div region="center"  fit="true" title="信息录入" >
						<form id="ff" method="post">
						<table class="formTable" style="width:100%;">
				<col  width="50px" class="leftCol"/>
				<col width="250px" >

							<tr>
								<td>权限组名<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" validType="maxLen[20]" required="true" name="NAME" id="idName" />
								</td>
							</tr>
							<tr>
								<td>分支机构<font color="red">*</font></td>
								<td>
									<input type="hidden" name="REG_ID" id="idRegId" value="<%=regId %>" />
									<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId" value="<%=regEntireId %>"/>
									<input type="text" class="easyui-validatebox readonly"  required="true" name="REG_NAME" id="idRegName" value="<%=regName %>" readonly/>
									<input type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
									<input type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId')"/>
									
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addRealrole()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="cleardata()">重置</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
