/**
 * 准备函数
 */
$(document).ready(function() {
	// 读取用户
	getCookie();
	onfocus();
	$(".on_off_checkbox").iphoneStyle();
	$('.tip a ').tipsy({
		gravity : 'sw'
	});
	$('#login').show().animate({
		opacity : 1
	}, 2000);
	$('.logo').show().animate({
		opacity : 1,
		top : '32%'
	}, 800, function() {
		$('.logo').show().delay(1200).animate({
			opacity : 1,
			top : '1%'
		}, 300, function() {
			$('.formLogin').animate({
				opacity : 1,
				left : '0'
			}, 300);
			$('.userbox').animate({
				opacity : 0
			}, 200).hide();
		});
	});
});

$('.userload').click(function(e) {
	$('.formLogin').animate({
		opacity : 1,
		left : '0'
	}, 300);
	$('.userbox').animate({
		opacity : 0
	}, 200, function() {
		$('.userbox').hide();
	});
});

// 重置
$('#btn_reset').click(function(e) {
	$(":input").each(function() {
		$('#' + this.name).val("");
	});
});

// 点击登录
$('#btn_login').click(function(e) {
	submit();
});

// 回车登录
$(document).keydown(function(e) {
	if (e.keyCode == 13) {
		submit();
	}
});

// 表单提交
function submit() {
	var submit = true;
	$("input[nullmsg]").each(function() {
		if ($("#" + this.name).val() == "") {
			showError($("#" + this.name).attr("nullmsg"), 500);
			jrumble();
			setTimeout('hideTop()', 3000);
			submit = false;
			return false;
		}
	});
	if (submit) {
		hideTop();
		loading('核实中..', 1);
		setTimeout("unloading()", 1000);
		// 登录处理
		setTimeout("Login()", 1000);
	}

}
// 登录处理函数
function Login() {
	setCookie();
	var url = $('form').attr('action');// 提交路径
//	var params = $("#formLogin").serialize();
	var formData = new Object();
	var data = $(":input").each(function() {
		if (this.name == "password") {
			formData[this.name] = $.md5($.trim($("#" + this.name).val()));
		}
		else {
			formData[this.name] = $.trim($("#" + this.name).val());
		}
	});
//	$("#formLogin").ajaxSubmit({
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		url : url,// 请求的action路径
		data : formData,
		success : function(response) {
			if (response.code == 0) {
				$.cookie('token', response.data, {
					expires : 7
				});
				loginsuccess();
				setTimeout("window.location.href='index'", 100);
			}
			else {
				showError(response.message);
			}
		},
		error : function(request, status, cause) {
			alert("登录失败！");
		}
	});
}

// 点击消息关闭提示
$('#alertMessage').click(function() {
	hideTop();
});

// 显示错误提示
function showError(str) {
	$('#alertMessage').addClass('error').html(str).stop(true, true).show().animate({
		opacity : 1,
		right : '0'
	}, 500);

}
// 验证通过加载动画
function loginsuccess() {
	$("#login").animate({
		opacity : 1,
		top : '49%'
	}, 200, function() {
		$('.userbox').show().animate({
			opacity : 1
		}, 500);
		$("#login").animate({
			opacity : 0,
			top : '60%'
		}, 500, function() {
			$(this).fadeOut(200, function() {
				$(".text_success").slideDown();
				$("#successLogin").animate({
					opacity : 1,
					height : "200px"
				}, 1000);
			});
		});
	});
}
function showSuccess(str) {
	$('#alertMessage').removeClass('error').html(str).stop(true, true).show().animate({
		opacity : 1,
		right : '0'
	}, 500);
}

function onfocus() {
	if ($(window).width() > 480) {
		$('.tip input').tipsy({
			trigger : 'focus',
			gravity : 'w',
			live : true
		});
	}
	else {
		$('.tip input').tipsy("hide");
	}
}

function hideTop() {
	$('#alertMessage').animate({
		opacity : 0,
		right : '-20'
	}, 500, function() {
		$(this).hide();
	});
}
// 加载信息
function loading(name, overlay) {
	$('body').append('<div id="overlay"></div><div id="preloader">' + name + '..</div>');
	if (overlay == 1) {
		$('#overlay').css('opacity', 0.1).fadeIn(function() {
			$('#preloader').fadeIn();
		});
		return false;
	}
	$('#preloader').fadeIn();
}

function unloading() {
	$('#preloader').fadeOut('fast', function() {
		$('#overlay').fadeOut();
	});
}
// 表单晃动
function jrumble() {
	$('.inner').jrumble({
		x : 4,
		y : 0,
		rotation : 0
	});
	$('.inner').trigger('startRumble');
	setTimeout('$(".inner").trigger("stopRumble")', 500);
}

/**
 * 读取用户
 */
function getCookie() {
	var email = $.cookie('email');
	if (typeof (email) != "undefined") {
		$("#email").val(email);
		$("#on_off").attr("checked", true);
		$("#on_off").val("1");
	}
	else {
		$("#on_off").attr("checked", false);
		$("#on_off").val("0");
	}
}
/**
 * 保存用户
 */
function setCookie() {
	if ($('#on_off').val() == '1') {
		$.cookie('email', $("#email").val(), {
			expires : 7
		});
	}
}

/**
 * 清除用户
 */
function cleanCookie() {
	if ($('#on_off').val() == '1') {
		$.cookie("email", "", {
			expires : -1
		});
		$("#email").val("");
	}
}
