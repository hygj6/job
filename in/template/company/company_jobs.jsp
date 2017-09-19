<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${company.name}(${company.abbreviation})的招聘职位 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/public-home-head.jsp"/>
        <div class="main contain-header modular-item" style="padding: 0; overflow: hidden;">
            <div class="wrap">
            <div class="company-info modular-box">
                <div class="company-logo up-avatar-box" style="margin-top:10px;">
                    <img style="position: relative; z-index:8;" id="logoView" src="${company.logoUrl}"/>
                </div>
                <div id="update-base-info" style="margin-top:0px;" class="text-info">
                    <div class="resbox">
                        <h3 style="height: 43px;"><a <c:if test='${not empty company.webUrl}'>href="<c:if test="${!fn:startsWith(company.webUrl, 'http')}">http://</c:if>${company.webUrl}"</c:if> class="vm-abbreviation" rel="nofollow" target="_blank">${company.abbreviation}</a><c:if test='${not empty company.webUrl}'><i class="icon icon-icon_link"></i></c:if></h3>
                        <p style="min-height:25px;" class="tip vm-brief">${company.brief}</p>
                        <div class="edit-group" style="right: 20px; top: 10px;">
                        </div>
                    </div>
                    <ul class="list-state">
                        <li class="first">
                            <p class="nub">${company.countJob}个</p>
                            <p class="label-state" data-tip="该公司的在招职位数量">招聘职位<i class="icon icon-tip"></i></p>
                        </li>
                        <li>
                            <p class="nub">
                                <c:choose>
                                    <c:when test="${company.resumeProcessingRate < 0}">
                                        --
                                    </c:when>
                                    <c:otherwise>
                                        ${company.resumeProcessingRate}%
                                    </c:otherwise>
                                </c:choose>
                            <p class="label-state" data-tip="该公司所有职位收到的简历中，在投递后7天内处理完成的简历所占比例">简历及时处理率<i class="icon icon-tip"></i></p>
                        </li>
                        <li>
                            <p class="nub">
                                <c:if test="${company.resumeProcessingTime.timeType == 'NONE'}">
                                    --
                                </c:if>
                                <c:if test="${company.resumeProcessingTime.timeType == 'SECOND'}">
                                    1小时
                                </c:if>
                                <c:if test="${company.resumeProcessingTime.timeType == 'MINUTE'}">
                                    1小时
                                </c:if>
                                <c:if test="${company.resumeProcessingTime.timeType == 'HOUR'}">
                                    ${company.resumeProcessingTime.count}小时
                                </c:if>
                                <c:if test="${company.resumeProcessingTime.timeType == 'DAY'}">
                                    ${company.resumeProcessingTime.count}天
                                </c:if>
                            </p>
                            <p class="label-state" data-tip="该公司的所有职位管理者完成简历处理的平均用时">简历处理用时<i class="icon icon-tip"></i></p>
                        </li>
                        <li>
                            <p class="nub">
                                <c:if test="${empty company.loginTime.dateType}">
                                    --
                                </c:if>
                                <c:if test="${company.loginTime.dateType == 'MOMENT'}">
                                    刚刚
                                </c:if>
                                <c:if test="${company.loginTime.dateType == 'MINUTE'}">
                                    ${company.loginTime.time}分钟前
                                </c:if>
                                <c:if test="${company.loginTime.dateType == 'HOUR'}">
                                    ${company.loginTime.time}小时前
                                </c:if>
                                <c:if test="${company.loginTime.dateType == 'YESTERDAY'}">
                                    昨天
                                </c:if>
                                <c:if test="${company.loginTime.dateType == 'DAYAGO'}">
                                    ${company.loginTime.time}天前
                                </c:if>
                                <c:if test="${company.loginTime.dateType == 'MONTH'}">
                                    ${company.loginTime.time}月前
                                </c:if>
                                <c:if test="${company.loginTime.dateType == 'LASTYEAR'}">
                                    去年
                                </c:if>
                                <c:if test="${company.loginTime.dateType == 'YEAR'}">
                                    ${company.loginTime.time}年前
                                </c:if>
                            </p>
                            <p class="label-state" data-tip="该公司职位管理者最近一次登录时间">企业登录<i class="icon icon-tip"></i></p>
                        </li>
                    </ul>
                </div>
            </div>
            </div>
        </div>
        <div class="wrap main">    
            <div class="left-cont">
                <div class="nav-tab">
                    <ul>
                        <li><a href="/companies/${company.id}.html">公司主页</a></li>
                        <li class="on"><a href="/companies/${company.id}/jobs/">招聘职位</a></li>
                    </ul>
                </div>
                <div class="job-list">
                    <c:if test="${jobs.size()>0}">
                    <p class="title-describe">共有<span class="nub">${total}</span>个在招职位</p>
                    <c:forEach items="${jobs}" var="job">
                        <div class="item">
                            <div class="job-base-info">
                                <p class="job-name"><a title="${job.name}[${job.city}]" href="/jobs/${job.id}.html">${job.name}[${job.city}]</a></p>
                                <p class="time">
                                    <c:if test="${empty job.refreshDate}"><fmt:formatDate value="${job.createDate}" pattern="yyyy-MM-dd HH:mm"/></c:if>
                                    <c:if test="${!empty job.refreshDate}"><fmt:formatDate value="${job.refreshDate}" pattern="yyyy-MM-dd HH:mm"/></c:if>发布
                                </p>
                            </div>
                            <div class="job-other-info">
                                <p class="salary">${job.salaryMin}k ~ ${job.salaryMax}k</p>
                                <p class="other">${job.experience.experience} / ${job.education.education} / ${job.workType.workType}</p>
                            </div>
                            <a class="btn" href="/jobs/${job.id}.html">查看职位</a>
                        </div>
                    </c:forEach>
                    <div style="padding-top: 50px;" id="pagination"></div>
                    </c:if>
                    <c:if test="${jobs.size()==0}">
                    <c:choose>
                        <c:when test="${isMyself}">
                            <jsp:include page="/WEB-INF/public/public-unusual-state.jsp" flush="true">
                                <jsp:param name="top" value="100px"/>
                                <jsp:param name="msg" value="当前没有职位"/>
                                <jsp:param name="btnUrl" value="/companies/job/add"/>
                                <jsp:param name="btnLabel" value="发布职位"/>
                            </jsp:include>
                        </c:when>
                        <c:otherwise>
                            <jsp:include page="/WEB-INF/public/public-unusual-state.jsp" flush="true">
                                <jsp:param name="top" value="100px"/>
                                <jsp:param name="msg" value="当前没有职位"/>
                            </jsp:include>
                        </c:otherwise>
                    </c:choose>
                    </c:if>
                </div>
            </div>
            <div class="right-cont info-brief">
                <div class="modular-item">
                    <p class="title-modular">基本信息</p>
                    <div class="base-list" id="update-info-res">
                        <ul>
                            <li><i class="icon icon-icon_people"></i><span class="text vm-personnels">${company.personnels}</span></li>
                            <li><i class="icon icon-icon_location"></i><span class="text vm-address">
                            <c:forEach items="${company.addresses}" var="addresse" varStatus="status">
                                <c:if test="${status.first}">
                                    ${addresse.province}${addresse.city}${addresse.district}
                                </c:if>
                            </c:forEach>
                            </span></li>
                            <li date="${company.industry.parent.parent.industry}/${company.industry.parent.industry}"><i class="icon icon-icon_industry"></i><span class="text vm-industry">${company.industry.industry}</span></li>
                            <li><i class="icon icon-icon_flatform"></i>
                            <span class="text vm-exhibition">
                            <c:forEach items="${company.exhibitions}" var="exhibition" varStatus="status">${exhibition}<c:if test="${!status.last}">/</c:if></c:forEach>
                            </span>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="blank-2"></div>
                <div class="split-line"></div>
                <div class="modular-item">
                    <p class="title-modular">公司标签</p>
                    <ul id="tag-list-res" class="tag-list">
                        <c:forEach items="${company.tags}" var="tag">
                        <li>${tag}</li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="blank-2"></div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <jsp:include page="/WEB-INF/public/public-page.jsp" flush="true">
            <jsp:param name="total" value="${total}"/>
            <jsp:param name="size" value="10"/>
        </jsp:include>
</html>
