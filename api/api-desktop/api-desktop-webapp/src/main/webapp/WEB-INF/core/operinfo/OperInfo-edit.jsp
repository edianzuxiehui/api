<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.landi.tms.base.IDto"%>
<%@page import="com.landi.tms.base.impl.IDtoImpl"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
IDto person = (IDto)request.getSession().getAttribute("person");
String operId = person.getAsString("OPER_ID");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
<head>
  <base href="<%=basePath%>">
  <base target="_self">
	<title>修改操作员</title>
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
		  
		  	//初始化下拉选择框
		  	$.getJSON('getDictitem.do',{CATCODE:'personValid'},function(jsonData){
				var options="";
				for(var i=0;i<jsonData.length;i++){
					options+='<option value="'+jsonData[i].ITEMCODE+'">'+jsonData[i].ITEMTEXT+'</option>'
				}
				$("#idValid").html(options);
				var param=k.par;
				initData(param);
			});
		  	
		  	
			
            
         }
         setModuleNameAndId();
         function initData(param) {
         	$.getJSON("queryOperInfo.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idOperId").val($.trim(item.OPER_ID));
			$("#idRealroleid").val(item.REALROLEID);
			$("#idRealroleName").val(item.REALROLENAME);
			$("#idName").val($.trim(item.NAME));
			$("#idRegId").val($.trim(item.REG_ID));
			$("#idRegName").val($.trim(item.REGNAME));
			$("#idValid").val($.trim(item.VALID));
			$("#IdDefValid").val($.trim(item.VALID));
			$("#idOrgName").val($.trim(item.ORG_NAME));
			$("#idOperStation").val($.trim(item.OPER_STATION));
			$("#idOperCallno").val($.trim(item.OPER_CALLNO));
			$("#idEmail").val($.trim(item.EMAIL));
			$("#idOldRealroleid").val($.trim(item.REALROLEID));
			$("#idRegEntireId").val($.trim(item.REG_ENTIRE_ID));
			if(item.OPER_ID==$('#opId').val()){
				$('#idChooserl').attr('disabled','disabled');
				$('#idClearrl').attr('disabled','disabled');
				$('#idChooserg').attr('disabled','disabled');
				$('#idClearrg').attr('disabled','disabled');
				$('#idValid').attr('disabled','disabled');
				
			}
			
				});
            }); 
         }
		  

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addOperInfo(){
			$('#ff').form('submit',{
		        url:'updateOperInfo.do',
			    onSubmit:function(){
			    	$('#idValid').attr('disabled',false);
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
				<col  width="65px" class="leftCol"/>
				<col width="200px" >

							<tr>
								<td>操作员编号<font color="red">*</font></td>
								<td>
									<input type="hidden" id="opId" value="<%=operId %>" >  
									<input type="hidden" id="IdDefValid" name="defValid"  >  
									<input type="text" class="readonly" required="true"  readonly   name="OPER_ID" id="idOperId" maxlength="8" />
								</td>
							</tr>
							<tr>
								<td>所属权限组<font color="red">*</font></td>
								<td>
									<input type="hidden" class="easyui-validatebox"   readonly="readonly"   name="OLDREALROLEID" id="idOldRealroleid"  />
									<input type="hidden" class="easyui-validatebox"   readonly="readonly"   name="REALROLEID" id="idRealroleid"  />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly="readonly" required="true"   name="REALROLENAME" id="idRealroleName"  />
									<input id="idChooserl" type="button" class="btn_grid" value="选择" onclick="queryRealrole('idRealroleid','idRealroleName')"/>
									<input id="idClearrl" type="button" class="btn_grid" value="清空" onclick="clearRealrole('idRealroleid','idRealroleName')"/>
								</td>
							</tr>
							<tr>
								<td>操作员名<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true"  validType="maxLen[40]"  name="NAME" id="idName" maxlength="40" />
								</td>
							</tr>
							<tr>
								<td>分支机构<font color="red">*</font></td>
								<td>
									<input type="hidden"    name="REG_ID" id="idRegId"  />
									<input type="hidden"    name="REG_ENTIRE_ID" id="idRegEntireId" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  readonly="readonly" required="true"    name="REG_NAME" id="idRegName"  />
									<input id="idChooserg" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId');"/>
									<input id="idClearrg" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId');"/>
								</td>
							</tr>
							<tr>
								<td>状态<font color="red">*</font></td>
								<td>
									<select type="text" class="easyui-validatebox" name="VALID" id="idValid" style="width: 148px"  >
									</select>
								</td>
							</tr>
							<tr>
							</tr>
							<tr>
								<td>岗位</td>
								<td>
									<input type="hidden"   name="ORG_NAME" id="idOrgName" maxlength="40" />
									<input type="text" class="easyui-validatebox" validType="maxLen[20]"   name="OPER_STATION" id="idOperStation" maxlength="20" />
								</td>
							</tr>
							<tr>
								<td>联系电话</td>
								<td>
									<input type="text" class="easyui-validatebox" validType="phone"    name="OPER_CALLNO" id="idOperCallno" maxlength="20" />
								</td>
							</tr>
							<tr>
								<td>Email地址</td>
								<td>
									<input type="text" class="easyui-validatebox" validType="email"   name="EMAIL" id="idEmail" maxlength="80" />
								</td>
							</tr>

						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addOperInfo()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
