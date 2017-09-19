<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%--
  User: caobug
  Date: 2017/7/31
  Time: 11:17
--%>
<%@include file="/WEB-INF/public/common_macro.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>完善工作经验 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <style>
    .total-erro{margin-bottom: -15px;}
    .btn-group{position: relative; z-index: 10;}
    </style>
    <body>
        <div style="height:78px;"></div>
        <div class="wrap-700">
            
            <div class="bj-paper">
            <div class="bj-paper">
            <div class="bj-paper">
                
            <div class="perfect-head">
                <p class="text">完善工作信息</p>
                <p class="index"><span>3</span>/3</p>
            </div>
            <div id="experience" class="perfect-box">
                <a class="skip" href="javascript:void(0)">跳过</a>
                <div class="circle">
                    <img draggable="false" width="44" src="../../../../img/circle.png"/>
                </div>
                <c:forEach items="${experiences}" var="experience" varStatus="status">
                <form style="margin-left: -60px; width: 450px;">
                    <input type="hidden" value="<c:out value='${experience.id}'/>" name="id"/>
                    <dl class="group-input">
                        <dt><span class="red">*</span>公司:</dt>
                        <dd>
                            <input autocomplete="off" value="<c:out value='${experience.company}'/>" nullmsg="请填写您的所在公司名称" name="company" placeholder="请填写您的所在公司名称" class="input-text bind" type="text"/>
                        </dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>职务:</dt>
                        <dd>
                            <input autocomplete="off" value="<c:out value='${experience.position}'/>" nullmsg="请输入您的所在公司职位" name="position" placeholder="请输入您的所在公司职位" class="input-text bind" type="text"/>
                        </dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>时间:</dt>
                        <dd style="width: 146px;">
                            <input readonly="readonly" value="<fmt:formatDate value="${experience.hireDate}" pattern="yyyy-MM"/>" style="width: 126px;" name="hire_date" placeholder="入职时间" class="input-text bind time-drop start-time" type="text"/>
                        </dd>
                        <dd style="width: 146px; margin-left: 28px;">
                            <input readonly="readonly" value="<fmt:formatDate value="${experience.leavingDate}" pattern="yyyy-MM"/>" style="width: 126px;" name="leaving_date" placeholder="离职时间" class="input-text bind time-drop end-time" type="text"/>
                        </dd>
                        <dd style="padding-left: 120px;"><input value="<fmt:formatDate value="${experience.hireDate}" pattern="yyyy-MM"/><fmt:formatDate value="${experience.leavingDate}" pattern="yyyy-MM"/>" nullmsg="请选择完整时间段" type="hidden" class="bind hide-val"/></dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>工作内容:</dt>
                        <dd>
                            <div class="textarea-wrap">
                                <textarea name="job_detail" nullmsg="请大致介绍您的工作内容" placeholder="请大致介绍您的工作内容" style="height: 80px;" class="input-text bind">${fn:replace(experience.jobDetail, '<br>', newLineChar)}</textarea>
                            </div>
                        </dd>
                    </dl>
                    <c:if test="${status.index!=0}">
                        <p class="del-entry">
                            <a class="delete" href="javascript:void(0)">删除本条</a>
                        </p> 
                    </c:if>
                    <div class="line"></div>
                </form>
                </c:forEach>
                <div id="temp" style="display:none;">
                <form style="margin-left: -60px; width: 450px;">
                    <input type="hidden" value="" name="id"/>
                    <dl class="group-input">
                        <dt><span class="red">*</span>公司:</dt>
                        <dd>
                            <input value="" nullmsg="请填写您的所在公司名称" name="company" placeholder="请填写您的所在公司名称" class="input-text bind" type="text"/>
                        </dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>职务:</dt>
                        <dd>
                            <input value="" nullmsg="请输入您的所在公司职位" name="position" placeholder="请输入您的所在公司职位" class="input-text bind" type="text"/>
                        </dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>时间:</dt>
                        <dd style="width: 146px;">
                            <input readonly="readonly" value="" style="width: 126px;" name="hire_date" readonly="readonly" placeholder="入职时间" class="input-text bind time-drop start-time" type="text"/>
                        </dd>
                        <dd style="width: 146px; margin-left: 28px;">
                            <input readonly="readonly" value="" style="width: 126px;" name="leaving_date" readonly="readonly" placeholder="离职时间" class="input-text bind time-drop end-time" type="text"/>
                        </dd>
                        <dd style="padding-left: 120px;"><input nullmsg="请选择完整时间段" type="hidden" class="bind hide-val"/></dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>工作内容:</dt>
                        <dd>
                            <div class="textarea-wrap">
                                <textarea name="job_detail" maxlength="50" nullmsg="请大致介绍您的工作内容" placeholder="请大致介绍您的工作内容" style="height: 80px;" class="input-text bind"></textarea>
                            </div>
                        </dd>
                    </dl>
                    <p class="del-entry">
                        <a class="delete" href="javascript:void(0)">删除本条</a>
                    </p>
                    <div class="line"></div>
                </form>
                </div>
                <dl class="group-input" style="margin-left: -60px; width: 450px;">
                    <dt></dt>
                    <dd class="btn-group">
                        <button id="addItem" style="width: 320px;" class="edit btn"><strong>+</strong>添加更多工作经历</button>
                    </dd>
                </dl>
                <div class="btn-group" style="text-align: right; margin-left: -60px; width: 450px;">
                    <a href="/resume/guide/educations">
                        <button style="width: 146px;" class="btn cancel">上一步</button>
                    </a>
                    <button data-href = "${next}" id="nextPage" style="width: 146px; margin-left:28px;" class="btn">完成</button>
                </div>
            </div>
            
            <div class="book-corner"></div>
            </div>
            </div>
            </div>
            
            
            
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
    </body>
</html>