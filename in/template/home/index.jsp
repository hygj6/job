<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>外贸帮手网 - 最专业的外贸人才招聘平台</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body>
        <div class="head head-index" style="z-index: 2; position: relative;">
            <jsp:include page="/WEB-INF/public/public-home-top-bar.jsp"/>
        </div>
        <div class="index-cont">
            <div class="search-tool wrap">
                <a href="/" class="logo">
                    <img height="51" width="196" src="../../img/search-logo.png"/>
                </a>
                <div class="search-box">
                    <form id="search-job">
                       <input name="keywords" placeholder="搜索职位或者公司" type="text" class="input-text"/>
                       <button type="submit">搜索</button>
                    </form>
                </div>
            </div>
            <div class="nav-index">
                <div class="wrap">
                    <div id="change-city" class="map-sign" data-id="${city_id}">
                        <span class="city-label"><i class="icon icon-location"></i><span id="city-name"><c:if test="${city_id==0}">全国</c:if><c:if test="${city_id==23}">北京</c:if><c:if test="${city_id==815}">上海</c:if><c:if test="${city_id==1962}">广州</c:if><c:if test="${city_id==1985}">深圳</c:if><c:if test="${city_id==943}">杭州</c:if>
                        </span></span>
                        <div class="hot-city" id="city-list">
                            <div class="base-info">
                                <p class="label-title">热门城市:</p>
                                <ul>
                                    <li><a href="javascript:void(0)" data-id="0" class="item">全国</a></li>
                                    <li><a href="javascript:void(0)" data-id="23" class="item">北京</a></li>
                                    <li><a href="javascript:void(0)" data-id="815" class="item">上海</a></li>
                                    <li><a href="javascript:void(0)" data-id="1962" class="item">广州</a></li>
                                    <li><a href="javascript:void(0)" data-id="1985" class="item">深圳</a></li>
                                    <li><a href="javascript:void(0)" data-id="943" class="item">杭州</a></li>
                                </ul>
                            </div>
                            <div class="base-list" style="display: none;">
                                <ul class="tab">
                                    <li class="on">ABCDE</li>
                                    <li>FGHJ</li>
                                    <li>KLMNP</li>
                                    <li>QRSTW</li>
                                    <li>XYZ</li>
                                </ul>
                                <ul class="list">
                                    <li>
                                        <span class="label">A</span>
                                        <a href="javascript:void(0)" data-id="23" class="item">北京</a>
                                        <a href="javascript:void(0)" data-id="815" class="item">上海</a>
                                        <a href="javascript:void(0)" data-id="1985" class="item">深圳</a>
                                        <a href="javascript:void(0)" data-id="1962" class="item">广州</a>
                                        <a href="javascript:void(0)" data-id="943" class="item">杭州</a>
                                    </li>
                                    <li>
                                        <span class="label">A</span>
                                        <a href="#" class="item">深圳</a>
                                        <a href="#" class="item">深圳</a>
                                        <a href="#" class="item">深圳</a>
                                        <a href="#" class="item">深圳</a>
                                        <a href="#" class="item">深圳</a>
                                        <a href="#" class="item">深圳</a>
                                        <a href="#" class="item">深圳</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <dl>
                        <dd><a class="on" href="/">首页</a></dd>
                        <dd><a href="/jobs/">职位</a></dd>
                        <dd><a href="/companies/">公司</a></dd>
                    </dl>
                </div>
            </div>
            <div class="main-index wrap">
                    <div class="left-menu">
                        <c:forEach items="${jobCategories}" var="jobCategory" varStatus="status">
                        <div class="item <c:if test="${status.last}">no-line</c:if>">
                            <div class="left-angle">
                                <i class="corner"></i>
                            </div>
                            <h3>${jobCategory.job}<div class="icon"><span class="arow-r"><i></i></span></div></h3>
                            <div class="item-list">
                            <c:if test="${status.index==0}">
                                <a href="/jobs/?keywords=外贸业务员">外贸业务员</a>
                                <a href="/jobs/?keywords=外贸助理">外贸助理</a>
                                <a href="/jobs/?keywords=外贸经理">外贸经理</a>
                                <a href="/jobs/?keywords=外贸跟单">外贸跟单</a>
                            </c:if>
                            <c:if test="${status.index==1}">   
                                <a href="/jobs/?keywords=亚马逊业务员">亚马逊业务员</a>
                                <a href="/jobs/?keywords=电商专员">电商专员</a>
                                <a href="/jobs/?keywords=eBay客服">eBay客服</a>
                                <a href="/jobs/?keywords=电商主管">电商主管</a>
                            </c:if>
                            <c:if test="${status.index==2}">   
                                <a href="/jobs/?keywords=西班牙外贸业务员">西班牙外贸业务员</a>
                                <a href="/jobs/?keywords=俄语外贸主管">俄语外贸主管</a>
                            </c:if>
                            <c:if test="${status.index==3}">   
                                <a href="/jobs/?keywords=Google推广专员">Google推广专员</a>
                                <a href="/jobs/?keywords=外贸网站SEO专员">外贸网站SEO专员</a>
                            </c:if>
                            <c:if test="${status.index==4}">   
                                <a href="/jobs/?keywords=物流专员">物流专员</a>
                                <a href="/jobs/?keywords=报关员">报关员</a>
                                <a href="/jobs/?keywords=信用证专员">信用证专员</a>
                                <a href="/jobs/?keywords=QC">QC</a>
                            </c:if>
                            <c:if test="${status.index==5}">   
                                <a href="/jobs/?keywords=采购专员">采购专员</a>
                                <a href="/jobs/?keywords=退税会计">退税会计</a>
                                <a href="/jobs/?keywords=HR">HR</a>
                                <a href="/jobs/?keywords=行政">行政</a>
                                <a href="/jobs/?keywords=出纳">出纳</a>
                                <a href="/jobs/?keywords=翻译">翻译</a>
                            </c:if>
                            </div>
                            <div class="item-list-detailed" <c:if test="${status.last}">style="bottom: 0; top: inherit;"</c:if>>
                                <div class="wrap-mask">
                                    <c:forEach items="${jobCategory.children}" var="children">
                                        <dl>
                                            <c:url value="/jobs/" var="Link"> 
                                                <c:param name="keywords" value="${children.job}"/> 
                                            </c:url>
                                            <dt><a href="${Link}">${children.job}</a></dt>
                                            <c:forEach items="${children.children}" var="child">
                                                <c:url value="/jobs/" var="Link"> 
                                                    <c:param name="keywords" value="${child.job}"/> 
                                                </c:url>
                                                <dd>|<a href="<c:url value="${Link}"/>">${child.job}</a></dd>
                                            </c:forEach>
                                        </dl>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                <div class="right-cont">
                    <div id="img-box" class="roll-banner swiper-container">
                        <div class="swiper-wrapper">            
                            <div class="item swiper-slide">
                                <a href="/register/nav">
                                    <img src="//cdn.tradehelp.cn/banner/banner.jpg"/>
                                </a>
                            </div>
                        </div>
                        <div class="prev direction-icon"></div>
                        <div class="next direction-icon"></div>
                        <div class="swiper-pagination swiper-pagination-bullets" id="swiper-pagination1"></div>
                    </div>
                    <div class="job-list">
                        <div class="job-tool">
                            <dl id="type-tab">
                                <dd class="on"><a href="javascript:void(0)">热门</a></dd>
                                <dd><a href="javascript:void(0)">最新</a></dd>
                            </dl>
                            <div class="industry-sign" id="change-industry">
                                <div class="text"><span id="industry_name">不限行业</span><span class="arow-b"><i></i></span></div>
                                <div id="industry-list" class="industry-list">
                                    <div class="industry-lv1">
                                        <c:forEach items="${industries}" var="industry">
                                        <div data-id="${industry.id}" class="item">${industry.industry}</div>
                                        </c:forEach>
                                        <div class="item more">更多</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="job-list-item">
                            <ul id="popularJob" style="display:block;">
                                <c:if test="${popularJob.size()>0}">
                                <c:forEach items="${popularJob}" var="job">
                                    <li>
                                        <div class="job-info">
                                            <h3><a href="/jobs/${job.id}.html">${job.name} [${job.city}]</a></h3>
                                            <p><span class="pay">
                                            <jsp:include page="/WEB-INF/public/public-salary.jsp" flush="true">
                                                <jsp:param name="basic" value="${job.salaryBasic}"/>
                                                <jsp:param name="max" value="${job.salaryMin}"/>
                                                <jsp:param name="min" value="${job.salaryMax}"/>
                                            </jsp:include>
                                            </span>经验${job.experience.experience}/${job.education.education}</p>
                                        </div>
                                        <div class="company-info">
                                            <div class="pic">
                                                <a href="/companies/${job.company.id}.html">
                                                    <img src="${job.company.logoUrl}" width="55" height="55">
                                                </a>
                                            </div>
                                            <div class="text">
                                                <p class="name"><a href="/companies/${job.company.id}.html">${(empty job.company.abbreviation)?job.company.name:job.company.abbreviation}</a></p>
                                                <p class="special">${job.company.industry}</p>
                                            </div>
                                        </div>
                                        <div class="bottom-bar clear">
                                            <dl>
                                                <c:forEach items="${job.tagList}" var="tag" varStatus="status">
                                                    <c:if test="${status.index < 4}">
                                                        <dd>${tag}</dd>
                                                    </c:if>
                                                </c:forEach>
                                            </dl>
                                            <div title="${job.company.brief}" class="slogan">${job.company.brief}</div>
                                        </div>
                                    </li>
                                </c:forEach>
                                </c:if>
                                <c:if test="${popularJob.size()<=0}">
                                    <li style="border: none;">
                                    <jsp:include page="/WEB-INF/public/public-unusual-state.jsp" flush="true">
                                        <jsp:param name="top" value="100px"/>
                                        <jsp:param name="msg" value="没有找到相关职位"/>
                                    </jsp:include>
                                    </li>
                                </c:if>
                            </ul>
                            <ul id="newJob">
                                <c:if test="${newJob.size()>0}">
                                <c:forEach items="${newJob}" var="job">
                                    <li>
                                        <div class="job-info">
                                            <h3><a href="/jobs/${job.id}.html">${job.name} [${job.city}]</a></h3>
                                            <p><span class="pay">
                                                <jsp:include page="/WEB-INF/public/public-salary.jsp" flush="true">
                                                    <jsp:param name="basic" value="${job.salaryBasic}"/>
                                                    <jsp:param name="max" value="${job.salaryMin}"/>
                                                    <jsp:param name="min" value="${job.salaryMax}"/>
                                                </jsp:include></span>经验${job.experience.experience}/${job.education.education}</p>
                                        </div>
                                        <div class="company-info">
                                            <div class="pic">
                                                <a href="/companies/${job.company.id}.html">
                                                    <img src="${job.company.logoUrl}" width="55" height="55">
                                                </a>
                                            </div>
                                            <div class="text">
                                                <p class="name"><a href="/companies/${job.company.id}.html">${(empty job.company.abbreviation)?job.company.name:job.company.abbreviation}</a></p>
                                                <p class="special">${job.company.industry}</p>
                                            </div>
                                        </div>
                                        <div class="bottom-bar clear">
                                            <dl>
                                                <c:forEach items="${job.tagList}" var="tag" varStatus="status">
                                                    <c:if test="${status.index < 4}">
                                                        <dd>${tag}</dd>
                                                    </c:if>
                                                </c:forEach>
                                            </dl>
                                            <div title="${job.company.brief}" class="slogan">${job.company.brief}</div>
                                        </div>
                                    </li>
                                </c:forEach>
                                </c:if>
                                <c:if test="${newJob.size()<=0}">
                                    <li style="border: none;">
                                    <jsp:include page="/WEB-INF/public/public-unusual-state.jsp" flush="true">
                                        <jsp:param name="top" value="100px"/>
                                        <jsp:param name="msg" value="没有找到相关职位"/>
                                    </jsp:include>
                                    </li>
                                </c:if>
                            </ul>
                            <div class="more"><a href="/jobs/">点击查看更多 <img style="display: inline-block; vertical-align: middle;" width="14" src="../../img/arow.png"/> </a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <shiro:guest>
        <div class="foot-tool-bar-wrap">
        <div class="foot-tool-bar">
            <div class="wrap">
                <em>
                    <img width="90" height="99" src="../../img/login_officer_bg_8c1de01.png"/>
                </em>
                <p class="text">
                    <span class="text-ele"><span class="come-lagou">在外贸帮手网，发现新的职业机会</span></span>
                    <span class="count-wrapper text-ele">
                        <span class="text-ele company"><span class="companycount">${companiesCount}</span>公司</span>
                        <span class="text-ele line">|</span>
                        <span class="text-ele"><span class="positioncount">${candidateCount}</span>求职者</span>
                    </span>
        
                </p>
                <div class="right">
                    <a class="button bar_login passport_login_pop" href="/login">登录</a>
                    <a href="/register/nav" class="bar_register button" >注册</a>
                </div>
            </div>
        </div>
        </div>
        </shiro:guest>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <link rel="stylesheet" href="${url.cdn}/static/plugins/swiper/idangerous.swiper.css" />
        <script src="${url.cdn}/static/plugins/swiper/idangerous.swiper.min.js"></script>
        <script>
        function InitIndex(){
            if($(".foot-tool-bar-wrap").length>0){
                var t1=$(".foot-tool-bar-wrap").offset().top;
                var t2=$(window).scrollTop();
                var windheight=$(window).height();
                if(t1-t2-windheight>=0){
                    $(".foot-tool-bar").addClass("fixed");
                }else{
                    $(".foot-tool-bar").removeClass("fixed");
                } 
            }
        };
        InitIndex();
        $(window).scroll(function(){
            InitIndex();
        });
        </script>
        <style>
        .swiper-pagination{position: absolute; left: 0; right: 0; bottom:15px; text-align: center;}
        .swiper-pagination-switch{background: #fff; cursor: pointer; width: 8px; height: 8px; display:inline-block; border-radius:100%; margin: 0px 7px; opacity: 0.5; filter:alpha(opacity=50);}
        .swiper-pagination-switch.swiper-active-switch{opacity:1; filter:alpha(opacity=100);}
        .footer{margin-top: 0px;}        
        </style>
    </body>
</html>