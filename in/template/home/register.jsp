<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>注册 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>

    <body>
        <div class="city-bj">
        <a class="logo-form" href="/"></a>
        <div class="form-wrap min" style="margin-top: -210px;">
            <div class="form-box">
                <div class="l-box">
                    <c:if test="${type==2}">
                        <p class="title">创建招聘方账户</p>
                    </c:if>
                    <c:if test="${type==3}">
                        <p class="title">创建求职者账户</p>
                    </c:if>
                    <form id="reg">
                        <input type="hidden" name="type" value="${type}" />
                        <div class="input-frame">
                            <i class="icon-phone1 icon"></i>
                            <input autocomplete="off" value="" name="phone" datatype="m" nullmsg="请输入手机号" errormsg="请输入正确的手机号" placeholder="请输入登录账号" class="input-text" type="text" />
                        </div>
                        <div class="input-frame">
                            <i class="icon-key icon"></i>
                            <input autocomplete="off" value="" name="password" datatype="*6-20" nullmsg="请输入密码" errormsg="密码必须6到20位字符" placeholder="请输入登录密码" class="input-text" type="password" />
                        </div>
                        <div class="input-frame">
                            <i class="icon-code icon"></i>
                            <dl class="group-input">
                                <dd style="width: 185px;"><input name="code" datatype="*4-4" nullmsg="请输入验证码" style="width: 148px; border-radius: 3px 0px 0px 3px;" placeholder="请证明你不是机器人" class="input-text" type="text" /></dd>
                                <dd style="width: 105px;" class="code"><img class="captcha" src="/register/captcha?t=<%=Math.random()%>"/></dd>
                            </dl>
                        </div>
                        <div class="input-frame">
                            <i class="icon-phone1 icon"></i>
                            <dl class="group-input">
                                <dd style="width: 185px;"><input value="" name="phone_code" datatype="*6-6" nullmsg="请输入验证码" style="width: 149px; border-radius: 3px 0px 0px 3px;" placeholder="短信验证码" class="input-text verification-code" type="text" /></dd>
                                <dd style="width: 105px;" class="code">
                                    <button id="phone_validate" type="button" class="get-validation">获取验证码</button>
                                </dd>
                            </dl>
                        </div>
                        <button type="submit" class="btn">创建新账号</button>
                        <p class="tip">
                            已有账户？<a href="/login">立即登录</a>
                        </p>
                    </form>
                </div>
            </div>
        </div>
        <i class="cloud-large"></i>
        <i class="cloud-small"></i>
        <i class="plane"></i>
        </div>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
    </body>
</html>