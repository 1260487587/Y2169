// \lkj20180323
var canGetCookie = 1;// 是否支持存储Cookie 0 不支持 1 支持
var ajaxmockjax = 1;// 是否启用虚拟Ajax的请求响 0 不启用 1 启用

var CodeVal = 0;
Code();

function Code() {
    if (canGetCookie == 1) {
        createCode("AdminCode");
        var AdminCode = getCookieValue("AdminCode");
        showCheck(AdminCode);
    } else {
        showCheck(createCode(""));
    }
}

function showCheck(a) {
    CodeVal = a;
    var c = document.getElementById("myCanvas");
    var ctx = c.getContext("2d");
    ctx.clearRect(0, 0, 1000, 1000);
    ctx.font = "80px 'Hiragino Sans GB'";
    ctx.fillStyle = "#E8DFE8";
    ctx.fillText(a, 0, 100);
}

$(document).keypress(function (e) {
    // 回车键事件
    if (e.which == 13) {
        $('input[type="button"]').click();
    }
});
// 粒子背景特效
$('body').particleground({
    dotColor: '#E8DFE8',
    lineColor: '#1b3273'
});
$('input[name="pwd"]').focus(function () {
    $(this).attr('type', 'password');
});
$('input[type="text"]').focus(function () {
    $(this).prev().animate({
        'opacity': '1'
    }, 200);
});
$('input[type="text"],input[type="password"]').blur(function () {
    $(this).prev().animate({
        'opacity': '.5'
    }, 200);
});
$('input[name="login"],input[name="pwd"]').keyup(function () {
    var Len = $(this).val().length;
    if (!$(this).val() == '' && Len >= 5) {
        $(this).next().animate({
            'opacity': '1',
            'right': '30'
        }, 200);
    } else {
        $(this).next().animate({
            'opacity': '0',
            'right': '20'
        }, 200);
    }
});
var open = 0;
layui.use('layer', function () {
    // 非空验证
    $('input[type="button"]').click(function () {
        var login = $('.username').val();
        var pwd = $('.passwordNumder').val();
        var code = $('.ValidateNum').val();
        if (login == '') {
            ErroAlert('请输入您的账号');
            return false;
        } else if (pwd == '') {
            ErroAlert('请输入密码');
            return false;
        } else if (code == '' || code.length != 4) {
            ErroAlert('输入验证码');
            return false;

        } else {
            // 认证中..
            fullscreen();
            $('.login').addClass('test'); // 倾斜特效
            setTimeout(function () {
                $('.login').addClass('testtwo'); // 平移特效
            }, 500);

            setTimeout(function () {
                $('.authent').show().animate({
                    right: -320
                }, {
                    easing: 'easeOutQuint',
                    duration: 600,
                    queue: false
                });
                $('.authent').animate({
                    opacity: 1
                }, {
                    duration: 200,
                    queue: false
                }).addClass('visible');
            }, 200);
            // 登陆
            var myAnimate = setTimeout(function () {
                $.ajax({
                    "url": "/doLogin",
                    "data": {"stuName": login, "stuPwd": pwd},
                    "type": "post",
                    "dataType": "json",
                    "success": function (data) {
                        if (data == 1) {
                            window.location.href = "/index.jsp";
                        } else {
                            window.location.href = "/login.jsp";
                        }
                    }
                })
            }, 2500);
        }
    })
})
var fullscreen = function () {
    elem = document.body;
    if (elem.webkitRequestFullScreen) {
        elem.webkitRequestFullScreen();
    } else if (elem.mozRequestFullScreen) {
        elem.mozRequestFullScreen();
    } else if (elem.requestFullScreen) {
        elem.requestFullscreen();
    } else {
        // 浏览器不支持全屏API或已被禁用
    }
}
