<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--[if lt IE 9]>
    <div style="background:#FFFFCC;height: 35px;display:block; line-height: 35px;padding: 0 5px;color: #0066CC;text-align: center;">你当前浏览器版本过低，这将降低电脑安全性，同时可能会影响你浏览网页。我们建议你<a style="color:#ff6f28;" target="_blank" href="https://www.baidu.com/s?wd=chrome">立即升级到最新版</a>，以防止这些情况发生。</div>
<![endif]-->
<div class="header-company" style="z-index: 2; position: relative;">
    <div class="wrap-1200" <c:if test="${fn:startsWith(requestPath, '/companies/apply')}">style="width: 820px;"</c:if>>    
        <c:if test="${!fn:startsWith(requestPath, '/companies/apply')}">
        <a href="/companies/welcome" class="logo">
            <img height="56" width="203" src="../../img/company-logo.png"/>
        </a>
        </c:if>
        <c:if test="${fn:startsWith(requestPath, '/companies/apply')}">
        <a href="/" class="logo">
            <img height="56" width="203" src="../../img/company-logo.png"/>
        </a>
        </c:if>
        <dl class="nav">
            <c:if test="${!fn:startsWith(requestPath, '/companies/apply')}">
            <dd><a <c:if test="${requestPath=='/companies/welcome'}">class="on"</c:if> href="/companies/welcome">首页</a></dd>
            <dd><a <c:if test="${requestPath=='/companies/resumes'}">class="on"</c:if> href="/companies/resumes">人才搜索</a></dd>
            <dd><a <c:if test="${requestPath=='/companies/conversations'}">class="on"</c:if> href="/companies/conversations">人才沟通</a></dd>
            <dt class="line"></dt>
            <dd><a <c:if test="${requestPath=='/companies/jobs'}">class="on"</c:if> href="/companies/jobs">职位管理</a></dd>
            <dd><a <c:if test="${requestPath=='/companies/manage/resume'}">class="on"</c:if> href="/companies/manage/resume">简历库</a></dd>
            <dd><a <c:if test="${requestPath=='/companies/schedule'}">class="on"</c:if> href="/companies/schedule">面试日程</a></dd>
            </c:if>
        </dl>
        <shiro:user>
        <div class="user-tool">
            <div class="item">
                <div class="avatar"><img width="40" height="40" src="<shiro:principal property="avatar"/>"/></div>
                <div class="text"><shiro:principal property="name"/><span class="arow-b"></span></div>
                <dl class="drop-tool">
                    <dd class="menu-item">
                        <a href="/companies/<shiro:principal property="id"/>.html">公司主页</a>
                    </dd>
                    <dd class="menu-item">
                        <a href="/companies/setting/profile">招聘设置</a>
                    </dd>
                    <dd class="menu-item">
                        <a href="/user/security">安全中心</a>
                    </dd>
                    <dd class="line"></dd>
                    <dd class="menu-item">
                        <a href="/logout">退出登录</a>
                    </dd>
                </dl>
            </div>
        </div>
        </shiro:user>
    </div>
</div>