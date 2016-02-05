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
	<title>修改商户</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	 <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
    <script type="text/javascript" src="core/merchinfo/MerchInfo-js.js"></script>

		<script type="text/javascript">
		
		  var k=window.dialogArguments; 
		 // initDataForMerchInfo('idMerchStatus');
		  if(k.par){
		  	var param=k.par;
			$.getJSON("queryMerchInfo.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idMerchId").val($.trim(item.MERCH_ID));
			$("#idOrgId").val($.trim(item.ORG_ID));
			$("#idOrgName").val($.trim(item.ORG_NAME));
			//$("#idSubId").val($.trim(item.SUB_ID));
			$("#idMerchName").val($.trim(item.MERCH_NAME));
			//$("#idMerchAttr").val($.trim(item.MERCH_ATTR));
			$("#idMerchMcc").val($.trim(item.MERCH_MCC));
			$("#idConnecter").val($.trim(item.CONNECTER));
			$("#idOperCallno").val($.trim(item.OPER_CALLNO));
			//$("#idFaxNo").val($.trim(item.FAX_NO));
			//$("#idEmail").val($.trim(item.EMAIL));
			//$("#idPostCode").val($.trim(item.POST_CODE));
			//$("#idMerchStatus").val($.trim(item.MERCH_STATUS));
			$("#idDescTxt").val($.trim(item.DESC_TXT));
			$("#idMerchAddr").val($.trim(item.MERCH_ADDR));
			$("#idRegId").val($.trim(item.REG_ID));
			$("#idRegName").val($.trim(item.REG_NAME)+"("+$.trim(item.REG_ID)+")");
			$("#idRegEntireId").val($.trim(item.REG_ENTIRE_ID));
			
			
				});
            }); 
            
         }
		  
        setModuleNameAndId(); 
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addMerchInfo(){
			$('#ff').form('submit',{
		        url:'updateMerchInfo.do',
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
					<div region="center"  fit="true" title="信息录入" >
						<form id="ff" method="post">
					<table class="formTable" style="width:100%;">
			            <col  width="5%" class="leftCol"/>
						<col width="10%" >
						<col  width="3%" class="leftCol"/>
						<col width="10%" >
							<tr>
								<td>商户编码<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true"  style="background-color: #EEEEEE" name="MERCH_ID" id="idMerchId" maxlength="15" readonly="readonly"/>
								</td>
								
								<td>商户名称<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox"  validType="maxLenAndNotNull[80]" required="true"  name="MERCH_NAME" id="idMerchName" maxlength="80" />
								</td>
						
							</tr>
							
							<tr><!-- 
								<td>分店编号<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="number"  name="SUB_ID" id="idSubId" maxlength="5" readonly="readonly" style="background-color: #EEEEEE"/>
								</td>
							
								<td>商户属性</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="MERCH_ATTR" id="idMerchAttr" maxlength="1" />
								</td> -->
								
								<td>分支机构<font color="red">*</font></td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly"   required="true"/>
									<input type="hidden" class="easyui-validatebox"    name="REG_ENTIRE_ID" id="idRegEntireId" maxlength="8" />
							<!-- <input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
								    
								<td>网络接入服务商<font color="red">*</font></td>
								<td>
									<input type="hidden" id="idOrgId" type="text" readonly="readonly"  class="easyui-validatebox"  required="true"   name="ORG_ID"/>
									<input  id="idOrgName" type="text" readonly="readonly"  class="easyui-validatebox"  style="background-color: #EEEEEE" required="true" />
								</td> -->
								
								<td>商户MCC</td>
								<td>
									<input type="text" class="easyui-validatebox readonly"  validType="numberorchar" readonly="readonly" name="MERCH_MCC" id="idMerchMcc" maxlength="4" />
								</td>
							</tr>
							<tr>
								
						      <!--
						        <td>商户状态<font color="red">*</font></td>
								<td>
								   <select   name="MERCH_STATUS"   id="idMerchStatus"  class="easyui-validatebox"  style="width: 70%"  required="true"   >
									 <option value="">请选择商户状态</option>
							       </select>
								</td>-->
								 <td>联系人</td>
								<td>
									<input type="text" class="easyui-validatebox"  validType="maxLen[40]"  name="CONNECTER" id="idConnecter" maxlength="40" />
								</td>
					            <td>联系电话</td>
								<td>
									<input type="text" class="easyui-validatebox"  validType="phoneOrMobile"   name="OPER_CALLNO" id="idOperCallno" maxlength="20" />
								</td>
							</tr>
							
							
							<tr>
								<td>商户地址</td>
								<td>
									<input type="text" class="easyui-validatebox" validType="maxLen[122]"    name="MERCH_ADDR" id="idMerchAddr" maxlength="255" />
								</td>
								<td>备注</td>
								<td>
									<textarea type="text" cols="25" class="easyui-validatebox" validType="maxLen[100]"    name="DESC_TXT" id="idDescTxt" maxlength="100" ></textarea>
								</td>
								<!--
								 <td>传真</td>
								<td>
									<input type="text" class="easyui-validatebox"  validType="faxno" name="FAX_NO" id="idFaxNo" maxlength="20" />
								</td>-->
							</tr>
							
							<!--
							<tr>
							   
								<td>Email地址</td>
								<td>
									<input type="text" class="easyui-validatebox"   validType="email" validType="maxLen[80]"   name="EMAIL" id="idEmail" maxlength="80" />
								</td>
								
								<td>邮政编码</td>
								<td>
									<input type="text" class="easyui-validatebox"   validType="zip"  name="POST_CODE" id="idPostCode" maxlength="6" />
								</td>
							</tr>-->
							
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addMerchInfo()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
