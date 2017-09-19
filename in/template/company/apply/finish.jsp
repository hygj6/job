<%--
  User: xianghuawei
  Date: 2017/6/20
  Time: 16:19
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
            <div class="step step3">
                <ul class="step-text">
                    <li class="on">填写联系方式</li>
                    <li class="on">验证公司邮箱</li>
                    <li class="on">填写公司名称</li>
                </ul>
                <div class="progress">
                    <div class="bar"></div>
                </div>
            </div>
            <div style="padding-bottom: 60px;" class="form-certified">
                <i class="state-icon icon-unusual"></i>
                <h3 class="title" style="font-size: 20px;">新公司申请已提交，请等待审核</h3>
                <p style="padding-left:90px; color: #666; padding-top: 10px;">收到资料后我们将在24小时内进行人工审核，并将<br>审核结果发送至你的邮箱，请耐心等待</p>
            </div>
            <div class="part-line"></div>
            <div style="width: 390px;" class="bottom-certified">  
                <p>1. 若通过审核，你会收到审核成功邮箱，并可以开始招聘之旅<br />
                2. 若未通过审核，我们将以邮件的形式写清未审核通过原因，你可以整理好资料重新提交</p>
            </div>
            <div class="blank-2"></div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
    </body>
</html>