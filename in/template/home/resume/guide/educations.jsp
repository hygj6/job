<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  User: caobug
  Date: 2017/7/31
  Time: 11:17
--%>
<%@include file="/WEB-INF/public/common_macro.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>完善教育信息 - 外贸帮手网</title>
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
                <p class="text">完善教育信息</p>
                <p class="index"><span>2</span>/3</p>
            </div>
            <div id="educations" style="padding-top:30px;" class="perfect-box">
                <a class="skip" href="/resume/guide/experiences">跳过</a>
                <div class="circle">
                    <img draggable="false" width="44" src="../../../../img/circle.png"/>
                </div>
                <c:forEach items="${educations}" var="education" varStatus="status">
                <form style="margin-left: -60px; width: 450px;">
                    <input type="hidden" value="<c:out value='${education.id}'/>" name="id"/>
                    <dl class="group-input">
                        <dt><span class="red">*</span>学校:</dt>
                        <dd>
                            <div class="school-match">
                            <input autocomplete="off" nullmsg="请填写学校名称" value="<c:out value='${education.school}'/>" name="school" placeholder="请输入您的真实校名" class="input-text bind" type="text"/>
                            </div>
                        </dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>专业:</dt>
                        <dd>
                            <div class="major-match">
                            <input autocomplete="off" nullmsg="请填写专业" value="<c:out value='${education.major}'/>" name="major" placeholder="请输入您的专业" class="input-text bind" type="text"/>
                            </div>
                        </dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>学历:</dt>
                        <dd style="width: 146px;">
                            <select name="type_id" style="width: 146px;" class="input-text bind">
                                <option value="">请选择学历</option>
                                <c:forEach items="${baseEducations}" var="baseEducation">
                                <option ${baseEducation.id==education.type.id ? "selected='selected'": ""} value="${baseEducation.id}">${baseEducation.education}</option>
                                </c:forEach>
                            </select>
                        </dd>
                        <dd style="width: 146px; margin-left: 28px;">
                            <select name="graduation_year" style="width: 146px;" class="input-text bind">
                                <option value="">请选择毕业年份</option>
                                <c:forEach items="${years}" var="year">
                                    <option ${year==education.graduationYear ? "selected='selected'": ""}>${year}</option>
                                </c:forEach>
                            </select>
                        </dd>
                        <dd style="padding-left: 120px;"><input value="<c:if test="${not empty education.graduationYear&&not empty education.type.id}">${education.graduationYear}_${education.type.id}</c:if>" nullmsg="请选择学历和毕业年份" type="hidden" class="bind hide-val"/></dd>
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
                        <dt><span class="red">*</span>学校:</dt>
                        <dd>
                            <input nullmsg="请填写学校名称" name="school" placeholder="请输入您的真实校名" class="input-text bind" type="text"/>
                        </dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>专业:</dt>
                        <dd>
                            <input nullmsg="请填写专业" name="major" placeholder="请输入您的专业" class="input-text bind" type="text"/>
                        </dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>学历:</dt>
                        <dd style="width: 146px;">
                            <select name="type_id" style="width: 146px;" class="input-text bind">
                                <option value="">请选择学历</option>
                                <c:forEach items="${baseEducations}" var="baseEducation">
                                <option value="${baseEducation.id}">${baseEducation.education}</option>
                                </c:forEach>
                            </select>
                        </dd>
                        <dd style="width: 146px; margin-left: 28px;">
                            <select name="graduation_year" style="width: 146px;" class="input-text bind">
                                <option value="">请选择毕业年份</option>
                                <c:forEach items="${years}" var="year">
                                    <option>${year}</option>
                                </c:forEach>
                            </select>
                        </dd>
                        <dd style="padding-left: 120px;"><input nullmsg="请选择学历和毕业年份" type="hidden" class="bind hide-val"/></dd>
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
                        <button id="addItem" style="width: 320px;" class="btn edit"><strong>+</strong>添加更多教育经历</button>
                    </dd>
                </dl>
                <div class="btn-group" style="text-align: right; margin-left: -60px; width: 450px;">
                    
                    <a href="/resume/guide/main">
                        <button style="width: 146px;" class="btn cancel">上一步</button>
                    </a>
                    <button data-href = "${next}" id="nextPage" style="width: 146px; margin-left:28px;" class="btn">下一步</button>
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