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
	<title></title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/devappfile/DevAppFile-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/devappfile/DevAppFile-add.jsp","","600","400");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idDevAppFile");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idDevAppFile");
		    if(ids){
		    
		      //验证是否有修改程序文件的权限，下级是不可以修改上级的共享的程序文件
		      if(checkModifyDevAppFileAuthority()){
		    	var retValue=openDialogFrame("<%=basePath%>core/devappfile/DevAppFile-edit.jsp",ids,"600","400");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idDevAppFile");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
			   }else {
			     msgShow("没有权限","没有权限修改上级的程序文件","error");
			   
			   }
			   
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idDevAppFile","delDevAppFile.do", "");
		}
		
		function queryInfo(){
		       var date=new Date();
		    $('#idDevAppFile').datagrid("clearSelections");
			var param="flag="+date.getTime()+"&APP_ID="+escape(escape($.trim($('#idAppId').val())))+"&APP_VER="+escape(escape($.trim($('#idAppVer').val())))+"&FID="+escape(escape($.trim($('#idFid').val())))+"&MID="+escape(escape($.trim($('#idMid').val())))+"&APP_FILE_PATH="+escape(escape($.trim($('#idAppFilePath').val())))+"&REAL_APPNAME="+escape(escape($.trim($('#idRealAppname').val())))+"&REAL_APPVER="+escape(escape($.trim($('#idRealAppver').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())))
			;
			//+"&sort_tbl_dev_app_file="+escape(escape($.trim($('#id_sort_tbl_dev_app_file').val()))) +"&asc_desc="+escape(escape($.trim($('#id_asc_desc').val())));	
			   $('#idDevAppFile').datagrid('options').url = "listDevAppFile.do?"+param;// 改变它的url  
			   $("#idDevAppFile").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
			document.getElementById("idMid").length=0;
			document.getElementById("idMid").options.add(new Option("请选择主机型号",""));
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 46px;position:relative;"   split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col  width="8%" class="leftCol"/>
				<col width="10%" >
                <col  width="8%" class="leftCol"/>
				<col width="10%" >
                <col  width="8%" class="leftCol"/>
				<col width="10%" >
               <col  width="8%" class="leftCol"/>
				<col width="10%" >
				
				   

							<tr>
								<td><div style="text-align: right;">应用编号</div></td>
								<td>
									<select type="text" name="APP_ID" id="idAppId" maxlength="8" >
									 <option value="">请选择应用编号</option>
									</select>
								</td>
								<td><div style="text-align: right;">厂商</div></td><!-- 加上type="text" 重置就不会变成null了-->
								<td>
									<select type="text" name="FID" id="idFid" maxlength="15" style="width:9em" onchange="changeModelByFID(this.value);">
									   <option value="">请选择终端厂商</option>
									</select>
								</td>
								<td><div style="text-align: right;">主机型号</div></td>
								<td>
									<select type="text" name="MID" id="idMid" maxlength="20" >
									<option value="">请选择主机型号</option>
									</select>
								</td>
								<!-- 
								<td>排序条件</td>
								<td>
									<select type="text" name="sort_tbl_dev_app_file" id="id_sort_tbl_dev_app_file" maxlength="20" >
									  <option value="">请选择排序条件</option>
									</select>
									<select type="text" name="asc_desc" id="id_asc_desc">
									<option value="asc">升序</option>
									<option value="desc">降序</option>
									</select>
								</td>
								 -->
							   <td>
							   <div style="text-align: left;">
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							    </div>
							   </td>
							</tr>
							<tr>
							<!--  
							<td>应用版本</td>
								<td>
									<input type="text" name="APP_VER" id="idAppVer" maxlength="30" />
								</td>
								<td>程序文件路径</td>
								<td>
									<input type="text" name="APP_FILE_PATH" id="idAppFilePath" maxlength="100" />
								</td>
								<td>实际程序名</td>
								<td>
									<input type="text" name="REAL_APPNAME" id="idRealAppname" maxlength="32" />
								</td>
								<td>实际版本号</td>
								<td>
									<input type="text" name="REAL_APPVER" id="idRealAppver" maxlength="32" />
								</td>
							</tr>
							<tr>
								<td>分支机构编号</td>
								<td>
									<input type="text" name="REG_ID" id="idRegId" maxlength="8" />
								</td>
								<td>备注</td>
								<td>
									<input type="text" name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>
							</tr>
						
							<tr>
							<td colspan="6">
								<a href="javascript:void(0)" class="easyui-linkbutton"  icon="icon-search" onclick="queryInfo()">查找</a>
								<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0);" onclick="cleardata()">重置</a>
							</td>
							</tr>
							-->
						</table>
					</form>
	     </div>
		<div region="center" border="false" >  
			<table id="idDevAppFile" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
