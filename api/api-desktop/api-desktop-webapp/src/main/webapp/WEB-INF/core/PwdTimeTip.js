$(function(){
	 $.ajax({
		   type:"POST",
		   url:"pwdTimeTip.do",
		   data:"",		
		   success:function(data){
			   var myObject = eval('(' + data + ')');
			   var status=myObject.status;
			   var msg=myObject.message;
			   var lastDate=myObject.lastDate;
			   if(status=="empty"){
				   $('#test').window('open');
				   $(".window-mask").css("display","none");
				   $(".window-mask").hide();
				   $("#idMsg").html('<font style="font-size: 18px">初始密码一直未修改，请修改初始密码！</font>');
				   //.append('<input type="button" class="btn_grid" value=" 修 改 密 码 " onclick="updatePWD()"/>');
			   }else if(status=="overtake"){
				   $('#test').window('open');
				   $(".window-mask").css("display","none");
				   $(".window-mask").hide();
				   $("#idMsg").html('<font style="font-size: 18px">上次修改密码的时间是'+lastDate+',超过'+msg+'天密码未修改了，请修改密码！</font>');
				   //.append('<input type="button" class="btn_grid" value=" 修 改 密 码 " onclick="updatePWD()"/>');
			   }else if(status=="normal"){
				   $("#idMsg").html('<font style="font-size: 20px">欢迎使用终端远程管理系统，你最后一次修改密码的时间是'+msg+'</font>');
			   }else{
				   $("#idMsg").html('<font style="font-size: 20px">初始密码一直未修改，请修改初始密码</font>').
				   append('<input type="button" class="btn_grid" value="修改密码" onclick="updatePWD()"/>');
			   }
			   
			   //alert(myObject.status+"xxxxxx"+myObject.message);
		   },
		   error:function(data){
		   		msgShow("获取Id错误",data,"error");
		   }
		});

		$("#idTmsModuleTitle").attr("value","密码修改");
		$("#idTmsModuleId").attr("value",0);
		//cleardata();
});

function updatePWD(){
	$('#ff').form('clear');
	//window.open(getRootPath()+"/core/operinfo/ChangePWDInIndex.jsp");
	$('#oldpwd').validatebox('remove'); 
	$('#newpwd').validatebox('remove'); 
	$('#confimpwd').validatebox('remove'); 
	$('#test').window('open');
	$('#oldpwd').validatebox('reduce'); 
	$('#newpwd').validatebox('reduce'); 
	$('#confimpwd').validatebox('reduce'); 
}

function closeWin(){
	$('#test').window('close');
}

function addOperInfo(){
    if($('#newpwd').attr('value') != $('#confimpwd').attr('value')){
    	msgShow("提示","两次输入新密码不一致!","info");
    	return;
    }
    var param="tmsModuleTitle="+escape(escape($('#idTmsModuleTitle').val()))+"&tmsModuleId="+escape(escape($('#idTmsModuleId').val()));	
	$('#ff').form('submit',{
        url:'updateOperPWD.do?'+param,
	    onSubmit:function(){
	        return $(this).form('validate');
	    },
	    success:function(data){
	      var myObject = eval('(' + data + ')');
	      if(myObject.status=="true"){
	    	  	 closeWin();
	    	  	 //alert("密码修改成功!");
	    	  	 msgShow("修改密码","修改密码成功,请记住新密码!","info");
	    	  	//window.location.reload(); 
				 //$('#ff').form('clear');
	      }else if(myObject.status=="false"){
	        	msgShow("修改密码",myObject.message,"error");
	      }
	    }
	});
	//window.location.reload(); 
	
}
function cleardata(){
	$('#ff').form('clear');
}
  
		
