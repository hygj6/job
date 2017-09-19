<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fun" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tradehelp.job.core.common.factory.TimeTypeUtils" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>职位列表 - 外贸帮手网</title>
    <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
</head>
    <body>
        <jsp:include page="/WEB-INF/public/public-home-head.jsp" />
        <c:set var="link" value="?city_id=${cityId}&sort=${sort}&industry_id=${industryId}" />
        <c:set var="link_prev" value="${link}&page=${page > 1 ? page-1: 1}" />
        <c:set var="link_next" value="${link}&page=${page < pageTotal - 1 ? page+1: page}" />
        <div class="wrap main">
            <div class="left-cont hollow">
                <div class="left-cont">
                    <div style="width: 621px;" class="search-box">
                        <form id="keywords">
                            <input value="${keywords}" name="keywords" style="width:580px;" placeholder="搜索职位或者公司" type="text" class="input-text">
                            <button type="submit">搜索</button>
                        </form>
                    </div>
                    <div class="blank-2"></div>
                    <div class="nav-tab theme-inside" style="margin-top: 0;">
                        <ul>
                            <li class="on">
                                <a id="job-link" href="/jobs/?type=1">职位
                                    <c:choose>
                                        <c:when test="${jobTotal > 500}">（500+）</c:when>
                                        <c:otherwise>（${jobTotal}）</c:otherwise>
                                    </c:choose>
                                </a>
                            </li>
                            <li>
                                <c:choose>
                                    <c:when test="${companyTotal > 0}">
                                        <a id="company-link" href="/jobs/?type=2">公司
                                            <c:choose>
                                                <c:when test="${companyTotal > 500}">（500+）</c:when>
                                                <c:otherwise>（${companyTotal}）</c:otherwise>
                                            </c:choose>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a style="cursor: default;"> 公司 （0）</a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </ul>
                    </div>
                    <div class="blank-2"></div>
                    <div class="search-cont">
                        <ul class="company-base-list">
                            <c:forEach items="${companies}" var="company" varStatus="status">
                                <c:if test="${status.first}">
                                    <li>
                                        <div class="company-logo">
                                            <a href="/companies/${company.id}.html"><img src="${company.logoUrl}" width="80" height="80" /></a>
                                        </div>
                                        <div class="company-info">
                                            <p class="base-info">
                                                <strong><a href="/companies/${company.id}.html">${(empty company.abbreviation)?company.name:company.abbreviation}</a></strong>"${company.brief}"</p>
                                            <p class="other-info">
                                                <span class="item"><i class="icon icon-icon_location"></i>${fun:replace(company.area, '市', '')}</span>
                                                <span class="item"><i class="icon icon-icon_industry"></i>${company.industry}</span>
                                                <span class="item"><i class="icon icon-icon_job"></i><span class="red">${company.jobCount}</span>个在招职位</span>
                                            </p>
                                        </div>
                                        <a class="btn" href="/companies/${company.id}.html">查看公司</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                        <div class="condition-list active">
                            <dl data-id="${cityName.id}" data-name="${cityName.name}" id="cityId" ${(cityId!=0&&cityId!=23&&cityId!=815&&cityId!=1985&&cityId!=1962&&cityId!=943&&cityId!=2302)? 'class="active"': ''}>
                                <dt>工作地点：</dt>
                                <dd>
                                    <ul>
                                        <li class="item ${cityId==0?'on':''}" data-id="0">全国</li>
                                        <li class="item" data-id="23">北京</li>
                                        <li class="item" data-id="815">上海</li>
                                        <li class="item" data-id="1985">深圳</li>
                                        <li class="item" data-id="1962">广州</li>
                                        <li class="item" data-id="943">杭州</li>
                                        <li class="item" data-id="2302">成都</li>
                                        <li class="more">${(cityId!=0&&cityId!=23&&cityId!=815&&cityId!=1985&&cityId!=1962&&cityId!=943&&cityId!=2302)? '收起<i class="arow-t"></i>':'更多<i class="arow-b"></i>'}</li>
                                    </ul>
                                    <ul class="details">
                                        <li class="item" data-id="833">南京</li>
                                        <li class="item" data-id="1707">武汉</li>
                                        <li class="item" data-id="2833">西安</li>
                                        <li class="item" data-id="1181">厦门</li>
                                        <li class="item" data-id="1825">长沙</li>
                                        <li class="item" data-id="871">苏州</li>
                                        <li class="item" data-id="41">天津</li>
                                        <li class="item" data-id="2262">重庆</li>
                                        <li class="item" data-id="1529">郑州</li>
                                        <li class="item" data-id="1385">青岛</li>
                                        <li class="item" data-id="1045">合肥</li>
                                        <li class="item" data-id="1167">福州</li>
                                        <li class="item" data-id="1374">济南</li>
                                        <li class="item" data-id="502">大连</li>
                                        <li class="item" data-id="1992">珠海</li>
                                        <li class="item" data-id="845">无锡</li>
                                        <li class="item" data-id="2004">佛山</li>
                                        <li class="item" data-id="2084">东莞</li>
                                        <li class="item" data-id="957">宁波</li>
                                        <li class="item" data-id="864">常州</li>
                                        <li class="item" data-id="488">沈阳</li>
                                        <li class="item" data-id="59">石家庄</li>
                                        <li class="item" data-id="2605">昆明</li>
                                        <li class="item" data-id="1262">南昌</li>
                                        <li class="item" data-id="2105">南宁</li>
                                        <li class="item" data-id="673">哈尔滨</li>
                                        <li class="item" data-id="2231">海口</li>
                                        <li class="item" data-id="2086">中山</li>
                                        <li class="item" data-id="2507">贵阳</li>
                                        <li class="item" data-id="603">长春</li>
                                        <li class="item" data-id="241">太原</li>
                                        <li class="item" data-id="981">嘉兴</li>
                                        <li class="item" data-id="1456">泰安</li>
                                        <li class="item" data-id="879">昆山</li>
                                        <li class="item" data-id="1418">烟台</li>
                                        <li class="item" data-id="2951">兰州</li>
                                        <li class="item" data-id="1207">泉州</li>
                                        <li id="allCity" class="all">全部城市</li>
                                    </ul>
                                </dd>
                            </dl>
                            <dl id="experienceId">
                                <dt>${job.companyCount}工作经验：</dt>
                                <dd>
                                    <ul>
                                        <li class="item ${experienceId==0?'on':''}">不限</li>
                                        <c:forEach items="${experiences}" var="experience" varStatus="status">
                                            <c:if test="${status.index != 0}">
                                                <li class="item ${experienceId==experience.id?'on':''}" data-id="${experience.id}">${experience.experience}</li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </dd>
                            </dl>
                            <dl id="educationId">
                                <dt>学历要求：</dt>
                                <dd>
                                    <ul>
                                        <li class="item ${educationId==0?'on':''}">不限</li>
                                        <c:forEach items="${educationes}" var="education" varStatus="status">
                                            <c:if test="${status.index != 0}">
                                                <li class="item ${educationId==education.id?'on':''}" data-id="${education.id}">${education.education}</li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </dd>
                            </dl>
                            <dl id="industryId" ${(industryId!=0&&industryId!=7&&industryId!=56&&industryId!=164&&industryId!=228)? 'class="active"': ''}>
                                <dt>行业领域：</dt>
                                <dd>
                                    <ul>
                                        <li class="item ${industryId==0?'on':''}">不限</li>
                                        <c:forEach items="${industries}" var="industry" varStatus="status">
                                            <c:if test="${status.index < 4}">
                                                <li class="item ${industryId==industry.id?'on':''}" data-id="${industry.id}">${industry.industry}</li>
                                            </c:if>
                                        </c:forEach>
                                        <li class="more">${(industryId!=0&&industryId!=7&&industryId!=56&&industryId!=164&&industryId!=228)? '收起<i class="arow-t"></i>':'更多<i class="arow-b"></i>'}</li>
                                    </ul>
                                    <ul class="details">
                                        <c:forEach items="${industries}" var="industry" varStatus="status">
                                            <c:if test="${status.index > 3}">
                                                <li class="item ${industryId==industry.id?'on':''}" data-id="${industry.id}">${industry.industry}</li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </dd>
                            </dl>
                        </div>
                        <div class="blank-2"></div>
                        <div class="base-screen">
                            <dl id="querySort">
                                <dt>排序方式：</dt>
                                <dd>
                                    <ul>
                                        <li data-type="DEFAULT" <c:if test="${sort == 'DEFAULT'}">class="on"</c:if> >默认</li>
                                        <li data-type="NEW" <c:if test="${sort == 'NEW'}">class="on"</c:if>>最新</li>
                                    </ul>
                                </dd>
                            </dl>
                            <dl>
                                <dt>薪资：</dt>
                                <dd>
                                    <select class="select-custom" id="salary">
                                        <option value="">不限</option>
                                        <option value="1-2">2K以下</option>
                                        <option value="2-5">2k-5k</option>
                                        <option value="5-10">5k-10k</option>
                                        <option value="10-15">10k-15k</option>
                                        <option value="15-25">15k-25k</option>
                                        <option value="25-50">25k-50k</option>
                                        <option value="50-100">50k以上</option>
                                    </select>
                                </dd>
                            </dl>
                            <dl style="padding-left:20px;">
                                <dt>工作性质：</dt>
                                <dd>
                                    <select class="select-custom" id="work_type">
                                        <option value="">不限</option>
                                        <c:forEach items="${workTypes}" var="workType">
                                            <option ${workTypeId==workType.id? 'selected="selected"': ''} value="${workType.id}">${workType.workType}</option>
                                        </c:forEach>
                                    </select>
                                </dd>
                            </dl>
                            <c:if test="${pageTotal>0}">
                                <div class="page-tool">
                                    <div class="nub">
                                        <span>${page}</span>/${pageTotal}
                                    </div>
                                    <a class="prev" href="${link_prev}">
                                        <span class="arow-l"><i></i></span>
                                    </a>
                                    <a class="next" href="${link_next}">
                                        <span class="arow-r"><i></i></span>
                                    </a>
                                </div>
                            </c:if>
                        </div>
                        <div class="search-job-list">
                            <c:forEach items="${jobs}" var="job">
                                <li>
                                    <div class="job-info">
                                        <p class="job-name">
                                            <a title="${job.name}[${job.district}]" href="/jobs/${job.id}.html">${job.name} [${job.district}]</a>
                                            <span class="time">
                                            <c:set var="createDate" value="${empty job.refreshDate?job.createDate:job.refreshDate}" scope="request"/>
                                            <% pageContext.setAttribute("timeTypePojo", TimeTypeUtils.getDateType((Date) request.getAttribute("createDate"))); %>
                                            <c:set var="timeTypePojo" value="${timeTypePojo}"/>
                                            <c:choose>
                                                <c:when test="${timeTypePojo.dateType == 'MOMENT'}">刚刚</c:when>
                                                <c:when test="${timeTypePojo.dateType == 'MINUTE'}">${timeTypePojo.time}分钟前</c:when>
                                                <c:when test="${timeTypePojo.dateType == 'HOUR'}">${timeTypePojo.time}小时前</c:when>
                                                <c:when test="${timeTypePojo.dateType == 'YESTERDAY'}">昨天</c:when>
                                                <c:when test="${timeTypePojo.dateType == 'DAYAGO' and timeTypePojo.time < 4}">${timeTypePojo.time}天前</c:when>
                                                <c:otherwise><fmt:formatDate value="${createDate}" pattern="yyyy-MM-dd"/></c:otherwise>
                                            </c:choose> 发布
                                            </span>
                                        </p>
                                        <p class="other">
                                            <span class="pay"><jsp:include page="/WEB-INF/public/public-salary.jsp" flush="true">
                                            <jsp:param name="basic" value="${job.salaryBasic}"/>
                                            <jsp:param name="max" value="${job.salaryMin}"/>
                                            <jsp:param name="min" value="${job.salaryMax}"/>
                                        </jsp:include></span> ${job.experience.experience}/${job.education.education}/${job.workType.workType}
                                        </p>
                                    </div>
                                    <div class="company-info">
                                        <div class="company-logo">
                                            <a href="/companies/${job.company.id}.html">
                                                <img src="${job.company.logoUrl}" width="80" height="80">
                                            </a>
                                        </div>
                                        <div class="text">
                                            <p class="company-name">
                                                <a href="/companies/${job.company.id}.html"><span>${job.company.abbreviation}</span> [${job.city}]</a>
                                            </p>
                                            <p>${job.company.industry}</p>
                                        </div>
                                    </div>
                                    <div class="bottom-bar">
                                        <div class="tag-list">
                                            <c:forEach items="${job.tagList}" var="tag">
                                                <span class="item">${tag}</span>
                                            </c:forEach>
                                        </div>
                                        <p title="${job.company.brief}" class="slogan">"${job.company.brief}"</p>
                                    </div>
                                </li>
                            </c:forEach>
                        </div>
                        <c:if test="${jobTotal==0}">
                            <jsp:include page="/WEB-INF/public/public-unusual-state.jsp" flush="true">
                                <jsp:param name="top" value="100px" />
                                <jsp:param name="msg" value="没有找到相关职位" />
                            </jsp:include>
                        </c:if>
                        <c:if test="${jobTotal>0}">
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
                                    <img width="80" height="80" src="${job.company.logoUrl}" />
                                </div>
                                <div class="text">
                                    <p class="job">
                                        <a title="${job.name}" href="/jobs/${job.id}.html">${job.name}</a>
                                    </p>
                                    <p class="wages">
                                        <jsp:include page="/WEB-INF/public/public-salary.jsp" flush="true">
                                            <jsp:param name="basic" value="${job.salaryBasic}" />
                                            <jsp:param name="max" value="${job.salaryMin}" />
                                            <jsp:param name="min" value="${job.salaryMax}" />
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

        <jsp:include page="/WEB-INF/public/public-foot.jsp" />
        <jsp:include page="/WEB-INF/public/public-js.jsp" />
        <jsp:include page="/WEB-INF/public/public-page.jsp" flush="true">
            <jsp:param name="total" value="${jobTotal>500?500:jobTotal}" />
            <jsp:param name="size" value="15" />
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