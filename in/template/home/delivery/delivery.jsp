<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  User: xianghuawei
  Date: 2017/8/9
  Time: 17:12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>我的投递 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
        <style>
        .nav-tab-thme li{width: 16.66%;}
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/public-home-head.jsp"/>
        <div class="wrap main">
            <div class="left-cont">
                <div class="resume-cont" style="padding: 0px 20px;">
                    <div class="resume-bar"></div>
                    <div class="up-avatar-box">
                        <div class="avatar">
                            <img src="${resume.avatar}"/>
                        </div>
                        <div class="ring-left">
                            <i class="ring"></i>
                        </div>
                        <div class="ring-right">
                            <i class="ring"></i>
                        </div>
                    </div>
                    <p class="name">${resume.name}</p>
                    <div class="slogan">${resume.selfIntroduction}</div>
                    <p class="min-info education"><i class="icon icon-avatar" style="font-size: 14px;"></i>${resume.education.education} / ${resume.experience.experience}</p>
                    <p class="min-info">
                    <i class="icon icon-icon_mobile" style="font-size: 16px;"></i>${resume.phone}
                    <span style="padding-left: 27px;"></span>
                    <span class="email"><i class="icon icon-icon_email"></i>${resume.email}</span></p>
                    <p class="blank-2"></p>
                    <div style="margin: 0;" class="split-line"></div>
                    <div class="blank-2"></div>
                    <p class="title-modular">投递记录</p>
                    <ul class="nav-tab-thme">
                        <li ${deliveryStatus=='ALL'?'class="on"':''}><a href="/resume/delivery/list">全部</a></li>
                        <li ${deliveryStatus=='SUCCESS'?'class="on"':''}><a href="?deliveryStatus=SUCCESS">投递成功</a></li>
                        <li ${deliveryStatus=='READ'?'class="on"':''}><a href="?deliveryStatus=READ">被查看</a></li>
                        <li ${deliveryStatus=='COMMUNICATED'?'class="on"':''}><a href="?deliveryStatus=COMMUNICATED">待沟通</a></li>
                        <li ${deliveryStatus=='INTERVIEW'?'class="on"':''}><a href="?deliveryStatus=INTERVIEW">邀请面试</a></li>
                        <li ${deliveryStatus=='INAPPROPRIATE'?'class="on"':''}><a href="?deliveryStatus=INAPPROPRIATE">不合适</a></li>
                    </ul>
                    <c:if test="${total>0}">
                    <div class="res-list">
                        <ul id="res-list">
                            <c:forEach items="${deliveries}" var="delivery">
                                <li data-id = "${delivery.id}">
                                    <div class="text-box">
                                        <h3><a target="_blank" href="/companies/${delivery.company.id}.html">${delivery.company.name}</a></h3>
                                        <p class="job"><a href="/jobs/${delivery.job.id}" >${delivery.job.name}</a></p>
                                        <p class="other-info">${delivery.job.city}<span class="red">${delivery.job.salaryMin}k~${delivery.job.salaryMax}k</span></p>
                                        <p class="state-info">
                                            <span class="time">
                                                <fn:formatDate value="${delivery.createDate}" pattern="yyyy-MM-dd HH:mm"/>
                                            </span>
                                            <span style="width: 1px; height: 15px; background: #ccc; display: inline-block; vertical-align: middle; margin: -3px 5px 0px;"></span>
                                            <span class="state">
                                                <c:choose>
                                                    <c:when test="${delivery.interviewStatus.name() == 'NEW_RESUME'}">投递成功</c:when>
                                                    <c:otherwise>${delivery.interviewStatus.getValue()}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </p>    
                                        <div class="drop-btn">
                                            <span class="arow-b">
                                                <i></i>
                                            </span>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div style="padding-top: 50px;" id="pagination"></div>
                    </c:if>
                    <c:if test="${total<=0}">
                    <jsp:include page="/WEB-INF/public/public-unusual-state.jsp" flush="true">
                        <jsp:param name="msg" value="当前没有任何投递记录"/>
                        <jsp:param name="top" value="100px"/>
                    </jsp:include>
                    </c:if>
                </div>
            </div>
            <div class="right-cont info-brief hollow">
                <ul class="resume-tool-nav">
                    <li>
                        <a class="on" href="/resume/delivery/list">我的投递<i class="icon icon-goto"></i></a>
                    </li>
                    <li>
                        <a href="/resume/">我的简历<i class="icon icon-resume"></i></a>
                    </li>
                </ul>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <jsp:include page="/WEB-INF/public/public-page.jsp" flush="true">
            <jsp:param name="total" value="${total}"/>
            <jsp:param name="size" value="15"/>
        </jsp:include>
    </body>
</html>