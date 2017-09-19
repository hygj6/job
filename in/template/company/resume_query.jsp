<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>人才搜索 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="company-cont wrap-1200">
            <div class="middle-cont-topic clear">
                <div class="search-box" style="width: 750px;">
                    <form id="company-resume">
                       <input value="${q}" name="q" style="width:728px;" placeholder="搜索你感兴趣的人才关键词" type="text" class="input-text"/>
                       <button type="submit">搜索</button>
                    </form>
                </div>
                <p class="tip-min">还能主动沟通${permission.remainInviteCount}人（今天）<!--<a href="#">升级人数+</a>--></p>
            </div>
            <div class="blank-2"></div>
            <div class="left-cont">
                <div class="main-title none-border">
                                                人才推荐
                <c:if test="${jobs.size()>0}">
                    <div class="tool">
                                                            按职位来看
                       <div class="inline-block">
                       <select class="select-custom" id="jobCategory">
                            <option value="0">全部</option>
                            <c:forEach items="${jobs}" var="job">
                                <option value="${job.id}" <c:if test="${job.id == job_id}">selected</c:if> >${job.name}</option>
                            </c:forEach>${category.job}
                       </select> 
                       </div>
                    </div>    
                </c:if>
                </div>
                <div class="personnel-list">
                    <ul>
                        <c:forEach items="${resumes}" var="resume">
                            <li>
                                <div class="top-bar">
                                    <p class="base">${resume.expectCity.name}<i></i>${resume.experience.experience}<i></i>${resume.education.education}</p>
                                    <c:if test="${resume.online}">
                                        <p class="state on"><i class="point"></i>在线</p>
                                    </c:if>
                                    <c:if test="${!resume.online}">
                                        <p class="state"><i class="point"></i>离线</p>
                                    </c:if>
                                </div>
                                <div class="cont">
                                    <div class="avatar-box">
                                        <div class="avatar">
                                            <img width="58" height="58" src="${resume.avatar}"/>
                                        </div>
                                        <p class="name">${resume.name}</p>
                                    </div>
                                    <div class="base-info">
                                        <c:forEach items="${resume.experiences}" var="experience" varStatus="status">
                                            <c:if test="${status.last}">
                                                <p>曾任${experience.position} · ${experience.company}</p>
                                                <p>期望工作：${experience.position}</p>
                                            </c:if>
                                        </c:forEach>
                                        <p class="tip">${resume.selfIntroduction}</p>
                                    </div>
                                    <a data-id = "${resume.id}" class="btn create-conversation" href="javascript:void(0)">和TA聊聊</a>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <c:if test="${total==0}">
                        <jsp:include page="/WEB-INF/public/public-unusual-state.jsp" flush="true">
                            <jsp:param name="msg" value="没有找到相关人才"/>
                            <jsp:param name="top" value="100px"/>
                        </jsp:include>
                    </c:if>
                </div>
                <c:if test="${total>0}">
                    <div style="padding-top: 50px;" id="pagination"></div>
                </c:if>
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
        <jsp:include page="/WEB-INF/public/public-page.jsp" flush="true">
            <jsp:param name="total" value="${total}"/>
            <jsp:param name="size" value="10"/>
        </jsp:include>
        <script>
        var CurrentJobId=${job_id};
        </script>
    </body>
</html>