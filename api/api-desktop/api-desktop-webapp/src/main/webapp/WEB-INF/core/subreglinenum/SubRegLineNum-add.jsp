<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String maxNum = request.getParameter("maxnum");
Integer max = 0;
if(maxNum !=null && !maxNum.trim().equals("")){
	max = Integer.parseInt(maxNum.trim());
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
<head>
  <base href="<%=basePath%>">
  <base target="_self">
	<title>新增分公司线路</title>
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
		function queryOneLevelReg(regId,regName){
			var retValue=openDialogFrame(getRootPath()+"/core/reginfo/RegInfo-queryonelevel.jsp?lineFlag=1","","600","300");
			if(retValue!=undefined){
				
				//var reg = retValue.split("_");
				var flag = checkPKIsExist("regId",retValue.reg_id,"listSubRegLineNumForPageCount");
				if(flag=="true"){
					msgShow("提示","您所选择的分支机构已经存在记录，请重新选择!!!","error");
				}else{
					$('#'+regId).val(retValue.reg_id);
					$('#'+regName).val(retValue.reg_name);
				}
				
			}
  		}
		function clearOneLevelReg(regId,regName){
			$('#'+regId).val('');
			$('#'+regName).val('');
		}
		 
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addSubRegLineNum(){
			$('#ff').form('submit',{
		        url:'addSubRegLineNum.do',
			    onSubmit:function(){
			    	var regName=$("#idRegName").val();
			    	if(regName=null||regName==""){
			    		alert("请选择分支机构！");
			    		return false;
			    	}
			    	$('#idRegName').attr('disabled',false);
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
		
		function checkID(){
		//alert("11111");
			var flag = checkPKIsExist("regId",$("#idRegId").val(),"listSubRegLineNumForPageCount");
			if(flag==true){
				msgShow("提示","您所选择的分支机构已经存在记录!!!","error");
			}
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
								<td>线路数<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" validType="numberMax[<%=max%>]" required="true"     name="LINE_NUMBER" id="idLineNumber" maxlength="2"  />
								</td>
							</tr>
							<tr>
								<td>分支机构<font color="red">*</font></td>
								<td>
									<input type="hidden"   name="REG_ID" id="idRegId" />
									<input type="text" class="easyui-validatebox" readonly="readonly" readonly disabled="disabled" name="REG_NAME" id="idRegName" onchange="checkID()"  />
									
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryOneLevelReg('idRegId','idRegName');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearOneLevelReg('idRegId','idRegName');"/>
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addSubRegLineNum()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
