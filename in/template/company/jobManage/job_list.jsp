<%@ page import="java.util.Date" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="now" class="java.util.Date" />
<%--
  User: xianghuawei
  Date: 2017/7/3
  Time: 10:29
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>职位管理- 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    <body>
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="company-cont wrap-1200">
            <div class="middle-cont">
                <div class="search-tool">
                    <div style="width: 710px;" class="search-box">
                        <form id="search-job">
                           <input value="${keywords}" style="width: 670px;" placeholder="职位名称 / 职位描述 / 城市 等" type="text" name="keywork" class="input-text"/>
                           <button type="submit">搜索</button>
                        </form>
                    </div>
                    <div class="job-state-info">
                        <p>已发布职位<span>${permission.product.jobCount - permission.remainJobCount}/${permission.product.jobCount}</span>个</p>
                        <p>已在线职位<span>${permission.product.jobOnlineCount - permission.remainJobOnlineCount}/${permission.product.jobOnlineCount}</span>个</p>
                    </div>
                    ${keywords}
                    <div class="blank-2">
                    </div>
                </div>
                <div class="nav-tab">
                    <ul>
                        <li <c:if test="${jobStatus == 'ONLINE'}">class="on"</c:if>><a href="?jobStatus=ONLINE<c:if test="${not empty keywords}">&keywords=${keywords}</c:if>">在线（${total_onilne}）</a></li>
                        <li <c:if test="${jobStatus == 'OFFLINE'}">class="on"</c:if>><a href="?jobStatus=OFFLINE<c:if test="${not empty keywords}">&keywords=${keywords}</c:if>">下线（${total_offilne}）</a></li>
                    </ul>
                    <div class="tool-bar">
                        <a class="btn on <c:if test='${permission.remainJobCount == 0}'>unauthorized</c:if>" <c:if test="${permission.remainJobCount > 0}">target="_blank" href="/companies/job/add"</c:if> ><i style="font-size: 12px;" class="icon icon-icon_add"></i>发布新职位</a>
                        <a class="btn" id="refresh-all-job" href="javascript:void(0)"><i class="icon icon-refresh"></i>刷新所有职位</a>
                    </div>
                </div>
                <div class="blank-2"></div>
                <div class="job-list">
                    <ul>
                        <c:forEach items="${jobList}" var="job">
                            <li data-id = "${job.id}">
                                <div class="base-info">
                                    <p class="job-name"><a href="/jobs/${job.id}.html">${job.name}</a></p>
                                    <p class="other-info">
                                        <span class="item">${job.department}</span>
                                        <span class="item"><jsp:include page="/WEB-INF/public/public-salary.jsp" flush="true">
                                            <jsp:param name="basic" value="${job.salaryBasic}"/>
                                            <jsp:param name="max" value="${job.salaryMin}"/>
                                            <jsp:param name="min" value="${job.salaryMax}"/>
                                        </jsp:include></span>
                                        <span class="item">${job.experience.experience}</span>
                                        <span class="item">${job.education.education}</span>
                                        <span class="item">${job.city}</span>
                                    </p>
                                </div>
                                <div class="state-info">
                                    <dl>
                                        <dd>
                                            <p class="nub">${job.notReadCount}</p>
                                            <p class="label">未阅读</p>
                                        </dd>
                                        <dd>
                                            <p class="nub">${job.candidateCount}</p>
                                            <p class="label">面试</p>
                                        </dd>
                                        <dd>
                                            <p class="nub">${job.interviewCount}</p>
                                            <p class="label">候选人</p>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="bottom-bar">
                                    <c:set var="createDate" value="${empty job.refreshDate?job.createDate:job.refreshDate}" scope="request"/>
                                    <p class="time">发布时间：<fmt:formatDate value="${createDate}" pattern="yyyy-MM-dd HH:mm"/></p>
                                    <div class="tool-bar">
                                        <dl>
                                            <dd class="no-line">
                                                <%
                                                  Date date = (Date) request.getAttribute("createDate");
                                                    long time = date.getTime();
                                                    long dayTime = time - (time + 8 * 3600) % 86400;
                                                    pageContext.setAttribute("dayTime", dayTime);
                                                %>
                                                <c:if test="${jobStatus == 'ONLINE'}">
                                                <a class="refresh-job <c:if test="${((now.time - dayTime)/1000/86400) >= permission.product.jobRefreshInterval}">enable</c:if>" href="javascript:void(0)">刷新职位</a>
                                                </c:if>
                                            </dd>
                                            <dd <c:if test="${jobStatus == 'OFFLINE'}">class="no-line"</c:if>>
                                                <a href="/companies/job/${job.id}/edit">编辑职位</a>
                                            </dd>
                                            <dd>
                                                <a href="#">更多<span class="arow-b"><i></i></span></a>
                                                <div class="drop-down">
                                                <span class="arow-t">
                                                    <i></i>
                                                </span>
                                                    <div class="item">
                                                        <a target="_blank" href="/jobs/${job.id}.html">查看职位</a>
                                                    </div>
                                                    <div class="item job-state">
                                                        <c:if test="${jobStatus == 'ONLINE'}">
                                                            <a data-type ="OFFLINE" href="javascript:void(0)">下线职位</a>
                                                        </c:if>
                                                        <c:if test="${jobStatus == 'OFFLINE'}">
                                                            <a data-type="ONLINE" href="javascript:void(0)">上线职位</a>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </dd>
                                        </dl>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <c:if test="${(jobStatus == 'ONLINE' && total_onilne==0)||(jobStatus == 'OFFLINE' && total_offilne==0)}">
                    <jsp:include page="/WEB-INF/public/public-unusual-state.jsp" flush="true">
                        <jsp:param name="msg" value="当前没有职位，如果没有发布职位，您可要先发布职位"/>
                        <jsp:param name="btnLabel" value="发布职位"/>
                        <jsp:param name="btnUrl" value="/companies/job/add"/>
                        <jsp:param name="top" value="100px"/>
                    </jsp:include>
                    </c:if>
                    <c:if test="${(jobStatus == 'ONLINE' && total_onilne>0)||(jobStatus == 'OFFLINE' && total_offilne>0)}">
                    <div id="pagination"></div>
                    </c:if>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <c:if test="${jobStatus == 'ONLINE' && total_onilne>0}">
            <jsp:include page="/WEB-INF/public/public-page.jsp" flush="true">
                <jsp:param name="total" value="${total_onilne}"/>
                <jsp:param name="size" value="15"/>
            </jsp:include>
        </c:if>
        <c:if test="${jobStatus == 'OFFLINE' && total_offilne>0}">
            <jsp:include page="/WEB-INF/public/public-page.jsp" flush="true">
                <jsp:param name="total" value="${total_offilne}"/>
                <jsp:param name="size" value="15"/>
            </jsp:include>
        </c:if>
    </body>
</html>