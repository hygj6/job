<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tradehelp.job.core.common.factory.TimeTypeUtils" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>职位详情 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/public-home-head.jsp"/>
        <div class="wrap main">
            <div class="left-cont large-padding">
                <div class="job-details-cont">
                    <div class="base-info">
                        <p class="department">${job.department}</p>
                        <p class="job-name">${job.name}</p>
                        <p class="job-pay">
                            <jsp:include page="/WEB-INF/public/public-salary.jsp" flush="true">
                                <jsp:param name="basic" value="${job.salaryBasic}"/>
                                <jsp:param name="max" value="${job.salaryMin}"/>
                                <jsp:param name="min" value="${job.salaryMax}"/>
                            </jsp:include></p>
                        <p class="other-info">${job.city} / 经验${job.experience.experience} / ${job.education.education}及以上 / ${job.workType.workType}</p>
                        <p class="time">发布于  <c:set var="createDate" value="${empty job.refreshDate?job.createDate:job.refreshDate}" scope="request"/>
                            <% pageContext.setAttribute("timeTypePojo", TimeTypeUtils.getDateType((Date) request.getAttribute("createDate"))); %>
                            <c:set var="timeTypePojo" value="${timeTypePojo}"/>
                            <c:choose>
                                <c:when test="${timeTypePojo.dateType == 'MOMENT'}">刚刚</c:when>
                                <c:when test="${timeTypePojo.dateType == 'MINUTE'}">${timeTypePojo.time}分钟前</c:when>
                                <c:when test="${timeTypePojo.dateType == 'HOUR'}">${timeTypePojo.time}小时前</c:when>
                                <c:when test="${timeTypePojo.dateType == 'YESTERDAY'}">昨天</c:when>
                                <c:when test="${timeTypePojo.dateType == 'DAYAGO' and timeTypePojo.time < 4}">${timeTypePojo.time}天前</c:when>
                                <c:otherwise><fmt:formatDate value="${createDate}" pattern="yyyy-MM-dd HH:mm"/></p></c:otherwise>
                            </c:choose>
                        </p>
                        <c:choose>
                            <c:when test="${isDelivered}"><button disabled type="button" id="delivery" class="btn">已投递</button></c:when>
                            <c:when test="${job.jobStatus=='OFFLINE'}"><button disabled type="button" id="delivery" class="btn">已下线</button></c:when>
                            <c:otherwise>
                                <shiro:hasRole name="company">
                                    <button disabled="disabled" type="button" class="btn">投递简历</button>
                                </shiro:hasRole>
                                <shiro:guest>
                                    <a href="/login?redirect_url=/jobs/${job.id}.html" class="btn">投递简历</a>
                                </shiro:guest>
                                <shiro:hasRole name="candidate">
                                    <c:if test="${isAllowCandidateDelivery}">
                                        <button type="button" id="delivery" class="btn">投递简历</button>
                                    </c:if>
                                    <c:if test="${!isAllowCandidateDelivery}">
                                        <a href="/main?redirect_url=/jobs/${job.id}.html" id="delivery" class="btn">投递简历</a>
                                    </c:if>
                                </shiro:hasRole>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="blank-2"></div>
                <div class="split-line"></div>
                <div class="describe-box">
                    <p class="title-modular">职位诱惑</p>
                    <div class="describe">
                        <c:forEach items="${job.highlightList}" var="highlight" varStatus="status">
                            ${highlight}
                            <c:if test="${!status.last}">,&nbsp;</c:if>
                        </c:forEach>
                    </div>
                    <p class="title-modular">职位描述</p>
                    <div class="describe">${job.note}</div>
                    <div class="blank-2"></div>
                </div>
                <div class="split-line"></div>
                <div class="describe-box">
                    <p class="title-modular">工作地点</p>                            
                    <div class="describe"><i class="icon icon-location"></i>${job.address}
                        <c:if test="${job.latitude!=0}">
                            <a target="_blank" href="http://map.baidu.com/?latlng=${job.latitude},${job.longitude}">查看地图</a>
                        </c:if>    
                        <c:if test="${job.latitude==0}">
                            <a target="_blank" href="http://map.baidu.com/?newmap=1&ie=utf-8&s=s%26wd%3D${job.address}">查看地图</a>
                        </c:if>
                    </div>
                    <div class="blank-1"></div>
                    <div class="blank-2"></div>
                </div>
                <div class="split-line"></div>
                <p class="title-modular">发布人</p>
                <div class="hr-info">
                    <div class="base-info">
                        <div class="avatar">
                            <img src="${empty company.avatar?company.logoUrl:company.avatar}" height="60" width="60" />
                        </div>
                        <div class="text">
                            <p class="name">${(empty company.abbreviation)?company.name:company.abbreviation}</p>
                            <p class="job">联系人</p>
                        </div>
                    </div>
                    <ul class="info-list" style="margin-top: -2px;">
                        <li>
                            <p data-tip = "7天内职位发布者简历处理的效率" class="label">简历处理<i class="icon icon-tip"></i></p>
                            <c:if test="${timeObject.timeType == 'NONE'}">
                                <p class="state">--</p>
                            </c:if>
                            <c:if test="${timeObject.timeType == 'SECOND'}">
                                <p class="state">超快</p>
                            </c:if>
                            <c:if test="${timeObject.timeType == 'MINUTE'}">
                                <p class="state">超快</p>
                            </c:if>
                            <c:if test="${timeObject.timeType == 'HOUR'}">
                                <p class="state">快</p>
                            </c:if>
                            <c:if test="${timeObject.timeType == 'DAY'}">
                                <c:if test="${timeObject.count <= 2}">
                                    <p class="state">较快</p>
                                </c:if>
                                <c:if test="${timeObject.count == 3}">
                                    <p class="state">较慢</p>
                                </c:if>
                                <c:if test="${timeObject.count == 4}">
                                    <p class="state">慢</p>
                                </c:if>
                                <c:if test="${timeObject.count > 5}">
                                    <p class="state">超慢</p>
                                </c:if>
                            </c:if>
                            <p class="des">处理率<span>
                                <c:choose>
                                    <c:when test="${resumeProcessingRate < 0}">
                                        --
                                    </c:when>
                                    <c:otherwise>
                                        ${resumeProcessingRate}%
                                    </c:otherwise>
                                </c:choose>
                                </span><span class="spacing"></span>用时
                                <c:if test="${timeObject.timeType == 'NONE'}">
                                    --
                                </c:if>
                                <c:if test="${timeObject.timeType == 'SECOND'}">
                                    <span>1</span>小时</p>
                                </c:if>
                                <c:if test="${timeObject.timeType == 'MINUTE'}">
                                    <span>1</span>小时</p>
                                </c:if>
                                <c:if test="${timeObject.timeType == 'HOUR'}">
                                    <span>${timeObject.count}</span>小时</p>
                                </c:if>
                                <c:if test="${timeObject.timeType == 'DAY'}">
                                    <span>${timeObject.count}</span>天</p>
                                </c:if>
                        </li>
                        <li>
                            <p data-tip = "1个月内职位发布者最活跃时段统计" class="label">活跃时段<i class="icon icon-tip"></i></p>
                            <p class="state">全天</p>
                            <p class="des">
                                <c:choose>
                                    <c:when test="${activeTime < 0}">--</c:when>
                                    <c:when test="${activeTime > 12}">
                                        下午<span>${activeTime - 12}</span>
                                    </c:when>
                                    <c:otherwise>
                                        上午<span>${activeTime}</span>
                                    </c:otherwise>
                                </c:choose>
                                点最活跃</p>
                        </li>
                        
                        
                        
                        
                    </ul>
                </div>
            </div>
            <div class="right-cont info-brief">
                <div class="company-base-info">
                    <div class="company-logo">
                        <img src="${company.logoUrl}" width="100" height="100"/>
                    </div>
                    <p class="name">${(empty company.abbreviation)?company.name:company.abbreviation}</p>
                    <a class="btn-large" href="/companies/${company.id}.html">查看公司主页</a>
                    <div class="blank-2"></div>
                </div>
                <div class="split-line"></div>
                <p class="title-modular">基本信息</p>
                <div class="base-list">
                    <ul>
                        <li><i class="icon icon-icon_people"></i>${company.personnels}</li>
                        <li><i class="icon icon-icon_location"></i>${company.area}</li>
                        <li><i class="icon icon-icon_industry"></i>${company.industry}</li>
                        <li>
                            <i class="icon icon-icon_flatform"></i>
                            <c:forEach items="${company.exhibitions}" var="exhibition" varStatus="status">
                                ${exhibition}
                                <c:if test="${!status.last}">/</c:if>
                            </c:forEach>
                        </li>
                        <li><i class="icon icon-icon_website"></i><a rel="nofollow" target="_blank" href="<c:if test="${!fn:startsWith(company.webUrl, 'http')}">http://</c:if>${company.webUrl}">${company.webUrl}</a></li>
                    </ul>
                </div>
                <div class="blank-2"></div>
                <div class="split-line"></div>
                <p class="title-modular">相似职位</p>
                <div class="job-base-list">
                    <ul>
                        <c:forEach items="${similarJob}" var="job">
                            <li>
                                <div class="company-logo">
                                    <img src="${job.company.logoUrl}"/>
                                </div>
                                <div class="text">
                                    <p class="job"><a title="${job.name}" href="/jobs/${job.id}.html">${job.name}</a></p>
                                    <p class="wages">
                                        <jsp:include page="/WEB-INF/public/public-salary.jsp" flush="true">
                                            <jsp:param name="basic" value="${job.salaryBasic}"/>
                                            <jsp:param name="max" value="${job.salaryMin}"/>
                                            <jsp:param name="min" value="${job.salaryMax}"/>
                                        </jsp:include></p>
                                    <p title="${(empty job.company.abbreviation)?job.company.name:job.company.abbreviation}[${job.city}-${job.district}]" class="other">${(empty job.company.abbreviation)?job.company.name:job.company.abbreviation}[${job.city}-${job.district}]</p>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <jsp:include page="/WEB-INF/public/public-resume-delivery.jsp"/>
        <script type="text/javascript" src="//api.map.baidu.com/api?v=2.0&ak=vizCcjf5x8YKTG2DpMoZeBgK4RBifuhp"></script>
        <script type="text/javascript" src="//api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
        <link rel="stylesheet" href="//api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
        <script src="${url.cdn}/static/plugins/webuploader/webuploader.js"></script>
        <script>
        var job_id="${job.id}";
        var DeliveryId="";
        var ResumeUser="";
        </script>
    </body>
</html>