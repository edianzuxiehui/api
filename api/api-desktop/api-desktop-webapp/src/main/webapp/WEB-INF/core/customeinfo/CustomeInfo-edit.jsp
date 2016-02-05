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
	<title>修改客服经理</title>
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
			$.getJSON("queryCustomeInfo.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idCustomeId").val($.trim(item.CUSTOME_ID));
			$("#idCustomeName").val($.trim(item.CUSTOME_NAME));
			$("#idCustomePw").val($.trim(item.CUSTOME_PW));
			$("#idValiddate").val($.trim(item.VALIDDATE));
			$("#idRetryTime").val(item.RETRY_TIME);
				});
            }); 
            
         }
		 setModuleNameAndId(); 

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addCustomeInfo(){
			if($('#idValiddate').val()==""){
				msgShow("提示","请选择客服有效期","info");
				return;
			}
			var d=new Date();
		    var starttm = d.Format("YYYY-MM-DD hh:mm:ss"); 
		    if($('#idValiddate').val()<starttm){
		    	msgShow("提示","客服有效期不能早于当前时间["+starttm+"]","info");
				return;
		    }
			
			$('#ff').form('submit',{
		        url:'updateCustomeInfo.do',
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

	</script>
</head>
<body class="easyui-layout" fit="true">
<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
					<div region="center"  fit="true" title="信息录入" >
						<form id="ff" method="post">
						<table class="formTable" style="width:100%;">
				<col  width="150px" class="leftCol"/>
				<col width="250px" >
							<tr>
								<td>客服编号<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox readonly" readonly="readonly" required="true"   name="CUSTOME_ID" id="idCustomeId" maxlength="30" />
								</td>
							</tr>
							<tr>
								<td>客服用户名<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox"  required="true"  name="CUSTOME_NAME" id="idCustomeName" maxlength="30" />
								</td>
							</tr>
							<tr>
								<td>客服密码<font color="red">*</font></td>
								<td>
									<input type="password" class="easyui-validatebox" validType="number"  required="true"   name="CUSTOME_PW" id="idCustomePw" maxlength="8" />
								</td>
							</tr>
							<tr>
								<td>客服有效期<font color="red">*</font></td>
								<td>
									<!-- <input type="text"  name="VALIDDATE" id="idValiddate" maxlength="19" class="Wdate readonly easyui-validatebox"  readonly onClick="WdatePicker()" /> -->
									<input name="VALIDDATE" id="idValiddate" class="Wdate" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly>
								</td>
							</tr>
							<tr>
								<td>客服可用次数<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="numberFixLength[1]" maxlength="10"     name="RETRY_TIME" id="idRetryTime"  />
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addCustomeInfo()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
