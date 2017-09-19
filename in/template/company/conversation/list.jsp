<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>及时沟通 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <style>
    <c:if test="${conversations.size()<= 0}">
    .chat-cont{padding-left: 0 !important;}
    </c:if>
    </style>
    <body>
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="company-cont wrap-1200">
            <div class="middle-cont chat-cont">
                <c:if test="${conversations.size()> 0}">
                    <div id="conversation-list" class="seeker-tab">
                        <c:forEach items="${conversations}" var="conversation">
                            <div class="item" data-id="${conversation.id}" data-time="<fn:formatDate value="${conversation.latest.sendDateTime}" pattern="yyyy/MM/dd HH:mm"/>">
                                <i class="state"></i>
                                <div class="avatar">
                                    <img width="50" height="50" src="${conversation.candidate.avatar}"/>
                                </div>
                                <div class="text">
                                    <p class="name">${conversation.candidate.name} · ${conversation.jobName} </p>
                                    <p><fn:formatDate value="${conversation.latest.sendDateTime}" pattern="yyyy/MM/dd HH:mm"/></p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="chat-text">
                        <div class="chat-top-bar">
                            <div class="l-box">
                                <i class="icon icon-msg"></i>沟通中的职位
                                <div class="inline-block">
                                <select class="select-custom" id="currentJob">
                                    <option value="">无岗位</option>
                                    <c:forEach items="${jobs}" var="job">
                                    <option value="${job.id}">${job.name}</option>
                                    </c:forEach>
                                </select>
                                </div>
                            </div>
                            <h3>
                                <span id="candidate_name"></span>
                                <span id="delivered"></span>
                            </h3>
                            <div class="r-box">
                                <a id="inviting-btn" href="javascript:void(0)" style="margin-right: 10px; display: none;">邀请投递</a>
                                <a target="_blank" id="personnel-info"><i class="icon icon-search"></i>查看人才信息</a>
                            </div>
                        </div>
                        <div class="cont">
                            <dl class="chat-list" id="chat-box">
                                <dt class="time">
                                    <p id="last_time">16:20</p>
                                    <p>正在沟通的职业：<span id="job_name">外贸业务员</span></p>
                                </dt>
                            </dl>
                        </div>
                        <div class="chat-input-box">
                            <form id="send-msg">
                                <textarea name="content" placeholder="按下回车可直接发送消息"></textarea>
                                <button type="submit" class="btn">发送</button>
                            </form>
                        </div>
                    </div>
                </c:if>
                <c:if test="${conversations.size()<= 0}">
                    <jsp:include page="/WEB-INF/public/public-unusual-state.jsp" flush="true">
                        <jsp:param name="msg" value="当前没有任何会话"/>
                        <jsp:param name="top" value="150px"/>
                    </jsp:include>
                </c:if>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <jsp:include page="/WEB-INF/public/public-resume-delivery.jsp"/>
        <script src="${url.cdn}/static/plugins/sockjs/sockjs-1.1.0.js" type="text/javascript"></script>
        <script src="${url.cdn}/static/plugins/sockjs/stomp.js" type="text/javascript"></script>
        <script>
        var userId = '<shiro:principal property="id"/>';
        var currentId=${id};
        </script>
    </body>
    <script>
    Chat({
        ChatType:"company"
    })
    </script>
</html>