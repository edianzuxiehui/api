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
	<title>修改分支机构</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>

		<script type="text/javascript">
		  var k=window.dialogArguments; 
		  if(k.par){
		  	var param=k.par;
			$.getJSON("queryRegInfo.do",param,function(data){
				$.each(data.rows,function(idx,item){
				$("#idRegId").val($.trim(item.REG_ID));
				$("#idRegName").val($.trim(item.REG_NAME));
				$("#idUpRegId").val($.trim(item.UP_REG_ID));
				$("#idOldUpRegId").val($.trim(item.UP_REG_ID));
				$("#idUpRegName").val($.trim(item.UP_REG_NAME));
				$("#idDescTxt").val($.trim(item.DESC_TXT));
				$("#idOldRegEntireId").val($.trim(item.REG_ENTIRE_ID));
			//$("#erpRegId").val($.trim(item.ERP_REG_ID))
				});
            }); 
            
         }
		  setModuleNameAndId();

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addRegInfo(){
			//var erpRegId = $('#erpRegId').val();
			var regId = $('#idRegId').val();
			// var flag =  checkPKIsExist("erpRegId|regId",erpRegId+'|'+regId,"checkExistRelationInfo");
			//if(flag=="true"){
			//	 msgShow("提示","您所输入的ERP分支机构编码已经存在，请修改!!!","error");
			//	 return ;
			//}
			$('#ff').form('submit',{
		        url:'updateRegInfo.do',
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
			        	msgShow("修改",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		}
		
		function queryRegUpdate(regId,regName,regEntireId){
			var upid = $("#idOldUpRegId").attr("value");
			if(upid =="000000"){	
				msgShow("提示","该机构为最上层机构,不允许修改!","error");
			}else{
				var retValue=openDialogFrame(getRootPath()+"/core/reginfo/RegInfo-queryupdate.jsp?upid="+upid,"","400","300");
				if(retValue!=undefined){
				
				$('#'+regId).val(retValue.reg_id);
				$('#'+regName).val(retValue.reg_name);
				if(regEntireId!=undefined) {
					$('#'+regEntireId).val(retValue.reg_entire_id);
				}
				//var reg = retValue.split("_");
					//$('#'+regId).val(reg[0]);
					//$('#'+regName).val(reg[1]);
					//if(regEntireId!=undefined) {
					//	$('#'+regEntireId).val(reg[2]);
					//}
				}
			}
			
  		}
 		function clearRegUpdate(regId,regName,regEntireId){
		 	$('#'+regId).val('');
		 	$('#'+regName).val('');
		 	if(regEntireId!=undefined) {
				$('#'+regEntireId).val('');
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
									<input type="text" class="readonly" required="true" readonly="readonly"   name="REG_ID" id="idRegId" maxlength="8" />
								</td>
							</tr>
							<tr>
								<td>分支机构名称<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="maxLen[30]"    name="REG_NAME" id="idRegName" maxlength="30" />
								</td>
							</tr>
							<tr>
								<td>上级分支机构<font color="red">*</font></td>
								<td>
									<input type="hidden" class="readonly" readonly="readonly"    name="UP_REG_ID" id="idUpRegId" maxlength="8" />
									<input type="hidden" class="readonly" readonly="readonly"    name="REG_ENTIRE_ID" id="idRegEntireId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" required="true" readonly="readonly"   name="UP_REG_NAME" id="idUpRegName"  />
									<!--  
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryRegUpdate('idUpRegId','idUpRegName','idRegEntireId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearRegUpdate('idUpRegId','idUpRegName','idRegEntireId');"/>
									-->
								</td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<input type="hidden" class="readonly" readonly="readonly"    name="OLD_UP_REG_ID" id="idOldUpRegId" maxlength="8" />
									<input type="hidden" class="readonly" readonly="readonly"    name="OLD_REG_ENTIRE_ID" id="idOldRegEntireId" maxlength="8" />
									<textarea  class="easyui-validatebox" rows="3" cols="25" validType="maxLen[100]"    name="DESC_TXT" id="idDescTxt"></textarea>
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
