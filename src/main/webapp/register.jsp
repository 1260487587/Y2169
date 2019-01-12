<%--
  Created by IntelliJ IDEA.
  User: 玖绊
  Date: 2019/1/11
  Time: 9:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>学生信息管理系统</title>
    <link rel="stylesheet" href="layui/css/layui.css"/>
    <script type="text/javascript" src="layui/layui.js"></script>
    <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>

    <script type="text/javascript">
        //窗体加载事件
        $(function () {
            renderLayui();
            loadAreas();
        })

        function onSubmit() {
            $("#submit").submit(function () {
                return checkName() && checkpwd() && checkSelect();
            })
        }

        function renderLayui() {
            layui.use('form', function () {
                var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                //但是，如果你的HTML是动态生成的，自动渲染就会失效
                //因此你需要在相应的地方，执行下述方法来手动渲染，跟这类似的还有 element.init();
                form.render();
            });
        }

        function loadAreas() {
            $.ajax({
                url: "/loadProvince",
                type: "post",
                dataType: "json",
                success: function (data) {
                    $("#province option:gt(0)").remove();
                    $.each(data, function (i, item) {
                        $("#province").append(
                            "<option value='" + item.provinceId + "'>" + item.provinceName + "</option>"
                        );
                    });

                },
                error: function () {
                    layer.msg("请求失败！！");
                }
            })
        }

        function changePro() {
            var province = $("#province");
            if (province.val() != "请选择") {
                $("#city").removeAttr("disabled");
                $.ajax({
                    url: "/loadCity",
                    type: "post",
                    data: {
                        "proId": province.val()
                    },
                    dataType: "json",
                    success: function (data) {
                        $("#city option:gt(0)").remove();
                        $.each(data, function (i, item) {
                            $("#city").append(
                                "<option value='" + item.cityId + "'>" + item.cityName + "</option>"
                            );
                        });
                    },
                    error: function () {
                        layer.msg("请求失败！！");
                    }
                })
            } else {
                $("#city").attr("disabled", "disabled");
            }
        }

        function changeCity() {
            var city = $("#city");
            if (city.val() != "请选择") {
                $("#county").removeAttr("disabled");
                $.ajax({
                    url: "/loadCounty",
                    type: "post",
                    data: {
                        "cityId": city.val()
                    },
                    dataType: "json",
                    success: function (data) {
                        $("#county option:gt(0)").remove();
                        $.each(data, function (i, item) {
                            $("#county").append(
                                "<option value='" + item.countyId + "'>" + item.countyName + "</option>"
                            );
                        });
                    },
                    error: function () {
                        layer.msg("请求失败！！");
                    }
                })
            } else {
                $("#county").attr("disabled", "disabled");
            }
        }

        function checkName() {
            if ($("#name").val() != null && $("#name").val() != '') {
                return true;
            } else {
                layer.msg("请输入姓名！")
                return false;
            }
        }

        function checkpwd() {
            if ($("#pwd").val() != null && $("#pwd").val() != '') {
                return true;
            } else {
                layer.msg("请输入密码！")
                return false;
            }
        }

        function checkSelect() {
            var province = $("#province").val();
            var city = $("#city").val();
            var county = $("#county").val();
            if (province != "请选择" && city != "请选择" && county != "请选择") {
                return true;
            } else {
                layer.msg("请选择完整的地区！")
                return false;
            }
        }
    </script>
</head>
<body>
<div style="width: 660px;margin: 0 auto">
    <h2 align="center">学生信息管理系统</h2>
    <div id="table_box" style="width: 660px;">
        <form id="submit" action="/addStudent" method="post" onsubmit="false">
            <table class="layui-table">
                <colgroup>
                    <col width="50">
                    <col width="200">
                    <col>
                </colgroup>
                <tr>
                    <td>姓名：</td>
                    <td><input name="stuName" id="name" class="layui-input"/></td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td><input type="password" name="stuPwd" id="pwd" class="layui-input"/></td>
                </tr>
                <tr>
                    <td>省：</td>
                    <td>
                        <select name="stuProId" id="province" onchange="changePro()">
                            <option value="请选择">请选择</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>市：</td>
                    <td>
                        <select name="stuCityId" id="city" onchange="changeCity()" disabled>
                            <option value="请选择">请选择</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>县：</td>
                    <td><select name="stuCountyId" id="county" onchange="changeCounty()" disabled>
                        <option value="请选择">请选择</option>
                    </select></td>
                </tr>
            </table>
            <div align="center">
                <button class="layui-btn" onclick="onSubmit()">注册</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
