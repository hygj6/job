<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>重置密码 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>

    <body>
        <div class="city-bj">
            <a class="logo-form" href="/"></a>
            <div class="form-wrap min" style="margin-top: -150px;">
                <div class="form-box">
                    <form id="reset">
                        <p class="title">重设密码</p>
                        <input autocomplete="off" type="hidden" name="token" value="${token}" />
                        <div class="input-frame">
                            <i class="icon-key icon"></i>
                            <input autocomplete="off" name="password" datatype="*6-20" nullmsg="请输入密码" errormsg="密码必须6到20位字符" placeholder="请输入新密码" class="input-text" type="password" />
                        </div>
                        <div class="input-frame">
                            <i class="icon-key icon"></i>
                            <input autocomplete="off" name="re-password" recheck="password" datatype="*" nullmsg="请再次输入密码" errormsg="两次密码不一致" placeholder="请再次输入新密码" class="input-text" type="password" />
                        </div>    
                        <button type="submit" class="btn">重置密码</button>
                        <div class="blank-2"></div>
                    </form>
                    </div>
                </div>
                <i class="cloud-large"></i>
                <i class="cloud-small"></i>
                <i class="plane"></i>
            </div>
            <jsp:include page="/WEB-INF/public/public-js.jsp" />
    </body>

</html>