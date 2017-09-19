<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  User: caobug
  Date: 2017/7/31
  Time: 11:32
--%>
<%@include file="/WEB-INF/public/common_macro.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${resume.name}的简历</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body>
        <div class="wrap main">
            <div class="left-cont" style="float: none; margin: 0px auto;">
                <div class="resume-cont preview" style="padding: 0px 20px;">
                    <div class="resume-bar"></div>
                    <div class="up-avatar-box">
                        <div class="avatar">
                            <img width="120" height="120" src="${resume.avatar}" id="picview"/>
                        </div>
                        <div class="ring-left">
                            <i class="ring"></i>
                        </div>
                        <div class="ring-right">
                            <i class="ring"></i>
                        </div>
                    </div>
                    <div id="res-base-info">
                        <p class="name">${resume.name}</p>
                        <div class="slogan"><span class="self_introduction">${resume.selfIntroduction}</span></div>
                        <p class="min-info"><i class="icon icon-avatar" style="font-size: 14px;"></i><span class="education">${resume.education.education} / ${resume.experience.experience}</span></p>
                        <p class="min-info">
                        <c:choose>
                            <c:when test="${isDelivery}"><i class="icon icon-icon_mobile" style="font-size: 16px;"></i>${resume.phone}</c:when>
                            <c:otherwise><i class="icon icon-icon_mobile" style="font-size: 16px;"></i>${fn:substring(resume.phone, 0, 4)}****${fn:substring(resume.phone,7,11)}</c:otherwise>
                        </c:choose>
                        <span style="padding-left: 27px;"></span>
                        <i class="icon icon-icon_email"></i><span class="email">${resume.email}</span></p>
                    </div>
                    <p class="blank-2"></p>
                    <div class="experience">
                        <p class="title anchor">工作经历</p>
                        <div id="experience-list" class="experience-list">
                            <c:forEach items="${resume.experiences}" var="experience">
                            <dl class="item" data-time="<fmt:formatDate value="${experience.hireDate}" pattern="yyyyMM"/>">
                                <dt>
                                    <input type="hidden" class="id" value="${experience.id}"/>
                                    <div class="company-mod"><p class="company company-name">${experience.company}</p><span class="time">
                                    <span class="hire_date"><fmt:formatDate value="${experience.hireDate}" pattern="yyyy-MM"/></span>
                                     ~ 
                                    <span class="leaving_date"><fmt:formatDate value="${experience.leavingDate}" pattern="yyyy-MM"/></span>
                                    </span></div>
                                    <p class="job position">${experience.position}</p>
                                </dt>
                                <dd>
                                    <p class="job_detail">${experience.jobDetail}</p>
                                </dd>
                            </dl>
                            </c:forEach>
                        </div>
                        <p class="title anchor">教育经历</p>
                        <div id="educations-list" class="experience-list">
                            <c:forEach items="${resume.educations}" var="education">
                            <dl data-time="${education.graduationYear}" class="item">
                                <dt>
                                    <input type="hidden" class="id" value="${education.id}"/>
                                    <div class="company-mod"><p class="company-name school">${education.school}</p><span class="time"><span class="graduation_year">${education.graduationYear}</span>毕业</span></div>
                                    <p class="job"><span class="major">${education.major}</span>/<span class="type">${education.type.education}</span><input type="hidden" name="type" value="${education.type.id}"></p>
                                </dt>
                            </dl>
                            </c:forEach>
                        </div>
                        <p style="text-align: center; color:#999; font-size: 14px;">-${resume.workStatus.description}-</p>
                        <div class="clear" style="height: 180px;"></div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
    </body>
</html>