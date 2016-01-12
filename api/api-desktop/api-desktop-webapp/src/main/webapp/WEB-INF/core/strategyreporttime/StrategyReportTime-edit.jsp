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
	<title>修改策略报道时间</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
    <script type="text/javascript" src="core/strategyreporttime/StrategyReportTime-js.js"></script>

		<script type="text/javascript">
		  var k=window.dialogArguments; 
		  if(k.par){
		  	var param=k.par;
			$.getJSON("queryAposInfo.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idAposId").val($.trim(item.APOS_ID));
			$("#idInputTime").val($.trim(item.INPUT_TIME));
			$("#idNextSignTime").val($.trim(item.NEXT_SIGN_TIME));
			$("#idIntervalDays").val(item.INTERVAL_DAYS);
			$("#idLastSignEndTime").val($.trim(item.LAST_SIGN_END_TIME));
			$("#idFrtimes").val(item.FRTIMES);
				});
            }); 
            
         }
		   setModuleNameAndId();

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function updateAposInfo(){
		
			$('#ff').form('submit',{
		        url:'strategyReportTime_UpdateAposInfo.do',
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
					<div region="center"  fit="true" title="修改应用终端报道周期" >
						<form id="ff" method="post">
						<table class="formTable" style="width:100%;">
				<col  width="140px" class="leftCol"/>
				<col width="250px" >

							<tr>
								<td>应用终端号</td>
								<td>
									<input type="text" class="easyui-validatebox"   required="true"  style="background-color: #EEEEEE"    name="APOS_ID" id="idAposId" maxlength="10" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td>下次报到时间</td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" style="background-color: #EEEEEE"   name="NEXT_SIGN_TIME" id="idNextSignTime" maxlength="19" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td>下次报到截止时间</td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" style="background-color: #EEEEEE"   name="LAST_SIGN_END_TIME" id="idLastSignEndTime" maxlength="19" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td>报到间隔周期（天数）</td>
								<td>
									<input type="text" class="easyui-validatebox"  required="true"   validType="integer"  name="INTERVAL_DAYS" id="idIntervalDays"  maxlength="2"/>
								</td>
							</tr>
							<tr>
								<td>重拨次数</td>
								<td>
									<input type="text" class="easyui-validatebox"  required="true"   validType="must_one_two_three" name="FRTIMES" id="idFrtimes" maxlength="1" />
								</td>
							</tr>
						
							
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="updateAposInfo();">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
