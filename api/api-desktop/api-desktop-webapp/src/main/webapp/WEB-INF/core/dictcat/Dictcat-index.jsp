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
    <script type="text/javascript" src="core/dictcat/Dictcat-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/dictcat/Dictcat-add.jsp","","350","180");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idDictcat");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idDictcat");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/dictcat/Dictcat-edit.jsp",ids,"350","180");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idDictcat");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteById("idDictcat","delDictcat.do", "");
		}

		
		
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="west" split="true" style="width:430px;padding:2px;" >
	     <table id="idDictcat" ></table>
	    </div>
		<div region="center" split="true" style="padding:2px;" border="false" > 
		<div style="height:100%;border:1px #8DB2E3 solid;overflow:auto;">
			<table id="idDictitem" ></table>
		</div>	
	    </div>	    
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
