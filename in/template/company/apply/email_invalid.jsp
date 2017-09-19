<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>邮箱链接失效 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="banner"></div>
        <div class="wrap-820 audit-cont" style="padding-bottom: 100px;">
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
                <h3 class="title">邮箱链接失效</h3>
                <p style="text-align: center;" class="tip">（请登录邮箱点击邮件内的链接，验证后即可发布职位）</p>
                <div class="bottom-certified">  
                    <p style="text-align: center;">
                    <a style="padding:5px 20px;" id="send-email" class="reset-btn" href="javascript:void(0)">重新发送</a><br />
                    </p>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
    </body>
    <script>
    <shiro:guest>
    $("#send-email").click(function(){
        location.href="/login?redirect_url="+location.pathname+location.search+"#send"
    })
    </shiro:guest>
    if(location.hash=="#send"){
        $("#send-email").click()
    }
    </script>
</html>

