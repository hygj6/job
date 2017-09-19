<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>登录 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body>
        <div class="city-bj">
        <a class="logo-form" href="/"></a>
        <div class="form-wrap min" style="margin-top: -200px;">
            <div class="form-box">
                <div class="l-box">
                   <p class="title">登录外贸帮手网</p>
                   <form id="login">
                      <input type="hidden" value="<c:out value='${redirectUrl}'/>" name="redirect_url"/>
                      <div class="input-frame">
                        <i class="icon-phone1 icon"></i>
                        <input autocomplete="off" value="" datatype="account" nullmsg="请输入手机/邮箱" errormsg="请输入正确的手机/邮箱" name="account" placeholder="请输入登录账号" class="input-text" type="text"/>
                      </div>
                      <div class="input-frame">
                          <i class="icon-key icon"></i>
                        <input autocomplete="off" value="" datatype="*6-20" nullmsg="请输入密码" errormsg="密码必须6到20位字符" name="password" placeholder="请输入登录密码" class="input-text" type="password"/>
                      </div>
                      <div class="blank-1"></div>
                      <button type="submit" class="btn">登录</button>
                   </form>
                   <p class="tip" style="text-align: center;">
                       <a href="/forget">忘记密码</a>
                       <span style="padding: 0px 10px; font-size: 12px; display:inline-block; vertical-align: middle; margin-top: -5px;">|</span>
                       <a href="/register/nav">立即注册</a>
                   </p>
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