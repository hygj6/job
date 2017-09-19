<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>城市列表</title>
    <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
</head>
<body style="background: #fff;">
    <jsp:include page="/WEB-INF/public/public-home-head.jsp"/>
    <div class="wrap main">
        <div class="middle-cont" style="border:1px solid #e8e8e8;">
            <dl class="city-list">
                <dt style="text-align: left;">常用城市</dt>
                <dd><a data-id = "0" href="javascript:void(0)">全国</a></dd>
                <dd><a data-id = "23" href="javascript:void(0)">北京</a></dd>
                <dd><a data-id = "815" href="javascript:void(0)">上海</a></dd>
                <dd><a data-id = "1985" href="javascript:void(0)">深圳</a></dd>
                <dd><a data-id = "1962" href="javascript:void(0)">广州</a></dd>
                <dd><a data-id = "943" href="javascript:void(0)">杭州</a></dd>
                <dd><a data-id = "2302" href="javascript:void(0)">成都</a></dd>
                <dd><a data-id = "833" href="javascript:void(0)">南京</a></dd>
                <dd><a data-id = "1707" href="javascript:void(0)">武汉</a></dd>
                <dd><a data-id = "2833" href="javascript:void(0)">西安</a></dd>
                <dd><a data-id = "1181" href="javascript:void(0)">厦门</a></dd>
                <dd><a data-id = "1825" href="javascript:void(0)">长沙</a></dd>
                <dd><a data-id = "871" href="javascript:void(0)">苏州</a></dd>
                <dd><a data-id = "41" href="javascript:void(0)">天津</a></dd>
            </dl>
            <h6 class="min-title">按首字母查找</h6>
            <c:set var="initial" value="aa"/>
            <c:set var="ag" value="false"/>
            <c:forEach items="${cityList}" var="city" varStatus="status">
                <c:if test="${!city.initial.equals(initial)}">
                    <c:if test="${!status.first}">
                        </dl>
                    </c:if>
                        <c:set var="initial" value="${city.initial}"/>
                        <c:set var="initial" value="${city.initial}"/>
                        <dl class="city-list">
                        <dt>
                            <span class="word">${city.initial}</span>
                        </dt>
                        </c:if>
                            <dd><a data-id = "${city.id}" href="javascript:void(0)">${city.name}</a></dd>
                        <c:if test="${status.last}">
                        </dl>
                    </c:if>
            </c:forEach>
        </div>
    </div>
    <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
    <jsp:include page="/WEB-INF/public/public-js.jsp"/>
</body>
</html>
