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
	<title>修改商户</title>
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
			$.getJSON("queryDatalogLine.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idSysId").val($.trim(item.SYS_ID));
			$("#idOccurDate").val($.trim(item.OCCUR_DATE));
			$("#idTableName").val($.trim(item.TABLE_NAME));
			$("#idOpType").val($.trim(item.OP_TYPE));
			$("#idModuleid").val(item.MODULEID);
			$("#idLogData").val($.trim(item.LOG_DATA));
			$("#idRegId").val($.trim(item.REG_ID));
			$("#idOperId").val($.trim(item.OPER_ID));
				});
            }); 
            
         }
		  

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addDatalogLine(){
			$('#ff').form('submit',{
		        url:'updateDatalogLine.do',
			    onSubmit:function(){
			        return $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			        //alert(myObject.status);
			        if(myObject.status=="true"){
						 window.close();
			        	 window.returnValue=myObject.status; 
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
							<tr>
								<td>系统内部编号(使用序列生成的编号)</td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" style="width:90%;"  name="SYS_ID" id="idSysId" maxlength="10" />
								</td>
							</tr>
							<tr>
								<td>发生日期</td>
								<td>
									<input type="text" class="easyui-validatebox"  style="width:90%;"  name="OCCUR_DATE" id="idOccurDate" maxlength="24" />
								</td>
							</tr>
							<tr>
								<td>数据表名</td>
								<td>
									<input type="text" class="easyui-validatebox"  style="width:90%;"  name="TABLE_NAME" id="idTableName" maxlength="50" />
								</td>
							</tr>
							<tr>
								<td>数据操作类型</td>
								<td>
									<input type="text" class="easyui-validatebox"  style="width:90%;"  name="OP_TYPE" id="idOpType" maxlength="2" />
								</td>
							</tr>
							<tr>
								<td>模块ID</td>
								<td>
									<input type="text" class="easyui-validatebox"  style="width:90%;"  name="MODULEID" id="idModuleid"  />
								</td>
							</tr>
							<tr>
								<td>操作数据</td>
								<td>
									<input type="text" class="easyui-validatebox"  style="width:90%;"  name="LOG_DATA" id="idLogData" maxlength="640" />
								</td>
							</tr>
							<tr>
								<td>分支机构编号</td>
								<td>
									<input type="text" class="easyui-validatebox"  style="width:90%;"  name="REG_ID" id="idRegId" maxlength="8" />
								</td>
							</tr>
							<tr>
								<td>操作员编号</td>
								<td>
									<input type="text" class="easyui-validatebox"  style="width:90%;"  name="OPER_ID" id="idOperId" maxlength="8" />
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addDatalogLine()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
