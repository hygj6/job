<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>行业列表${industryId}${headless}</title>
    <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
</head>
<style>
<c:if test="${headless}">
body.pop-box{background:rgba(0, 0, 0, 0.5);}
.pop-wrap{border-radius:3px; overflow: hidden;}
</c:if>
</style>
<body class="pop-box">
<c:if test="${!headless}">
    <jsp:include page="/WEB-INF/public/public-home-head.jsp"/>
</c:if>
<div class="wrap main">
    <div class="middle-cont pop-wrap" style="border:1px solid #e8e8e8; position: relative;">
        <c:if test="${headless}">
        <i style="position: absolute; right:10px; top:10px; z-index: 10; cursor: pointer; font-size: 20px;" id="off-frame" class="icon icon-icon_close"></i>
        </c:if>
        <div class="industry-cont">
            <c:set var="topId" value=""/>
            <c:forEach items="${industryList}" var="industry" varStatus="status2">
                <c:if test="${industry.id == industryId}"><c:set var="topId" value="${industry.id}"/></c:if>
                <div data-id = ${industry.id} class="industry-item-cont show-${industry.id} ${status2.first?' first':''}">
                    <c:forEach items="${industry.children}" var="children" varStatus="status2">
                        <c:if test="${children.id == industryId}"><c:set var="topId" value="${industry.id}"/></c:if>
                        <dl>
                            <dt><a data-id="${children.id}" href="javascript:void(0)">${children.industry}</a></dt>
                            <c:forEach items="${children.children}" var="children2">
                                <c:if test="${children2.id == industryId}"><c:set var="topId" value="${industry.id}"/></c:if>
                                <dd><a ${industryId==children2.id?'class="on"':''} data-id="${children2.id}" href="javascript:void(0)">${children2.industry}</a></dd>
                            </c:forEach>
                        </dl>
                    </c:forEach>
                </div>
            </c:forEach>
            <div class="industry-tab">
                <ul>
                    <c:forEach items="${industryList}" var="industry" varStatus="status">
                        <li <c:if test="${topId == industry.id || (topId == '' && status.first)}">class="on"</c:if> data-id= ${industry.id}>
                            <a href="javascript:void(0)">${industry.industry}<span class="arow-r"></span></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>
<style>
    <c:if test="${empty topId}">
    .first { display: block; }
    </c:if>
    <c:if test="${not empty topId}">
    .show-${topId} { display: block; }
    </c:if>
</style>
<c:if test="${!headless}">
    <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
</c:if>
<jsp:include page="/WEB-INF/public/public-js.jsp"/>
<script>
var industry_id=${industryId};
</script>
</body>
</html>
