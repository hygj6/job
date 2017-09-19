<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>简历管理 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <style>
    .datetimepicker table tr td.active:active, .datetimepicker table tr td.active:hover:active, .datetimepicker table tr td.active.disabled:active, .datetimepicker table tr td.active.disabled:hover:active, .datetimepicker table tr td.active.active, .datetimepicker table tr td.active:hover.active, .datetimepicker table tr td.active.disabled.active, .datetimepicker table tr td.active.disabled:hover.active,
    .datetimepicker table tr td span.active:active, .datetimepicker table tr td span.active:hover:active, .datetimepicker table tr td span.active.disabled:active, .datetimepicker table tr td span.active.disabled:hover:active, .datetimepicker table tr td span.active.active, .datetimepicker table tr td span.active:hover.active, .datetimepicker table tr td span.active.disabled.active, .datetimepicker table tr td span.active.disabled:hover.active{
        background-color:#00b38a !important;
        background-image:none;
    }
    .seeker-tab,.interview-info{overflow: auto; height:600px;}
    .interview-info{width:880px; padding-right: 20px; margin-right: -20px;}
    .seeker-tab::-webkit-scrollbar,.interview-info::-webkit-scrollbar{
     width:7px;
    }
    .seeker-tab::-webkit-scrollbar-track,.interview-info::-webkit-scrollbar-track{
    background-color:#D9D9D9;
    }
    .seeker-tab::-webkit-scrollbar-thumb,.interview-info::-webkit-scrollbar-thumb{
        border-radius:3px;
        box-shadow: 0px 0px 5px 2px #ddd;
        background-color:#00b38a;
    }
    </style>
    <body>
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="company-cont wrap-1200">
            <div class="middle-cont">
                <div class="condition">
                    <h3>应聘职位</h3>
                    <dl id="categories-tab">
                        <dd class="on">不限</dd>
                        <c:forEach items="${categories}" var="category">
                            <dd data-id="${category.id}">${category.job}</dd>
                        </c:forEach>
                    </dl>
                </div>
                <p class="tip-min">共<span class="sign">${total}</span>份简历${status.value}</p>
                <div class="nav-tab">
                    <ul id="type-tab">
                        <c:forEach items="${employeeStatus}" var="status">
                            <li data-status="${status.name}"><a href="javascript:void(0)">${status.value}（<span class="nub">${status.count}</span>）</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="blank-2"></div>
                <div id="res">
                    <div class="seeker-tab" id="resume-list">
                        <div class="scroll-wrap">

                        </div>
                    </div>
                    <div class="interview-info-wrap" style="float: right;">
                        <div class="interview-info">
                        </div>
                        <div class="operation-bar">
                            <a id="print" href="javascript:void(0)" class="item">
                                <i class="icon icon-print"></i>打印
                            </a>
                            <a id="download" target="_blank" class="item">
                                <i class="icon icon-download"></i>下载
                            </a>
                        </div>
                    </div>
                </div>
                <div id="no-res"></div>
            </div>
        </div>
        <div id="invitation-box" class="modal-backdrop">
            <div class="modal-dialog">
                <div class="modal-header">
                    面试邀请
                    <i class="icon off"></i>
                </div>
                <div class="modal-cont">
                    <form>
                        <div class="form-group">
                            <p class="min-title">面试时间<span style="font-size: 12px; color:#999;">（必填<span style="color:red;">*</span>）</span></p>
                            <div class="blank-1"></div>
                            <input readonly="readonly" data-top="-10" datatype="*" nullmsg="请输入面试时间" errormsg="请输入面试时间" placeholder="点击选择时间" name="interview_date" style="width: 330px;"
                                   class="input-text form_datetime" type="text"/><br>
                            <div class="blank-1"></div>
                            <p class="min-title">面试通知<span style="font-size: 12px; color:#999;">（选填）</span></p>
                            <div class="blank-1"></div>
                            <div class="group-input" id="interviewer-list">
        
                            </div>
                            <p><a id="add-interviewer" class="add" href="javascript:void(0)">+再加一个</a></p>
                            <div class="blank-2"></div>
                            <div class="btn-group">
                                <button class="btn enter">发送</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="modal-backdrop" id="eliminate-box">
            <div class="modal-dialog">
                <div class="modal-header">
                    淘汰/放弃
                    <i class="icon off"></i>
                </div>
                <div class="modal-cont">
                    <form>
                        <input type="hidden" name="id"/>
                        <p class="min-title">选择淘汰/放弃原因</p>
                        <div class="blank-1"></div>
                        <div class="checked-group eliminate-tab">
                        </div>
                        <div class="form-group">
                            <div class="blank-1"></div>
                            <p class="min-title">解释说明</p>
                            <div class="blank-1"></div>
                            <textarea name="description" style="height: 130px; width: 520px; color:#999;"
                                      class="input-text"></textarea>
                        </div>
                        <p>将向候选人发送系统消息，并包含解释说明，此操作无法撤销，是否确认？</p>
                        <div class="blank-2"></div>
                        <div class="btn-group">
                            <button type="submit" class="btn enter">确认</button>
                        </div>
                        <div class="blank-1"></div>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <script src="${url.cdn}/static/plugins/datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
        <script src="${url.cdn}/static/plugins/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
        <link rel="stylesheet" href="${url.cdn}/static/plugins/datetimepicker/css/bootstrap-datetimepicker.min.css" />
        <script>
        $(".form_datetime").datetimepicker({
            minView:1,
            format: "yyyy-mm-dd hh:00:00",
            autoclose:true,
            startDate:new Date(new Date().getTime()+60*60*1000),
            pickerPosition:"bottom-right",
            language:'zh-CN',  
        }).on('changeDate',function(e){
            $(".form_datetime").blur();
        });
        </script>
    </body>
</html>