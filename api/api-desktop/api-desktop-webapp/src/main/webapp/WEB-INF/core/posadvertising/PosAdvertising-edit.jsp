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
	<title>修改广告信息</title>
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
		  var k=window.dialogArguments; 
		  if(k.par){
		  	var param=k.par;
			$.getJSON("queryPosAdvertising.do",param,function(data){
				$.each(data.rows,function(idx,item){
				//alert(item.SYS_ID);
			$("#idSysId").val($.trim(item.SYS_ID));
			$("#idAppId").val($.trim(item.APP_ID));
			$("#idAppName").val($.trim(item.APP_NAME)==""?"所有应用":$.trim(item.APP_NAME));
			$("#idMerchId").val($.trim(item.MERCH_ID));
			$("#idMerchName").val($.trim(item.MERCH_NAME)==""?"所有商户":$.trim(item.MERCH_NAME));
			$("#idRegId").val($.trim(item.REG_ID));
			$("#idRegName").val($.trim(item.REG_NAME));
			$("#idAdContent").val($.trim(item.AD_CONTENT));
			$("#idEndDate").val($.trim(item.END_DATE));
				});
            }); 
            
         }
		 setModuleNameAndId(); 

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
		    var regId = $('#idRegId').val(); 
		    var sysId = $('#idSysId').val(); 
		    var checkFlag=checkPKIsExist('appId|merchId|regId|sysId',appId+"|"+merchId+"|"+regId+"|"+sysId,'listPosAdvertisingCountForCheck');
			if(checkFlag!="false"){
				msgShow("提示","已存在应用为["+$('#idAppName').val()+"]商户为["+$('#idMerchName').val()+"]分支机构为["+$('#idRegName').val()+"]的记录！！！","info");
				return;
			}
		
			$('#ff').form('submit',{
		        url:'updatePosAdvertising.do',
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
		
		function queryApp(idAppId,idAppName){
			var param="showComplexAppTag=Y";
			var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AppInfoAdvertis-query.jsp",param,"600","400");
			//var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AppInfo-query.jsp","","600","400");
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
			var retValue=openDialogFrame(getRootPath()+"/core/posadvertising/MerchInfo-Query.jsp","","800","500");
			if(retValue){
			   	var reg = retValue.split("_");
				$('#'+idAppId).val(reg[0]);
				$('#'+idMerchName).val(reg[1]);
				//if(regEntireId!=undefined) {
				//	$('#'+regEntireId).val(reg[2]);
				//}
			}
		}
		function clearMerchInfo(ididAppId,idMerchName){
      		$('#'+ididAppId).val("");
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
									<input type="hidden"    name="APP_ID" id="idAppId" maxlength="8" />
									<input type="text" name="APP_NAME" id="idAppName" readonly class="readonly easyui-validatebox"  />
									<input type="button" class="btn_grid" value="选择" onclick="queryApp('idAppId','idAppName');"/>
									<input type="button" class="btn_grid" value="所有应用" onclick="clearApp('idAppId','idAppName');"/>
								</td>
							</tr>
							<tr>
								<td>商户编码</td>
								<td>
									<input type="hidden"    name="MERCH_ID" id="idMerchId"  />
									<input type="text" class="easyui-validatebox readonly" readonly="readonly"   name="MERCH_NAME" id="idMerchName"  />
									<input  type="button" class="btn_grid" value="选择" onclick="selectMerchInfo('idMerchId','idMerchName');"/>
									<input id="idClear" type="button" class="btn_grid" value="所有商户" onclick="clearMerchInfo('idMerchId','idMerchName')"/>
								</td>
							</tr>
							<tr>
								<td>分支机构编号</td>
								<td>
									<input type="hidden" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" name="REG_NAME" id="idRegName" class="easyui-validatebox readonly" readonly="readonly" required="true"  />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName');"/>
								</td>
							</tr>
							<td>结束时间</td>
								<td>
								<input type="text"   name="END_DATE" id="idEndDate" class="Wdate readonly" onFocus="WdatePicker({isShowClear:true,readOnly:true})" />
								</td>
							<tr>
								<td>广告信息</td>
								<td>
									<input type="hidden" name="SYS_ID" id="idSysId" maxlength="50" />
									<textarea  class="easyui-validatebox"  rows="3" cols="25" validType="maxLen[90]" required="true"    name="AD_CONTENT" id="idAdContent"  ></textarea>
								</td>
							</tr>
							<tr>
								
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
