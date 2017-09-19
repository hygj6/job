<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div class="head head-index" style="z-index: 2; position: relative;">
    <jsp:include page="/WEB-INF/public/public-home-top-bar.jsp"/>
    <div class="wrap">
        <a class="logo" href="/">
            <img src="../../img/index-logo.png" width="143" height="30"/>
        </a>
        <ul class="nav">
            <li><a <c:if test="${requestPath=='/'}">class="on"</c:if> href="/">首页</a></li>
            <li><a <c:if test="${fn:startsWith(requestPath, '/jobs/')}">class="on"</c:if> href="/jobs/">职位</a></li>
            <li><a <c:if test="${requestPath=='/companies/'}">class="on"</c:if> href="/companies/">公司</a></li>
        </ul>
    </div>
</div>