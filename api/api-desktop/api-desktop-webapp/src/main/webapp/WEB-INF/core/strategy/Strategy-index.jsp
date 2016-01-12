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
	<title>策略管理</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/strategy/Strategy-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/strategy/Strategy-add.jsp","","600","450");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idStrategy");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idStrategy");//STRATEGY_ID=111&STRA_STATUS=1
		    if(ids){
		    	//检查分配状态
		    	//alert(ids);
		    	var straStatus = ids.substring(ids.lastIndexOf('=')+1);
		    	if(straStatus=='1'||straStatus=='2'){
		    		msgShow("策略分配","策略已分配不能修改!","error");
		    		return;
		    	}
		    	var retValue=openDialogFrame("<%=basePath%>core/strategy/Strategy-edit.jsp",ids,"600","450");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idStrategy");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
			var rows = $('#idStrategy').datagrid('getSelections');
			var ids=null;
			for(var i = 0; i < rows.length; i++){
				if(null == ids || i == 0){
					ids = $.trim(rows[i].KEYID);
				} else {
				    ids = $.trim(ids) + "," + $.trim(rows[i].KEYID);
				}
			}
			fields=rows[0].FIELDS;
		  	var param=buildDelParam(ids,fields);//alert(param);	
		  	var strategyIdStr = param.substring(param.indexOf('=')+1,param.indexOf('&'));
		  	var straStatusStr = param.substring(param.lastIndexOf('=')+1);
		  	//alert(strategyIdStr);alert(straStatusStr);
		  	var strategyIds = strategyIdStr.split(',');
		  	var straStatuss = straStatusStr.split(',');
		  	for(var i=0;i<strategyIds.length;i++){
		  		if(straStatuss[i]=='1'||straStatuss[i]=='2'){
		    		msgShow("策略分配","策略已分配不能删除!","error");
		    		return;
		    	}
		    }
		  deleteNoteById("idStrategy","delStrategy.do", "");
		}
		
		function queryInfo(){
			if($('#queryForm').form('validate')){
		       clearSelect('idStrategy');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       var date=new Date();
				var param="flag="+date.getTime()//+"&STRATEGY_ID="+$('#idStrategyId').val()
					+"&STRA_BDATE="+$('#idStraBdate').val()+"&STRA_EDATE="+$('#idStraEdate').val()
					+"&INTERVAL_DAYS="+$('#idIntervalDays').val()
					+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))
					+"&STRA_STATUS="+escape(escape($.trim($('#idStraStatus').val())))+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())))
					+"&POS_FLAG="+escape(escape($.trim($('#idPosFlag1').val())))
					+"&STRATEGY_TYPE="+escape(escape($.trim($('#idStrategyType').val())));		
				//alert(param);
			   $('#idStrategy').datagrid('options').url = "listStrategy.do?"+param;// 改变它的url  
			   $("#idStrategy").datagrid('load');
			}
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height:75px;position:relative;" title=""  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col  width="12%" class="leftCol"/>
				<col width="13%" >
				<col  width="12%" class="leftCol"/>
				<col width="15%" >
				<col  width="10%" class="leftCol"/>
				<col width="15%" >
				<col  width="10%" class="leftCol"/>
				<col width="15%" >
							<tr>
								<td>策略类型</td><!-- （1表示报道策略,0表示下载策略） -->
								<td>
				                  <select name="STRATEGY_TYPE" id="idStrategyType" style="width:9em">
				     				<option selected value="">所有</option>
							          <option value="1">巡检策略</option>
							          <option value="0">下载策略</option>
				                  </select>
								</td>
								<td>接入方式</td><!-- (1代表电话接入,0代表tcp接入) -->
								<td>
				                  <select name="POS_FLAG" id="idPosFlag1" style="width:9em">
				     				<option selected value="">所有</option>
							          <option value="1">电话接入</option>
							          <option value="0">tcp接入</option>
				                  </select>
								</td>	
								<td>策略开始日期</td>
								<td>
									<input type="text" name="STRA_BDATE" id="idStraBdate" class="Wdate" readonly onClick="WdatePicker()" style="width:9em"/>
								</td>
								<td>策略结束日期</td>
								<td>
									<input type="text" name="STRA_EDATE" id="idStraEdate" class="Wdate" readonly onClick="WdatePicker()" style="width:9em"/>
								</td>
							</tr>
							<tr>
								<td>状态</td>
								<td>
				                  <select name="STRA_STATUS" id="idStraStatus" style="width:9em">
				                    <option value="" selected>所有</option>
				     				<option value="2">分配完</option>
							         <option value="1">分配中</option>
							         <option value="0">未分配</option>
				                  </select>
								</td>
								<td>报到间隔天数</td>
								<td>
									<input type="text" name="INTERVAL_DAYS" id="idIntervalDays" class="easyui-validatebox" validType="number" style="width:9em"/>
								</td>
								<td>备注</td>
								<td>
									<input type="text" name="DESC_TXT" id="idDescTxt" maxlength="100" style="width:9em"/>
								</td>
								<td colspan="2">
									<div style="text-align:left;">
									 <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
								     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								     </div>
								</td>
							</tr>
						<!-- 	<tr>
								<td>策略编号</td>
								<td>
									<input type="text" name="STRATEGY_ID" id="idStrategyId" maxlength="10" />
								</td>
								<td>失败重试次数</td>
								<td>
									<input type="text" name="FRTIMES" id="idFrtimes"  />
								</td>
								<td>可用能力值</td>
								<td>
									<input type="text" name="AVAILABLE" id="idAvailable"  />
								</td>
								<td>区间开始时间</td>
								<td>
									<input type="text" name="STRA_BTIME" id="idStraBtime" maxlength="8" />
								</td>
								<td>区间结束时间</td>
								<td>
									<input type="text" name="STRA_ETIME" id="idStraEtime" maxlength="8" />
								</td>
								<td>分散间隔(秒)</td>
								<td>
									<input type="text" name="SEPARATE_SECOND" id="idSeparateSecond"  />
								</td>
								<td>上次分配日期时间</td>
								<td>
									<input type="text" name="CURRENT_TIMES" id="idCurrentTimes" maxlength="19" />
								</td>
								<td>允许终端最迟报到间隔（分钟）</td>
								<td>
									<input type="text" name="ONLINE_DELAY" id="idOnlineDelay"  />
								</td>
																<td>策略状态</td>
								<td>
									<input type="text" name="STRA_STATUS" id="idStraStatus" maxlength="1" />
								</td>
																<td>接入能力值(预计接入台数)</td>
								<td>
									<input type="text" name="CAPABILITY" id="idCapability"  />
								</td>
																<td>每小时接入能力值（每台终端完成联机下载所使用时间参数-分）</td>
								<td>
									<input type="text" name="ABILITY" id="idAbility"  />
								</td>
								<td>已分配线路数 -- 拨号接入线路数</td>
								<td>
									<input type="text" name="DTLINES" id="idDtlines"  />
								</td>								
							</tr> -->
						</table>
					</form>
	     </div>
		<div region="center" border="false" >  
			<table id="idStrategy" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
</html>
