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
            //调用Ajax方法分页显示数据(1是当前页数)
            findOnePageList(1, search);

        })
        //定义一个当前页数给分页插件使用,插件选中的页数，初始值为1
        var currentPageAllAppoint = 1;
        var search;

        //分页方法传当前页数
        function findOnePageList(pageNo, searchStr) {
            $.ajax({
                "url": "/getOnePageData",//请求servlet地址
                "data": {
                    "pageIndex": pageNo,
                    "stuName": searchStr
                }, //传的数据,可以是多个参数,我这里就传一个当前页数给servlet
                "type": "Post", //请求方式为post
                "dataType": "json", //数据格式为json
                "success": function (data) { //返回的数据"data"
                    $("#tbody>tr").remove();
                    //定义一个变量接受总数据行数，后面分页插件要使用
                    var totalPageAllAppoint = data.total;
                    //调用分页方法，把总数据行数往下传
                    toPage(totalPageAllAppoint, data.pageSize, searchStr);
                    //循环遍历数据
                    $.each(data.list, function (i, item) {
                        var tr = $("<tr></tr>");
                        tr.append(
                            "<td>" + item.stuName + "</td>" +
                            "<td>" + item.provinceName + "</td>" +
                            "<td>" + item.cityName + "</td>" +
                            "<td>" + item.countyName + "</td>"
                        )
                        $("#tbody").append(tr);
                    })
                },
                //请求失败走的函数
                "error": function (data) {
                    alert("请求失败");
                }
            });
        }

        //layui分页插件方法
        function toPage(totalPageAllAppoint, pageSize) {
            layui.use(['laypage', 'layer'], function () {
                var laypage = layui.laypage, //调插件
                    layer = layui.layer;
                laypage.render({
                    "elem": 'layPage' //这里很重要     是将插件绑定到哪里   我绑定的是   “approve”  注意，这是id，不用写#approve
                    ,
                    "count": totalPageAllAppoint //这是传回来的总行数   ，插件内部会计算页数
                    ,
                    "limit": pageSize//这是每页显示多少行，大小要跟你后台传回来的数据数量一样
                    ,
                    "layout": ['count', 'prev', 'page', 'next', 'refresh'],
                    "groups": 3 //这个自己看文档
                    ,
                    "theme": '#FF5722',
                    "curr": currentPageAllAppoint //这个很重要，  是分页选中的标识，上面的全局变量用在这里
                    ,
                    "jump": function (obj, first) { //这个是获取插件的一些属性和值   点击页号的时候执行的函数  obj 包含了当前分页的所有参数 比如  console.log(obj.curr)
                        if (!first) { //必须要写一个判断，不然会循环调用  首次不执行，点击的时候才执行
                            var pageNo = obj.curr; //这个是将选中的页数赋值给全局变量，然后下面的Ajax方法里面需要用到
                            currentPageAllAppoint = obj.curr;
                            findOnePageList(pageNo, search); //调用Ajax分页方法，将选中的页数传到方法给后台
                        }
                    }
                });
            });
        }
    </script>
</head>
<body>
<div style="width: 660px;margin: 0 auto">
    <h2 align="center">学生信息管理系统</h2>
    <div id="table_box" style="width: 660px;">
        <table class="layui-table">
            <colgroup>
                <col width="150">
                <col width="200">
                <col>
            </colgroup>
            <thead>
            <tr>
                <th>姓名</th>
                <th>省</th>
                <th>市</th>
                <th>县</th>
            </tr>
            </thead>
            <tbody id="tbody">

            </tbody>
        </table>
        <div id="layPage" align="center"></div>
    </div>
</div>
</body>
</html>
