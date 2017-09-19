<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <div class="form-wrap" style="margin:-190px 0px 0px -350px;">
            <div class="form-box" style="padding: 30px 0px;">
                <div class="wrap-50">
                    <div class="box-entrance">
                        <p class="title">找工作</p>
                        <i class="icon"><img width="100%" height="100%" src="../../img/job-seeker.png"/></i>
                        <a href="/register?type=3" class="btn hollow">找工作</a>
                    </div>
                </div>
                <div class="wrap-50">
                    <i class="line"></i>
                    <div class="box-entrance">
                        <p class="title">招人</p>
                        <i class="icon"><img width="100%" height="100%" src="../../img/releaser.png"/></i>
                        <a href="/register?type=2" class="btn hollow">发布职位</a>
                    </div>
                </div>
                <div class="blank-1"></div>
                <p class="clear bottom-tip">已有账号？<a href="/login">请登录</a></p>
            </div>
        </div>
        <i class="cloud-large"></i>
        <i class="cloud-small"></i>
        <i class="plane"></i>
        </div>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
    </body>
</html>
