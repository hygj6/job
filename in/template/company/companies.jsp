<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>公司列表 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/public-home-head.jsp"/>
        
        <c:set var="link" value="?city_id=${cityId}&sort=${querySort}&industry_id=${industryId}" />
        <c:set var="link_prev" value="${link}&page=${page > 1 ? page-1: 1}" />
        <c:set var="link_next" value="${link}&page=${page < pageTotal - 1 ? page+1: page}" />
        <div class="wrap main">
            <div class="left-cont hollow">
                <div class="left-cont">
                    <div class="search-cont">
                        <div class="condition-list active">
                            <dl data-id="${cityName.id}" data-name="${cityName.name}" id="cityId" ${(cityId!=0&&cityId!=23&&cityId!=815&&cityId!=1985&&cityId!=1962&&cityId!=943&&cityId!=2302)? 'class="active"':''}>
                                <dt>工作地点：</dt>
                                <dd>
                                    <ul>
                                        <li class="item ${cityId==0?'on':''}" data-id = "0">全国</li>
                                        <li class="item" data-id = "23">北京</li>
                                        <li class="item" data-id = "815">上海</li>
                                        <li class="item" data-id = "1985">深圳</li>
                                        <li class="item" data-id = "1962">广州</li>
                                        <li class="item" data-id = "943">杭州</li>
                                        <li class="item" data-id = "2302">成都</li>
                                        <li class="more">${(cityId!=0&&cityId!=23&&cityId!=815&&cityId!=1985&&cityId!=1962&&cityId!=943&&cityId!=2302)? '收起<i class="arow-t"></i>':'更多<i class="arow-b"></i>'}</li>
                                    </ul>
                                    <ul class="details">
                                        <li class="item" data-id = "833">南京</li>
                                        <li class="item" data-id = "1707">武汉</li>
                                        <li class="item" data-id = "2833">西安</li>
                                        <li class="item" data-id = "1181">厦门</li>
                                        <li class="item" data-id = "1825">长沙</li>
                                        <li class="item" data-id = "871">苏州</li>
                                        <li class="item" data-id = "41">天津</li>
                                        <li class="item" data-id = "2262">重庆</li>
                                        <li class="item" data-id = "1529">郑州</li>
                                        <li class="item" data-id = "1385">青岛</li>
                                        <li class="item" data-id = "1045">合肥</li>
                                        <li class="item" data-id = "1167">福州</li>
                                        <li class="item" data-id = "1374">济南</li>
                                        <li class="item" data-id = "502">大连</li>
                                        <li class="item" data-id = "1992">珠海</li>
                                        <li class="item" data-id = "845">无锡</li>
                                        <li class="item" data-id = "2004">佛山</li>
                                        <li class="item" data-id = "2084">东莞</li>
                                        <li class="item" data-id = "957">宁波</li>
                                        <li class="item" data-id = "864">常州</li>
                                        <li class="item" data-id = "488">沈阳</li>
                                        <li class="item" data-id = "59">石家庄</li>
                                        <li class="item" data-id = "2605">昆明</li>
                                        <li class="item" data-id = "1262">南昌</li>
                                        <li class="item" data-id = "2105">南宁</li>
                                        <li class="item" data-id = "673">哈尔滨</li>
                                        <li class="item" data-id = "2231">海口</li>
                                        <li class="item" data-id = "2086">中山</li>
                                        <li class="item" data-id = "2507">贵阳</li>
                                        <li class="item" data-id = "603">长春</li>
                                        <li class="item" data-id = "241">太原</li>
                                        <li class="item" data-id = "981">嘉兴</li>
                                        <li class="item" data-id = "1456">泰安</li>
                                        <li class="item" data-id = "879">昆山</li>
                                        <li class="item" data-id = "1418">烟台</li>
                                        <li class="item" data-id = "2951">兰州</li>
                                        <li class="item" data-id = "1207">泉州</li>
                                        <li id="allCity" class="all">全部城市</li>
                                    </ul>
                                </dd>
                            </dl>
                            <dl id="industryId" ${(industryId!=0&&industryId!=7&&industryId!=56&&industryId!=164&&industryId!=228)? 'class="active"':''}>
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
                            <dl>
                                <dt>排序方式：</dt>
                                <dd>
                                    <ul id="querySort">
                                        <li data-type = "DEFAULT" <c:if test="${querySort == 'DEFAULT'}">class="on"</c:if> >默认</li>
                                        <li data-type = "JOB_COUNT" <c:if test="${querySort == 'JOB_COUNT'}">class="on"</c:if> >职位数量</li>
                                        <li data-type = "RESUME_HANDLER_RATE" <c:if test="${querySort == 'RESUME_HANDLER_RATE'}">class="on"</c:if> >简历处理率</li>
                                    </ul>
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
                        <div class="blank-2"></div>
                        <div class="company-base-detailed-list">
                            <ul>
                                <c:forEach items="${companies.company}" var="company">
                                    <li class="item">
                                        <div class="info">
                                            <div class="logo-company">
                                                <a href="/companies/${company.id}.html">
                                                <img width="56" height="56" src="${company.logoUrl}"/>
                                                </a>
                                            </div>
                                            <p class="name-company">
                                                <a href="/companies/${company.id}.html">${(empty company.abbreviation)?company.name:company.abbreviation}<i class="icon icon-icon_link"></i></a>
                                            </p>
                                            <p class="slogan-company">${company.brief}</p>
                                            <div class="tags">
                                                <div class="tag"><i style="font-size: 16px;" class="icon icon-icon_location"></i>${fn:replace(company.area, '市', '')}</div>
                                                <div class="tag"><i class="icon icon-icon_industry"></i>${company.industry}</div>
                                            </div>
                                        </div>
                                        <div class="bottom-bar">
                                            <div class="tag">
                                                <p class="label">${company.jobCount}个</p>
                                                <p class="tip">在招职位</p>
                                                <i class="line"></i>
                                            </div>
                                            <div class="tag">
                                                <p class="label">${company.resumeHandlerRate}%</p>
                                                <p class="tip">简历及时处理率</p>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <c:if test="${companies.companyCount==0}">
                            <jsp:include page="/WEB-INF/public/public-unusual-state.jsp" flush="true">
                                <jsp:param name="top" value="100px"/>
                                <jsp:param name="msg" value="没有找到相关公司"/>
                            </jsp:include>
                        </c:if>
                        <c:if test="${companies.companyCount>0}">
                            <div style="padding-top: 50px;" id="pagination"></div>
                        </c:if>
                    </div>
                </div>
            </div>
            <div id="catalog" class="right-cont info-brief">
                <p class="title-modular">最近浏览公司</p>
                <div class="job-base-list">
                    <ul>
                        <c:forEach items="${recentCompanies}" var="company">
                            <li>
                                <div class="company-logo">
                                    <img width="80" height="80" src="${company.logoUrl}"/>
                                </div>
                                <div class="text">
                                    <p class="job"><a target="_blank" href="/companies/${company.id}.html">${(empty company.abbreviation)?company.name:company.abbreviation}</a></p>
                                    <p class="other">${company.industry}</p>
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
            <jsp:param name="total" value="${companies.companyCount}"/>
            <jsp:param name="size" value="16"/>
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