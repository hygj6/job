<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>忘记密码 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body>
        <div class="city-bj">
        <a class="logo-form" href="/"></a>
        <div class="form-wrap min" style="margin-top: -210px;">
            <div class="form-box">
               <p class="title">忘记密码</p>
                    <form id="forget">
                        <div class="input-frame">
                            <i class="icon-phone1 icon"></i>
                            <input name="phone" datatype="account" nullmsg="请输入手机/邮箱" errormsg="请输入手机/邮箱" placeholder="请输入正确的手机/邮箱" class="input-text" type="text"/>
                        </div>
                        <div class="input-frame">
                            <i class="icon-code icon"></i>
                            <dl class="group-input">
                                <dd style="width: 185px;"><input name="image_code" datatype="*" nullmsg="请输入图形验证码" style="width: 148px; border-radius: 3px 0px 0px 3px;" placeholder="请证明你不是机器人" class="input-text" type="text"/></dd>
                                <dd style="width: 105px;" class="code"><img class="captcha" id="img-code" width="105" height="40px" src="/forget/captcha?t=<%=Math.random()%>"/></dd>
                            </dl>
                        </div>
                        <div class="input-frame">
                            <i class="icon-phone1 icon"></i>
                            <dl class="group-input">
                                <dd style="width: 185px;"><input name="phone_code" datatype="*" nullmsg="请输入短信验证码" style="width: 149px; border-radius: 3px 0px 0px 3px;" placeholder="验证码" class="input-text verification-code" type="text"/></dd>
                                <dd style="width: 105px;" class="code">
                                    <button type="button" id="phone_validate" class="get-validation">获取验证码</button>
                                </dd>
                            </dl>
                        </div>
                        <button class="btn">下一步</button>
                    </form>
            </div>
        </div>
        <i class="cloud-large"></i>
        <i class="cloud-small"></i>
        <i class="plane"></i>
        </div>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
    </body>
</html>
