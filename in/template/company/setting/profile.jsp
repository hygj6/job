<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>招聘设置 - 个人信息 - 外贸帮手网</title>
    <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
</head>
    <style>
    .erro_msg{margin-bottom: -20px;}
    </style>
    <body>
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="company-cont wrap-1200">
            <div class="middle-cont">
                <div class="nav-tab">
                    <ul>
                        <li class="on"><a href="/companies/setting/profile">个人信息</a></li>
                        <li><a href="/companies/setting/template/interview">面试信息</a></li>
                        <li><a href="/companies/setting/template/eliminate">淘汰模板</a></li>
                    </ul>
                </div>
                <div class="form-cont">
                    <dl>
                        <dt>设置头像</dt>
                        <dd>
                            <div class="upload-img">
                                <div class="img-box" style="position: relative;">
                                    <c:if test="${not empty company.avatar}">
                                    <img width="122" height="122" id="picview" src="${company.avatar}"/>
                                    </c:if>
                                    <c:if test="${empty company.avatar}">
                                    <img width="122" height="122" id="picview" src="//cdn.tradehelp.cn/avatar/default.jpg"/>
                                    </c:if>
                                    <div class="mask">
                                        <i class="icon"></i>
                                    </div>
                                    <div id="upload"></div>
                                </div>
                            </div>
                            <p style="line-height: 20px;" class="tip">支持jpg、jpeg、gif、png图片文件<br>
                                                                                        图片尺寸：240px*240px<br>
                                                                                        图片大小需小于10MB</p>
                        </dd>
                    </dl>
                    <form id="save-profile">
                    <dl>
                        <dt>姓名</dt>
                        <dd>
                            <input value="${company.realName}" datatype="*" nullmsg="请输入你的真实姓名" errormsg="请输入你的真实姓名" autocomplete="off" name="real_name" class="input-text" type="text"/>
                        </dd>
                    </dl>
                    <dl>
                        <dt>昵称</dt>
                        <dd>
                            <input value="${company.nickname}" datatype="*" nullmsg="请输入你的昵称" errormsg="请输入你的昵称" autocomplete="off" name="nickname" class="input-text" type="text"/>
                        </dd>
                        <dd>
                            <p class="tip">用于向求职者展示 </p>
                        </dd>
                    </dl>
                    <dl>
                        <dt>手机</dt>
                        <dd>
                            <input value="${company.contactPhone}" datatype="m" nullmsg="请输入手机号" errormsg="请输入正确的手机号" autocomplete="off" name="contact_phone" class="input-text" type="text"/>
                        </dd>
                        <dd>
                            <p class="tip">用于电话呼叫</p>
                        </dd>
                    </dl>
                    <dl>
                        <dt>邮箱</dt>
                        <dd>
                            <input value="${company.email}" datatype="e" nullmsg="请输入邮箱" errormsg="请输入正确的邮箱" autocomplete="off" name="email" class="input-text" type="text"/>
                        </dd>
                        <dd>
                            <p class="tip">用于接受简历</p>
                        </dd>
                    </dl>
                    <dl>
                        <dt></dt>
                        <dd><button type="submit" class="btn enter">保 存</button></dd>
                    </dl>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <script src="${url.cdn}/static/plugins/webuploader/webuploader.js"></script>
    </body>
</html>