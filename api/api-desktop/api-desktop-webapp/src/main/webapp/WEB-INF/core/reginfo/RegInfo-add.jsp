<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="javax.print.DocFlavor.STRING"%>
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
	<title>新增分支机构</title>
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
		
		$(function(){
			getSequence("REGID","idRegId");
		});
		
		function addRegInfo(){
			var regId = $('#idRegId').val();
			 var flag =  checkPKIsExist("regId",regId,"listRegInfoForPageCount");
			if(flag=="true"){
				 msgShow("提示","您所输入的分支机构编码已经存在，请修改!!!","error");
				 return ;
			}
			//var erpRegId = $('#erpRegId').val();
			 //var flag =  checkPKIsExist("erpRegId",erpRegId,"checkExistRelationInfo");
			//if(flag=="true"){
			//	 msgShow("提示","您所输入的ERP分支机构编码已经存在，请修改!!!","error");
			//	 return ;
			//}
			
			$('#ff').form('submit',{
		        url:'addRegInfo.do',
			    onSubmit:function(){
			    	var flag= $(this).form('validate');
			    	if(flag){
			    		showProcess(true,"新增分支机构","增加分支机构中...");
			    	}
			        return flag;
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       //这种方式直接关闭窗口，返回true或者false给主窗口
			       // window.close();
			       // window.returnValue=myObject.status; 
			        
			       		showProcess(false);
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
		
		function check(value){
			var flag =  checkPKIsExist("regId",value,"listRegInfoForPageCount");
			if(flag=="true"){
				msgShow("提示","您所输入的机构编码已经存在，请修改!!!","error");
			}else if(flag ="false") {
				
			}else{
				msgShow("提示","验证输入机构编码异常，请联系管理员!!!","error");
			}
	
		}
	</script>
</head>
<body class="easyui-layout" fit="true">
					<div region="center"  fit="true" title="信息录入" >
						<form id="ff" method="post">
						<table class="formTable" style="width:100%;">
				<col  width="80px" class="leftCol"/>
				<col width="200px" >

							<tr>
								<td>分支机构编号<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="number"   name="REG_ID" id="idRegId" value="" maxlength="8" onchange="check(this.value);" />
								</td>
							</tr>
							<tr>
								<td>分支机构名称<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="maxLen[30]"   name="REG_NAME" id="idRegName" maxlength="30" />
								</td>
							</tr>
							<tr>
								<td>上级分支机构<font color="red">*</font></td>
								<td>
									<input type="hidden" class="easyui-validatebox"  readonly="readonly"   name="UP_REG_ID" id="idUpRegId"  />
									<input type="hidden" class="easyui-validatebox"  readonly="readonly"   name="UP_REG_ENTIRE_ID" id="idUpRegEntireId"  />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" required="true" readonly="readonly"   name="UP_REG_NAME" id="idUpRegName"  />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idUpRegId','idUpRegName','idUpRegEntireId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idUpRegId','idUpRegName','idUpRegEntireId');"/>
								</td>
							</tr>
							
							<tr>
								<td>备注</td>
								<td>
									<textarea  class="easyui-validatebox"  rows="3" cols="25" validType="maxLen[100]"    name="DESC_TXT" id="idDescTxt"  ></textarea>
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addRegInfo()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
