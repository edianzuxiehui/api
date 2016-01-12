<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.landi.tms.base.IDto"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
IDto person = (IDto)request.getSession().getAttribute("person");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
<head>
  <base href="<%=basePath%>">
  <base target="_self">
	<title>新增广告信息</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>js/DatePicker/skin/WdatePicker.css.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>

		<script type="text/javascript">
		 setModuleNameAndId();
		 defaultQueryReg();
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addPosAdvertising(){
			if($('#idEndDate').val()!=""){
				var d=new Date();
		    	var starttm = d.Format("YYYY-MM-DD"); 
		    	if($('#idEndDate').val()<starttm){
			    	msgShow("提示","结束日期不能早于当前日期["+starttm+"]","info");
					return;
				}
		    }else{
		    	msgShow("提示","请输入结束时间","info");
				return;
		    }
		    var appId = $('#idAppId').val();
		    var merchId = $('#idMerchId').val();
		    var merchIdS = $('#idMerchIdS').val();
		    var regId = $('#idRegId').val(); 
		    if(merchIdS==''){
			    var checkFlag=checkPKIsExist('appId|merchId|regId',appId+"|"+merchId+"|"+regId,'listPosAdvertisingCountForCheck');
				if(checkFlag!="false"){
					msgShow("提示","已存在应用为["+$('#idAppName').val()+"]商户为["+$('#idMerchName').val()+"]分支机构为["+$('#idRegName').val()+"]的记录！！！","info");
					return;
				}
		    }
		
			$('#ff').form('submit',{
		        url:'addPosAdvertising.do',
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
		function queryApp(idAppId,idAppName){
			var param="showComplexAppTag=Y";
			var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AppInfoAdvertis-query.jsp",param,"800","500");
			if(retValue!=undefined) {
				var i = retValue.indexOf('_');
				var appId = retValue.substring(0,i);
				var appName = retValue.substring(i+1);
				$('#'+idAppId).val(appId);
				$('#'+idAppName).val(appName+"("+appId+")");
			}
		}
		function clearApp(idAppId,idAppName){
			$('#'+idAppId).val('');
			$('#'+idAppName).val('所有应用');
		}
		
		function selectMerchInfo(idAppId,idMerchName){
			var param="";
			if($('#idMerchIdS').val()!=''){
				param="idMerchIdS="+$('#idMerchIdS').val();
			}else if($('#idMerchId').val!=''){
				param="idMerchIdS="+$('#idMerchId').val();
			}
			var retValue=openDialogFrame(getRootPath()+"/core/posadvertising/MerchInfo-QueryForAdd.jsp",param,"950","500");
			if(retValue){
				if(retValue.substring(0,6)=="single"){
			   		var reg = retValue.split("_");
					$('#'+idAppId+'S').val('');
					$('#'+idAppId).val(reg[1]);
					$('#'+idMerchName).val(reg[2]);
				}else{
					$('#'+idAppId).val('');
					$('#'+idAppId+'S').val(retValue);
					$('#'+idMerchName).val("已选多个商户");
				}
			}
		}
		function clearMerchInfo(ididAppId,idMerchName){
      		$('#'+ididAppId).val("");
      		$('#'+ididAppId+'S').val("");
      		$('#'+idMerchName).val("所有商户");
   	 	}

	</script>
</head>
<body class="easyui-layout" fit="true">

					<div region="center"  fit="true" title="信息录入" >
						<form id="ff" method="post">
						<table class="formTable" style="width:100%;">
				<col  width="100px" class="leftCol"/>
				<col width="200px" >
							<tr>
								<td>应用编号</td>
								<td>
									<input type="hidden" name="APP_ID" id="idAppId" value=""/>
									<input type="text" name="APP_NAME" id="idAppName" readonly class="readonly easyui-validatebox"  value="所有应用" />
									<input type="button" class="btn_grid" value="选择" onclick="queryApp('idAppId','idAppName');"/>
									<input type="button" class="btn_grid" value="所有应用" onclick="clearApp('idAppId','idAppName');"/>
								</td>
							</tr>
							<tr>
								<td>商户编码</td>
								<td>
									<input type="hidden"    name="MERCH_ID" id="idMerchId"  />
									<input type="hidden"    name="MERCH_IDS" id="idMerchIdS"  />
									<input type="text" class="easyui-validatebox readonly" readonly="readonly"   name="MERCH_NAME" id="idMerchName" value="所有商户"  />
									<input  type="button" class="btn_grid" value="选择" onclick="selectMerchInfo('idMerchId','idMerchName');"/>
									<input id="idClear" type="button" class="btn_grid" value="所有商户" onclick="clearMerchInfo('idMerchId','idMerchName')"/>
								</td>
							</tr>
							<tr>
								<td>分支机构</td>
								<td>
									<input type="hidden" name="REG_ID" id="idRegId" maxlength="8" value="<%=person.getAsString("REG_ID") %>" />
									<input type="text" name="REG_NAME" id="idRegName" class="easyui-validatebox readonly" readonly="readonly" required="true" value="<%=person.getAsString("REG_NAME") %>" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName');"/>
								</td>
							</tr>
							<tr>
								<td>结束时间</td>
								<td>
									<input type="text"   name="END_DATE" id="idEndDate" class="Wdate readonly" onFocus="WdatePicker({isShowClear:true,readOnly:true})" />
								</td>
							</tr>
							<tr>
								<td>广告信息</td>
								<td>
									<textarea  class="easyui-validatebox"  rows="3" cols="25" validType="maxLen[90]" required="true"    name="AD_CONTENT" id="idAdContent"  ></textarea>
								</td>
							</tr>
							
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addPosAdvertising()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
