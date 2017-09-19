<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>公司列表 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/public-home-head.jsp"/>
        <div class="wrap main">
            <div class="left-cont">
                <div style="width: 621px;" class="search-box">
                    <form id="keywords">
                       <input value="${keywords}" name="keywords" style="width: 580px;" placeholder="搜索职位或者公司" type="text" class="input-text">
                       <button type="submit">搜索</button>
                    </form>
                </div>
                <div class="blank-2"></div>
                <div style="margin-top: 0;" class="nav-tab theme-inside">
                    <ul>
                        <li><a id="job-link" href="/jobs/?type=1">职位
                            <c:choose>
                                <c:when test="${jobTotal > 500}">
                                    （500+）
                                </c:when>
                                <c:otherwise>
                                    （${jobTotal}）
                                </c:otherwise>
                            </c:choose>
                        </a></li>
                        <li class="on"><a id="company-link" href="/jobs/?type=2">公司
                            <c:choose>
                                <c:when test="${companyTotal > 500}">
                                    （500+）
                                </c:when>
                                <c:otherwise>
                                    （${companyTotal}）
                                </c:otherwise>
                            </c:choose>
                        </a></li>
                    </ul>
                </div>
                <div>
                    <div class="search-cont">
                        <ul class="company-base-list">
                            <c:forEach items="${companies}" var="company">
                                <li>
                                    <div class="company-logo">
                                        <a href="/companies/${company.id}.html">
                                            <img src="${company.logoUrl}" width="80" height="80"/>
                                        </a>    
                                    </div>
                                    <div class="company-info">
                                        <p class="base-info"><strong><a href="/companies/${company.id}.html">${(empty company.abbreviation)?company.name:company.abbreviation}</a></strong>"${company.brief}"</p>
                                        <p class="other-info">
                                            <span class="item"><i class="icon icon-icon_location"></i>${fn:replace(company.area, '市', '')}</span>
                                            <span class="item"><i class="icon icon-icon_industry"></i>${company.industry}</span>
                                            <span class="item"><i class="icon icon-icon_job"></i><span class="red">${company.jobCount}</span>个在招职位</span>
                                        </p>
                                    </div>
                                    <a target="_blank" class="btn" href="/companies/${company.id}.html">查看公司</a>
                                </li>
                            </c:forEach>
                        </ul>
                        <c:if test="${companyTotal==0}">
                            <jsp:include page="/WEB-INF/public/public-unusual-state.jsp" flush="true">
                                <jsp:param name="top" value="100px"/>
                                <jsp:param name="msg" value="没有找到相关公司"/>
                            </jsp:include>
                        </c:if>
                        <c:if test="${companyTotal>0}">
                            <div style="padding-top:20px;" id="pagination"></div>
                        </c:if>
                    </div>
                </div>
            </div>
            <div id="catalog" class="right-cont info-brief">
                <p class="title-modular">最近浏览</p>
                <div class="job-base-list">
                    <ul>
                        <c:forEach items="${recentJobs}" var="job">
                            <li>
                                <div class="company-logo">
                                    <img width="80" height="80" src="${job.company.logoUrl}"/>
                                </div>
                                <div class="text">
                                    <p class="job"><a title="${job.name}" href="/jobs/${job.id}.html">${job.name}</a></p>
                                    <p class="wages">
                                        <jsp:include page="/WEB-INF/public/public-salary.jsp" flush="true">
                                            <jsp:param name="basic" value="${job.salaryBasic}"/>
                                            <jsp:param name="max" value="${job.salaryMin}"/>
                                            <jsp:param name="min" value="${job.salaryMax}"/>
                                        </jsp:include>
                                    </p>
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
        <jsp:include page="/WEB-INF/public/public-page.jsp" flush="true">
            <jsp:param name="total" value="${companyTotal>500?500:companyTotal}"/>
            <jsp:param name="size" value="15"/>
        </jsp:include>
    </body>
    <script>
    $(window).scroll(function(){
        var t1=$(window).scrollTop();
        if(t1>=110){
            $("#catalog").addClass("fixed");
        }else{
            $("#catalog").removeClass("fixed");
        }
    });
    </script>
</html>