<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="unusual-box" style="padding-bottom: 100px; padding-top:${param.top};">
    <div class="state-icon"></div>
    <p>${param.msg}</p>
    <c:if test="${not empty param.btnLabel}">
        <a class="btn" href="${param.btnUrl}">${param.btnLabel}</a>
    </c:if>
</div>