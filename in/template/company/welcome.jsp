<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>管理后台 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="company-cont wrap-1200">
            <div class="left-cont">
                <div class="search-box" style="width: 711px;">
                    <form id="company-resume">
                       <input name="q" style="width: 675px;" placeholder="搜索你感兴趣的人才关键词" type="text" class="input-text"/>
                       <button type="submit">搜索</button>
                    </form>
                </div>
                <fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="HH" var="hh"/>
                <h3 class="greet">
                    <c:choose>
                        <c:when test="${hh<6}">凌晨好，</c:when>
                        <c:when test="${6<=hh and hh<12}">上午好，</c:when>
                        <c:when test="${hh==12}">中午好，</c:when>
                        <c:when test="${12<hh and hh<18}">下午好，</c:when>
                        <c:otherwise>晚上好，</c:otherwise>
                    </c:choose>
                <shiro:principal property="name"/>！</h3>
                <p class="greet-min">今天是 <fmt:formatDate value="${now}" pattern="MM月dd日 E"/> ：时间和注意力是你最宝贵的财富！~</p>
                <div class="result-info">
                    <dl>
                        <dd>
                            <p class="nub">${newResumeCount}</p>
                            <p class="item">新简历</p>
                        </dd>
                        <dd>
                            <p class="nub">${toBeCommunicatedCount}</p>
                            <p class="item">待沟通</p>
                        </dd>
                        <dd>
                            <p class="nub">${scheduleCount}</p>
                            <p class="item">今日面试</p>
                        </dd>
                        <dd>
                            <p class="nub">${conversationCount}</p>
                            <p class="item">即时沟通</p>
                        </dd>
                        <dd>
                            <p class="nub">${jobCount}</p>
                            <p class="item">在招职位</p>
                        </dd>
                    </dl>
                </div>
                <div class="table-title">
                    <span>面试时间</span>
                    <ul id="schedule-tab" class="tab">
                        <li data-id = "1"><a href="javascript:void(0)">过去</a></li>
                        <li data-id = "2" class="on"><a href="javascript:void(0)">今天</a></li>
                        <li data-id = "3"><a href="javascript:void(0)">以后</a></li>
                    </ul>
                </div>
                <table id="schedule-table" class="table">
                    <thead>
                    <tr>
                        <th>面试时间</th>
                        <th>求职者</th>
                        <th>电话</th>
                        <th>岗位</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${schedules}" var="schedule">
                        <tr>
                            <td><fmt:formatDate value="${schedule.scheduleDate}" pattern="yyyy/MM/dd E HH:mm"/></td>
                            <td><span class="sign">${schedule.name}</span></td>
                            <td>${schedule.mobile}</td>
                            <td>${schedule.category}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div id="default-box">
                <c:if test="${schedules.size()==0}"> 
                    <div class="unusual-box" style="padding-bottom: 100px; padding-top:100px;">
                        <div class="state-icon"></div>
                        <p>过去无面试安排</p>
                    </div>
                </c:if>
                </div>
            </div>
            <div class="right-menu">
                <h3 class="top-title">帮课网+特权<span class="btn">
                    <c:set var="product" value="${permission.product}"/>
                    <c:choose>
                        <c:when test="${product.id == 1}">
                            未激活
                        </c:when>
                        <c:otherwise>
                            ${product.name}
                        </c:otherwise>
                    </c:choose>
                </span><!--<a href="#">详情</a>--></h3>
                <ul class="list">
                    <li><i>1</i>在线/发布职位<span class="sign">上限为
                    <c:choose>
                        <c:when test="${product.id == 1}">
                            100
                        </c:when>
                        <c:otherwise>
                            ${product.jobCount}
                        </c:otherwise>
                    </c:choose>
                    </span></li>
                    <li><i>2</i>每天<span class="sign">
                    <c:choose>
                        <c:when test="${product.id == 1}">
                            300次
                        </c:when>
                        <c:otherwise>
                            ${product.jobInviteCount}次
                        </c:otherwise>
                    </c:choose>
                    </span>主动沟通次数</li>
                    <li><i>3</i>提升职位曝光，猛增投递量</li>
                    <li><i>4</i>职位每日刷新，保持新鲜度</li>
                    <li><i>5</i>全库海量人才任你挑</li>
                </ul>
                <div class="pic-modular"><img src="//cdn.tradehelp.cn/banner/min-banner.jpg"/></div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
    </body>
</html>