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
	<title>修改ERP终端型号</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
    <script type="text/javascript" src="core/modelrelation/ModelRelation-js.js"></script>
	<script type="text/javascript">
		  var k=window.dialogArguments; 
		  if(k.par){
		    //初始化数据
		  	var param=k.par;
			$.getJSON("queryModelRelation.do",param,function(data){
			
				 if(data.idFidSelect){//对idFidSelect(厂商）进行赋值
				     var option;
				     for(var i = 0 ; i< data.idFidSelect.length; i++){
				        option  = new Option(data.idFidSelect[i].F_NAME,data.idFidSelect[i].FID);                       
		                      document.getElementById("idFidSelect").options.add(option);
				     }
				 }
				 if(data.idModelSelect){
				 	var option;
				     for(var i = 0 ; i< data.idModelSelect.length; i++){
				        option  = new Option(data.idModelSelect[i].MID_NAME,data.idModelSelect[i].MID);                       
		                      document.getElementById("idMidSelect").options.add(option);
				     }
				 }
			
				 
		   $.each(data.rows,function(idx,item){
			$("#idMidSelect").val($.trim(item.MID));
			$("#erpModelId").val($.trim(item.ERP_MODEL_ID));
			$("#idFidSelect").val(item.FID); 
			$("#descTxt").val($.trim(item.DESC_TXT));
				});
            }); 
            
         }
		
	    setModuleNameAndId();  

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addModelRelation(){
			$('#ff').form('submit',{
		        url:'updateModelRelation.do',
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
<body class="easyui-layout" fit="true" >
					<div region="center"  fit="true" title="信息录入" >
						<form id="ff" method="post">
						<table class="formTable" style="width:100%;">
				<col  width="100px" class="leftCol"/>
				<col width="200px" > 

						
							<tr>
								<td>终端厂商<font color="red">*</font></td>
								<td>
									<select type="text"  class="easyui-validatebox"   required="true"   name="FID" id="idFidSelect" maxlength="15" style="width: 50%" >
									  <option value="">请选择终端厂商</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>主机型号<font color="red">*</font></td>
								<td>
									<select  name="MID" id="idMidSelect" required="true"  maxlength="20" style="width: 70%" >
									 <option value="">请选择主机型号</option>
									</select>
								</td>
								
							</tr>
							<tr>
								<td>ERP终端型号<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox readonly" readonly="readonly" name="ERP_MODEL_ID" id="erpModelId" maxlength="4"  style="width: 70%" />
								</td>
							</tr>
							<tr>
								<td>说明</td>
								<td>
									<textarea type="text" class="easyui-validatebox"  cols="40" rows="4"  name="DESC_TXT" id="descTxt" maxlength="100"  validType="maxLen[100]"  style="overflow: auto;"  ></textarea>
								</td>
							</tr>
							
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addModelRelation()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>

	
