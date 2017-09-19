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
    <body>
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="banner"></div>
        <div class="wrap-820 audit-cont">
            <div class="step step2">
                <ul class="step-text">
                    <li class="on">填写联系方式</li>
                    <li class="on">验证公司邮箱</li>
                    <li>填写公司名称</li>
                </ul>
                <div class="progress">
                    <div class="bar"></div>
                </div>
            </div>
            <div style="padding-bottom:20px;" class="form-certified">
                <i class="state-icon icon-send_email"></i>
                <h3 class="title">邮箱已发送至<br>
                ${email}</h3>
                <p style="text-align: center;" class="tip">（请登录邮箱点击邮件内的链接，验证后即可发布职位）</p>
            </div>
            <div class="part-line"></div>
            <div class="bottom-certified">  
                <p style="line-height: 30px;">没有收到验证邮件，怎么办？</p>
                <p>
                1. 邮箱地址填写错误？<a class="reset-btn" href="/companies/apply/rewrite">重新填写</a><br />
                2. 邮件有时候会进入垃圾箱，广告信箱，请留意。<br />
                3. 稍等几分钟，还没收到邮件？<a id="send-email" class="reset-btn" href="javascript:void(0)">重新发送</a><br />
                </p>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
    </body>
</html>

