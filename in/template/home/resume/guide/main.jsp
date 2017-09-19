<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  User: caobug
  Date: 2017/7/31
  Time: 09:49
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>完善基本资料 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <style>
    .erro_msg{margin-top: 0; margin-bottom: -10px;}
    .btn-group{position: relative; z-index: 10;}
    </style>
    <body>
        <div style="height:78px;"></div>
        <div class="wrap-700">
            
            <div class="bj-paper">
            <div class="bj-paper">
            <div class="bj-paper">
            
            
            <div class="perfect-head">
                <p class="text">填写基本资料</p>
                <p class="index"><span>1</span>/3</p>
            </div>
            <div class="perfect-box">
                <div class="circle">
                    <img draggable="false" width="44" src="../../../../img/circle.png"/>
                </div>
                <div class="up-avatar-box">
                        <div class="avatar">
                            <c:if test="${not empty resume.avatar}">
                                <img width="120" height="120" src="${resume.avatar}" id="picview"/>
                            </c:if>
                            <c:if test="${empty resume.avatar}">
                                <img width="120" height="120" src="//cdn.tradehelp.cn/avatar/default.jpg" id="picview"/>
                            </c:if>
                            <div class="mask-up">
                                <p><i class="icon"></i></p>
                                <div id="mask-up"></div>
                            </div>
                        </div>
                        <div class="ring-left">
                            <i class="ring"></i>
                        </div>
                        <div class="ring-right">
                            <i class="ring"></i>
                        </div>
                    </div>
                <form id="update" style="margin-left: -60px; width: 450px;">
                    <div style="height:10px;"></div>
                    <dl class="group-input">
                        <dt><span class="red">*</span>姓名:</dt>
                        <dd>
                            <input autocomplete="off" value="${resume.name}"" datatype="*" nullmsg="请输入您的真实姓名" errormsg="请输入您的真实姓名" name="name" placeholder="请输入您的真实姓名" class="input-text" type="text"/>
                        </dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>地区:</dt>
                        <dd style="margin-right:20px;">
                            <input type="hidden" value="${resume.liveCity.parent.id}"/>
                            <select style="width: 150px;" class="input-text province-select">
                                <option value="">请选择省</option>
                            </select>
                        </dd>
                        <dd>
                            <input type="hidden" value="${resume.liveCity.id}"/>
                            <select style="width: 150px;" class="input-text city-select">
                                <option value="">请选择城市</option>
                            </select>
                        </dd>
                        <dd style="clear: both; padding-left: 130px;">
                            <input type="hidden" datatype="*" nullmsg="请选择你所在的城市" errormsg="请选择你所在的城市" name="live_city" type="text"/>
                        </dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>邮箱:</dt>
                        <dd>
                            <input autocomplete="off" value="${resume.email}" datatype="e" nullmsg="请输入您的邮箱" errormsg="请输入正确的邮箱" name="email" placeholder="请填写您常用的邮箱" class="input-text" type="text"/>
                        </dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>工作经验:</dt>
                        <dd>
                            <select name="experience" class="input-text">
                                <c:forEach items="${baseExperiences}" var="baseExperience">
                                <option ${baseExperience.id==resume.experience.id ? "selected='selected'": ""} value="${baseExperience.id}">${baseExperience.experience}</option>
                                </c:forEach>
                            </select>
                        </dd>
                    </dl>
                    <dl class="group-input">
                        <dt><span class="red">*</span>简短介绍:</dt>
                        <dd>
                            <div style="height:92px;" class="textarea-wrap">
                                <textarea maxlength="50" datatype="*1-50" nullmsg="请用一句话介绍自己" errormsg="字数请小于50字" name="self_introduction" placeholder="一句话介绍自己，告诉我为什么选择你而不是 别人" style="height: 80px;" class="input-text count-word-box">${resume.selfIntroduction}</textarea>
                                <p class="nub"><span class="count-word">0</span>/50字</p>
                            </div>
                        </dd>
                    </dl>
                    <div class="btn-group" style="text-align: right;">
                        <button style="margin-right: 20px;" type="button" id="skip" class="btn cancel">跳过</button>
                        <button type="submit" class="btn">下一步</button>
                    </div>
                </form>                
            </div>
            
            <div class="book-corner"></div>
            </div>
            </div>
            </div>
            
            
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <script src="${url.cdn}/static/plugins/webuploader/webuploader.js"></script>
    </body>
</html>