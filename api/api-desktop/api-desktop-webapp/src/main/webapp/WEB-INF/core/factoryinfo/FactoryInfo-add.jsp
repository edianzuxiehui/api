<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
	<head>
		<base href="<%=basePath%>">
		<base target="_self">
		<title>新增厂商</title>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>themes/default/easyui.css">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>themes/icon.css">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>css/default.css">
		<script type="text/javascript"
			src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>js/jquery.easyui.min.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
        <script type="text/javascript" src="core/factoryinfo/FactoryInfo-js.js"></script>

		<script type="text/javascript">
			setModuleNameAndId();
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addFactoryInfo(){

		   if($("#idExist").val() =="true"){
			   msgShow("提示","您所输入的终端厂商编号已经存在，请修改!!!","error");
		       return;
		    }
			$('#ff').form('submit',{
		        url:'addFactoryInfo.do',
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
		<div region="center" fit="true" title="信息录入">

			<form id="ff" method="post">
				<table class="formTable" style="width: 100%;">
					<col width="70px" class="leftCol" />
					<col width="250px">
					<col width="70px" class="leftCol" />
					<col width="250px">
					<tr>
						<td>
							厂商编号<font color="red">*</font>
						</td>
						<td>
							<input type="text" class="easyui-validatebox" required="true"
								name="FID" id="idFid" maxlength="15"  validType="numberorchar"  onchange="checkExistFactoryInfo(this.value);"/>
						   <input type="hidden"  value="" id="idExist">
						</td>

						<td>
							厂商名称<font color="red">*</font>
						</td>
						<td>
							<input type="text" class="easyui-validatebox" name="F_NAME"  required="true"
								id="idFName" maxlength="30" validType="maxLenAndNotNull[30]" />
						</td>
					</tr>


					<tr>
						<td>
							厂商地址
						</td>
						<td>
							<input type="text" class="easyui-validatebox" name="F_ADDR" 
								id="idFAddr" maxlength="200" validType="maxLen[200]" />
						</td>

						<td>
							联系人
						</td>
						<td>
							<input type="text" class="easyui-validatebox" name="CONNECTER"
								id="idConnecter" maxlength="40" validType="maxLen[40]" />
						</td>
					</tr>
					<tr>
						<td>
							商务电话
						</td>
						<td>
							<input type="text" class="easyui-validatebox" name="BUS_TELE_NO"
								id="idBusTeleNo" maxlength="20"  validType="phoneOrMobile" />
						</td>

						<td>
							支持电话
						</td>
						<td>
							<input type="text" class="easyui-validatebox" name="SUP_TELE_NO"
								id="idSupTeleNo" maxlength="20" validType="phoneOrMobile" />
						</td>
					</tr>
					<tr>
						<td>
							传真
						</td>
						<td>
							<input type="text" class="easyui-validatebox" name="FAX_NO"
								id="idFaxNo" maxlength="20" validType="faxno"  />
						</td>

						<td>
							邮政编码
						</td>
						<td>
							<input type="text" class="easyui-validatebox" name="POST_CODE"
								id="idPostCode" maxlength="6" validType="zip" />
						</td>
					</tr>
					<tr>
					    <td >
							JAVA插件<font color="red">*</font>
						</td>
						<td colspan="3">
							<input type="text" class="easyui-validatebox" name="PLUG_NAME"
								id="idPlugName" maxlength="100" validType="isHalfCharsForFactory" class="easyui-validatebox" required="true" style="width:250px" />
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
		<div region="south" style="text-align: right;" class="toolbarHeader">
			<a class="easyui-linkbutton" iconCls="icon-ok"
				href="javascript:void(0)" onclick="addFactoryInfo()">确认</a>
			<a class="easyui-linkbutton" iconCls="icon-redo"
				href="javascript:void(0)" onclick="cleardata()">重置</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel"
				href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
		</div>
	</body>
</html>
