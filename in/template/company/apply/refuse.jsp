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
            <div style="padding-bottom: 60px;" class="form-certified">
                <i class="state-icon icon-unusual"></i>
                <div class="blank-1"></div>
                <h3 class="title" style="font-size: 20px;">您的招聘服务申请暂时未能通过</h3>
                <p style="padding-left:90px; color: #333; padding-top: 10px;">您申请未通过的原因可能为：<br><span style="color:#ff5d5d;">接收简历邮箱后缀和公司全称不相关</span></p>
                <p style="padding-left:90px; color: #999; padding-top: 10px;">请您重新确认公司信息并再次提交申请</p>
                <div class="blank-2"></div>
                <a href="/companies/apply/rewrite" class="min-btn">返回修改</a>
            </div>
            <div class="part-line"></div>
            <div class="bottom-certified">  
                <p style="line-height: 30px;">1.如有任何问题，请发邮件给我们：${contacts.email}，我们将尽快为你解决。<br />
                2.发邮件时，请在主题中标明【封禁投诉+公司名称】，谢谢配合！</p>
            </div>
            <div class="blank-2"></div>
        </div>
    </body>
</html>