<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<meta http-equiv="X-UA-Compatible" content="IE=8" >
<html>
<head>
  <base href="<%=basePath%>">
  <base target="_self">
	<title>修改厂商</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
    <script type="text/javascript" src="core/factoryinfo/FactoryInfo-js.js"></script>

		<script type="text/javascript">
		  var k=window.dialogArguments; 
		  if(k.par){
		  	var param=k.par;
		  	
			$.getJSON("queryFactoryInfo.do",param,function(data){
				$.each(data.rows,function(idx,item){
					$("#idFid").val($.trim(item.FID));
					$("#idFName").val($.trim(item.F_NAME));
					$("#idFAddr").val($.trim(item.F_ADDR));
					$("#idConnecter").val($.trim(item.CONNECTER));
					$("#idBusTeleNo").val($.trim(item.BUS_TELE_NO));
					$("#idSupTeleNo").val($.trim(item.SUP_TELE_NO));
					$("#idFaxNo").val($.trim(item.FAX_NO));
					$("#idPostCode").val($.trim(item.POST_CODE));
					$("#idSupportInfo").val($.trim(item.SUPPORT_INFO));
					$("#idPlugName").val($.trim(item.PLUG_NAME));
				});
            }); 
         }
         
        setModuleNameAndId();
		  

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addFactoryInfo(){
			$('#ff').form('submit',{
		        url:'updateFactoryInfo.do',
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
			        	msgShow("更新",myObject.message,"error");
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
				<col  width="70px" class="leftCol"/>
				<col width="250px" >
                 <col  width="70px" class="leftCol"/>
				<col width="250px" >
							<tr>
								<td>厂商编号<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" style="background-color: #EEEEEE"  name="FID" id="idFid" maxlength="15" readonly="readonly"/>
								</td>
							
								<td>厂商名称<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true"  validType="maxLenAndNotNull[30]"   name="F_NAME" id="idFName" maxlength="30" />
								</td>
							</tr>
							<tr>
								<td>厂商地址</td>
								<td>
									<input type="text" class="easyui-validatebox"   validType="maxLen[200]" name="F_ADDR" id="idFAddr" maxlength="200" />
								</td>
							
								<td>联系人</td>
								<td>
									<input type="text" class="easyui-validatebox"  validType="maxLen[40]"  name="CONNECTER" id="idConnecter" maxlength="40" />
								</td>
							</tr>
							<tr>
								<td>商务电话</td>
								<td>
									<input type="text" class="easyui-validatebox" validType="phoneOrMobile"    name="BUS_TELE_NO" id="idBusTeleNo" maxlength="20" />
								</td>
							
								<td>支持电话</td>
								<td>
									<input type="text" class="easyui-validatebox"  validType="phoneOrMobile"   name="SUP_TELE_NO" id="idSupTeleNo" maxlength="20" />
								</td>
							</tr>
							<tr>
								<td>传真</td>
								<td>
									<input type="text" class="easyui-validatebox" validType="faxno"   name="FAX_NO" id="idFaxNo" maxlength="20" />
								</td>
						
								<td>邮政编码</td>
								<td>
									<input type="text" class="easyui-validatebox" validType="zip"   name="POST_CODE" id="idPostCode" maxlength="6" />
								</td>
							</tr>
							<tr>
							
								<td >JAVA插件<font color="red">*</font></td>
								<td colspan="3">
									<input type="text" class="easyui-validatebox" validType="isHalfCharsForFactory"  name="PLUG_NAME" id="idPlugName" maxlength="100" style="width: 250px" required="true"/>
								</td>
							</tr>
							
					<tr>
					<td></td>
                     <td colspan="2">
                                           如:[com.landi.tms.thirdinterface.LandiRule]
                      </td>
                    </tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addFactoryInfo()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
