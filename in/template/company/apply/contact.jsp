<%--
  User: xianghuawei
  Date: 2017/6/20
  Time: 16:18
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>企业资质申请 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <style>
    .erro_msg{margin-top:-10px;}
    .audit-cont .form-certified .input-text{margin-bottom: 10px;}
    </style>
    <body>
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="banner"></div>
        <div class="wrap-820 audit-cont">
            <div class="step step1">
                <ul class="step-text">
                    <li class="on">填写联系方式</li>
                    <li>验证公司邮箱</li>
                    <li>填写公司名称</li>
                </ul>
                <div class="progress">
                    <div class="bar"></div>
                </div>
            </div>
            <div style="padding-bottom: 60px;" class="form-certified">
                <form id="contact">
                    <input autocomplete="off" datatype="m" nullmsg="请输入手机号" errormsg="请输入正确的手机号" name="mobile" placeholder="请输入手机号码" class="input-text"/>
                    <div class="blank-2"></div>
                    <input autocomplete="off" datatype="e" nullmsg="请输入邮箱" errormsg="请输入正确的邮箱" name="email" placeholder="请输入公司邮箱" class="input-text"/>
                    <p style="margin-top: -10px;" class="tip">（该邮箱同时作为简历接收邮箱，审核通过后不可修改）</p>
                    <div class="blank-2"></div>
                    <button class="btn">下一步</button>
                    <div class="blank-1"></div>
                    <p class="tip">如有任何问题，请致电 :${contacts.phone}<br>或邮件联系我们 ${contacts.email}，我们会尽快为你解决。</p>
                </form>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
    </body>
</html>
