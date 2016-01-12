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
	<title>新增策略</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript" src="core/strategy/Strategy-js.js"></script>
		<script type="text/javascript">
		setModuleNameAndId();
		$(document).ready(function(){
			var d=new Date();
			var starttm = d.Format("YYYY-MM-DD HH:mm:ss");  
			$("#idStraBtime").val(starttm);
		    var dp=new Date(new Date().getTime()+(15*24+1) * 60 *60*1000);
			var endtm = dp.Format("YYYY-MM-DD HH:mm:ss"); 
			$("#idStraEtime").val(endtm);
			$.ajax({
			   type:"POST",
			   url:"getMaxId.do",
			   data:"sequeceId=STRATEGY_ID",		
			   success:function(data){
					$('#idStrategyId').val(data);
			   },
			   error:function(data){
			   		msgShow("错误",data,"error");
			   }
			});
			defaultQueryRegForStrategy();//填充分支机构
		});	
		
		  function defaultQueryRegForStrategy(){
  			    $.ajax({
			   type: "POST",
			   url: "initDataForMerchInfo.do",
			   data: "param=idRegId,regEntireId",       //idOrgId,idMerchStatus
			    success: function(data){
			    if(data.idRegId&&data.regEntireId){
			       var str  = data.idRegId.split("(");
			       $("#idRegId").val(str[1].substring(0,str[1].length-1));
			       $("#idRegName").val(data.idRegId);
			       $("#idRegEntireId").val(data.regEntireId);
			    }
			    
			    $('#idRegId').change();//触发填充线路数
			   } 
			  }); 
  			}
		function cleardata(){
			var strategyId = $("#idStrategyId").val();
			$('#ff').form('clear');
			$("#idStrategyId").val(strategyId);
			$("#idStrategyType").val("1");
			$("#idPosFlag").val("1");
		}
		
		function VerCapab(){
			var idCapability1=$('#idCapability1');
			var idCapability=$('#idCapability');
			if(idCapability1.val()==""&&idCapability.val()!=""){
				msgShow('策略','允许接入台数为空,不能输入预计台数','error');
				idCapability.val("");
			}
		
		}
		function addStrategy(){
			$('#ff').form('submit',{
		        url:'addStrategy.do',
			    onSubmit:function(){
			    	var retFlag = $(this).form('validate');
			    	if(retFlag){
				    	if($('#idStraBtime').val()==""){
				    		msgShow('策略修改','开始时间不能为空','info');
				    		return false;
				    	}
				    	if($('#idStraEtime').val()==""){
				    		msgShow('策略修改','结束时间不能为空','info');
				    		return false;			    	
				    	}
				    	var curDate = new Date().Format("YYYY-MM-DD");//alert(curDate);
				    	if(!compareDate($('#idStraBtime').val(),curDate)){
				    		msgShow('策略修改','开始日期不能小于当前日期','info');
				    		return false;
				    	}
				    	if(!compareDate($('#idStraEtime').val(),$('#idStraBtime').val())){
				    		msgShow('策略修改','结束日期不能小于开始日期','info');
				    		return false;
				    	}			    		
			    	}
			        return retFlag; 
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       if(myObject.status=="true"){
						 window.close();
			        	 window.returnValue=myObject.status; 
			        }else if(myObject.status=="false"){
			        	//msgShow("新增",myObject.message,"error");
						if (confirm("该策略时间段已被使用，请确认是否增加策略！（确定：增加，取消：返回）")){
							$('#idAddFlag').val("true");  
							addStrategy();
					    }
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
				<col  width="35%" class="leftCol"/>
				<col width="65%" >
					<!-- 
							<tr>
								<td>策略编号</td>
								<td>
									<input type="text" class="readonly" readonly required="true" validType="numberorchar" name="STRATEGY_ID" id="idStrategyId" maxlength="10" />
								</td>
							</tr> -->
							<input type="hidden" required="true" name="STRATEGY_ID" id="idStrategyId"/>
							<input type="hidden" value="" name="addFlag" id="idAddFlag"/>
							<tr>
								<td>分支机构<font color="red">*</font></td>
								<td>
									<input type="hidden" class="easyui-validatebox"  required="true" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox"  required="true" style="background-color: #EEEEEE" readonly name="REG_ID" id="idRegName" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName');"/>
								</td>
							</tr>
							<tr>
								<td>开始时间<font color="red">*</font></td>
								<td><!-- 包括了时间和日期 -->
									<input name="STRA_BDATETIME" id="idStraBtime" class="easyui-validatebox Wdate" required="true" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly>
								<!-- <input type="text" class="easyui-validatebox"    name="STRA_BDATE" id="idStraBdate" maxlength="10" />
									<input type="text" class="easyui-validatebox"    name="STRA_BTIME" id="idStraBtime" maxlength="8" /> -->	
								</td>
							</tr>
							<tr>
								<td>结束时间<font color="red">*</font></td>
								<td>
									<input name="STRA_EDATETIME" id="idStraEtime" class="easyui-validatebox Wdate" required="true" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" readonly>
								<!-- <input type="text" class="easyui-validatebox"    name="STRA_EDATE" id="idStraEdate" maxlength="10" />
									<input type="text" class="easyui-validatebox"    name="STRA_ETIME" id="idStraEtime" maxlength="8" /> -->	
								</td>
							</tr>
							<tr>
								<td>策略类型<font color="red">*</font></td><!-- （1表示报道策略,0表示下载策略） -->
								<td>
				                  <select name="STRATEGY_TYPE" id="idStrategyType" class="easyui-validatebox" required="true" onchange="onStrategyTypeChange()" style="width:145">
							          <option value="1">巡检策略</option>
							          <option value="0">下载策略</option>
				                  </select>
								</td>
							</tr>
							<tr>
								<td>接入方式<font color="red">*</font></td><!-- (1代表电话接入,0代表tcp接入) -->
								<td>
				                  <select name="POS_FLAG" id="idPosFlag" class="easyui-validatebox" required="true" onchange="getCapability()" style="width:145">
							          <option value="1">电话接入</option>
							          <option value="0">tcp接入</option>
				                  </select>
								</td>
							</tr>
							<tr>
								<td id="posFlagTxt"><div style="text-align: right;">拨号接入线路数11</div></td><!-- 已分配线路数 -- 拨号接入线路数 -->
								<td>
									<input type="text" class="easyui-validatebox" required="true" style="background-color: #EEEEEE" readonly class="readonly" validType="integer" name="DTLINES" id="idDtlines"  />
								</td>
							</tr>
							<tr>
								<td>报到间隔周期(天)<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" value="30" required="true" validType="integer" name="INTERVAL_DAYS" id="idIntervalDays" maxlength="2"/>
								</td>
							</tr>
							<tr>
								<td>失败重试次数<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" value="3" required="true" validType="integer" name="FRTIMES" id="idFrtimes" maxlength="1"/>
								</td>
							</tr>
							<tr>
								<td>允许终端最迟报到间隔(分)<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" value="30" required="true" validType="integer" name="ONLINE_DELAY" id="idOnlineDelay" maxlength="2"/>
								</td>
							</tr>
							<tr>
								<td>每台终端完成联机下载时间(分)<font color="red">*</font></td><!--数据字典定义，可修改（每小时接入能力值,每台终端完成联机下载所使用时间参数-分） -->
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="integer" name="ABILITY" id="idAbility" maxlength="2"/>
								</td>
							</tr>
							<tr>
								<td>允许接入台数</td>
								<td>
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly required="true" validType="integer" name="CAPABILITY1" id="idCapability1"   />
								</td>
							</tr>
							<tr>
								<td>预计接入台数<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="integer" name="CAPABILITY" id="idCapability" onkeyup="VerCapab()" />
								</td>
							</tr>
							<tr>
								<td>分散间隔(秒)</td>
								<td>
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly required="true" validType="intOrFloat" name="SEPARATE_SECOND" id="idSeparateSecond"  />
								</td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<input type="text" class="easyui-validatebox" onkeyup="return limitMaxByte(this,this.maxlength)" name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>
							</tr>
						<!-- 	<tr>
								<td>策略状态</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="STRA_STATUS" id="idStraStatus" maxlength="1" />
								</td>
							</tr>
							<tr>
								<td>可用能力值</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="AVAILABLE" id="idAvailable"  />
								</td>
							</tr>
							 -->
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addStrategy()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="cleardata()">重置</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
</html>
