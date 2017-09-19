<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <title>我的简历 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <style>
    .resume-cont .edit-box{margin-left:-26px; margin-bottom: 20px; display: none;}
    .resume-cont .edit-box .group-input dd{padding: 0;}
    .erro_msg{margin-top: 0; margin-bottom: -20px;}
    .resume-cont .edit-box form{position: relative;}
    .resume-cont .edit-box form .del{position: absolute; right:-130px; bottom: 0;}
    .checked-group .item{margin-right: 20px; margin-top: -6px; vertical-align: middle;}
    .slogan{position: relative;}
    .slogan .edit{position: absolute; right:10px; top: 0; color:#00b38a;}
    .slogan .edit:hover{text-decoration: underline;}
    </style>
    <body>
        <div class="anchor"></div>
        <jsp:include page="/WEB-INF/public/public-home-head.jsp"/>
        <div class="wrap main">
            <div class="left-cont">
                <div class="resume-cont" style="padding: 0px 20px;">
                    <div class="resume-bar"></div>
                    <div class="up-avatar-box">
                        <div class="avatar">
                            <img width="120" height="120" src="${resume.avatar}" id="picview"/>
                            <div class="mask-up">
                                <p><i class="icon"></i></p>
                            </div>
                            <div id="mask-up"></div>
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
                        <div class="slogan"><span class="self_introduction">${resume.selfIntroduction}</span><a id="editbase" class="edit" href="javascript:void(0)">编辑</a></div>
                        <p class="min-info"><i class="icon icon-avatar" style="font-size: 14px;"></i><span class="education">${resume.education.education} / ${resume.experience.experience}</span></p>
                        <p class="min-info">
                        <i class="icon icon-icon_mobile" style="font-size: 16px;"></i><span class="phone">${resume.phone}</span>
                        <span style="padding-left: 27px;"></span>
                        <i class="icon icon-icon_email"></i><span class="email">${resume.email}</span></p>
                        <form style="display: none;" id="baseInfo">
                            <input value="${resume.name}" name="name" type="text"/>
                            <input value="${resume.sex}" name="sex" type="text"/>
                            <input value="${resume.liveCity.id}" name="live_city" type="text"/>
                            <input value="${resume.liveCity.parent.id}" name="live_province" type="text"/>
                            <input value="${resume.expectCity.id}" name="expect_city" type="text"/>
                            <input value="${resume.expectCity.parent.id}" name="expect_province" type="text"/>
                            <input value="${resume.email}" name="email" type="text"/>
                            <input value="${resume.phone}" name="phone" type="text"/>
                            <input value="${resume.experience.id}" name="experience" type="text"/>
                            <input value="${resume.education.id}" name="education" type="text"/>
                            <input value="${resume.selfIntroduction}" name="self_introduction" type="text"/>
                        </form>
                    </div>
                    <div style="display: none; margin-top: 20px;" id="edit-base-info">
                        <div class="edit-box" style="display: block; margin: 0;">
                            <form id="updateInfo">    
                                <dl class="group-input">
                                    <dt><span class="red">*</span>姓名</dt>
                                    <dd>
                                        <input value="${resume.name}" datatype="*" nullmsg="请输入您的真实姓名" errormsg="请输入您的真实姓名" name="name" placeholder="请输入您的真实姓名" class="input-text" type="text"/>
                                    </dd>
                                </dl>
                                <dl class="group-input">
                                    <dt><span class="red">*</span>性别</dt>
                                    <dd>
                                        <div class="checked-group" style="line-height:44px;">
                                        <label class="item">
                                            <label class="radio-label"><input value="0" name="sex" type="radio"><i></i></label>
                                                                                                                                    女
                                        </label>
                                        <label class="item">
                                            <label class="radio-label"><input value="1" name="sex" type="radio"><i></i></label>
                                                                                                                                    男
                                        </label>
                                        </div>
                                    </dd>
                                </dl>
                                <dl class="group-input">
                                    <dt><span class="red">*</span>所在城市</dt>
                                    <dd style="width: 155px; position: relative;">
                                        <input type="hidden"/>
                                        <select name="live_province" style="width: 155px;" class="input-text province-select">
                                            <option value="">请选择省</option>
                                        </select>
                                    </dd>
                                    <dd style="width: 155px; margin-left: 20px;">
                                        <input type="hidden"/>
                                        <select name="live_city" style="width: 155px;" class="input-text city-select">
                                            <option value="">请选择城市</option>
                                        </select>
                                    </dd>
                                    <dd style="padding-left:90px;"><input type="hidden" datatype="*" nullmsg="请选择城市" errormsg="请选择城市" type="" class="bind hide-val"/></dd>
                                </dl>
                                <dl class="group-input">
                                    <dt><span class="red">*</span>期望城市</dt>
                                    <dd style="width: 155px; position: relative;">
                                        <input type="hidden"/>
                                        <select name="expect_province" style="width: 155px;" class="input-text province-select">
                                            <option value="">请选择省</option>
                                        </select>
                                    </dd>
                                    <dd style="width: 155px; margin-left: 20px;">
                                        <input type="hidden"/>
                                        <select name="expect_city" style="width: 155px;" class="input-text city-select">
                                            <option value="">请选择城市</option>
                                        </select>
                                    </dd>
                                    <dd style="padding-left:90px;"><input type="hidden" datatype="*" nullmsg="请选择城市" errormsg="请选择城市" type="" class="bind hide-val"/></dd>
                                </dl>
                                <dl class="group-input">
                                    <dt><span class="red">*</span>邮箱</dt>
                                    <dd>
                                        <input name="email" datatype="e" nullmsg="请填写您的邮箱" errormsg="请填写您的邮箱" placeholder="请填写您的邮箱" class="input-text" type="text"/>
                                    </dd>
                                </dl>
                                <dl class="group-input">
                                    <dt><span class="red">*</span>手机</dt>
                                    <dd>
                                        <input name="phone" datatype="m" nullmsg="请填写您的联系电话" errormsg="请填写正确的联系电话" placeholder="请填写您的联系电话" class="input-text" type="text"/>
                                    </dd>
                                </dl>
                                <dl class="group-input">
                                    <dt><span class="red">*</span>工作经验</dt>
                                    <dd>
                                        <select datatype="*" nullmsg="请选择工作经验" errormsg="请选择工作经验" name="experience" style="width: 330px;" class="input-text">
                                            <option value="">请选择您的工作经验</option>
                                            <c:forEach items="${baseExperiences}" var="baseExperience">
                                            <option value="${baseExperience.id}">${baseExperience.experience}</option>
                                            </c:forEach>
                                        </select>
                                    </dd>
                                </dl>
                                <dl class="group-input">
                                    <dt><span class="red">*</span>最高学历</dt>
                                    <dd>
                                        <select datatype="*" nullmsg="请选择最高学历" errormsg="请选择最高学历" name="education" style="width: 330px;" class="input-text">
                                            <option value="">请选择您的最高学历</option>
                                            <c:forEach items="${baseEducations}" var="baseEducation">
                                                <option value="${baseEducation.id}">${baseEducation.education}</option>
                                            </c:forEach>
                                        </select>
                                    </dd>
                                </dl>
                                <dl class="group-input">
                                    <dt><span class="red">*</span>自我介绍</dt>
                                    <dd>
                                        <textarea datatype="*1-50" nullmsg="请填写您的自我介绍" errormsg="请小于50字" name="self_introduction" style="height:90px;" placeholder="请介绍您的工作内容" class="input-text"></textarea>
                                    </dd>
                                </dl>
                                <div class="btn-group" style="padding-left:90px;">
                                    <button type="submit" class="btn">保存</button>
                                    <button type="button" class="btn cancel">取消</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <p class="blank-2"></p>
                    <div class="experience">
                        <p class="title anchor">工作经历<a class="tool-btn" id="add-experience" href="javascript:void(0)">添加</a></p>
                        <div id="experience-list" class="experience-list">
                            <div class="edit-box">
                                <form>
                                    <input type="text" style="display: none;" name="id"/>
                                    <dl class="group-input">
                                        <dt><span class="red">*</span>公司名称</dt>
                                        <dd>
                                            <input datatype="*" nullmsg="请输入您的所在公司名称" errormsg="请输入您的所在公司名称" name="company" placeholder="请输入您的所在公司名称" class="input-text" type="text"/>
                                        </dd>
                                    </dl>
                                    <dl class="group-input">
                                        <dt><span class="red">*</span>职位</dt>
                                        <dd>
                                            <input datatype="*" nullmsg="请填写您的所在公司职位" errormsg="请填写您的所在公司职位" name="position" placeholder="请填写您的所在公司职位" class="input-text" type="text"/>
                                        </dd>
                                    </dl>
                                    <dl class="group-input">
                                        <dt><span class="red">*</span>时间</dt>
                                        <dd style="width: 150px; position: relative;">
                                            <input value="" style="width: 130px;" readonly="readonly" name="hire_date" placeholder="入职时间" class="input-text bind time-drop start-time" type="text"/>
                                        </dd>
                                        <dd style="width:30px; text-align: center; line-height: 40px;">-</dd>
                                        <dd style="width: 150px; position: relative;">
                                            <input value="" style="width: 130px;" readonly="readonly" name="leaving_date" placeholder="离职时间" class="input-text bind time-drop end-time" type="text"/>
                                        </dd>
                                        <dd style="padding-left:90px;"><input type="hidden" datatype="*" nullmsg="请选择完整时间段" errormsg="请选择完整时间段" type="" class="bind hide-val"/></dd>
                                    </dl>
                                    <dl class="group-input">
                                        <dt><span class="red">*</span>工作内容</dt>
                                        <dd>
                                            <textarea datatype="*" nullmsg="请填写您的工作内容" errormsg="请填写您的工作内容" name="job_detail" style="height:150px;" placeholder="请介绍您的工作内容" class="input-text"></textarea>
                                        </dd>
                                    </dl>
                                    <div class="btn-group" style="padding-left:90px;">
                                        <button type="submit" class="btn">保存</button>
                                        <button type="button" class="btn cancel">取消</button>
                                    </div>
                                    <a class="del" href="javascript:void(0)">删除</a>
                                </form>
                            </div>
                            <c:forEach items="${resume.experiences}" var="experience">
                            <dl class="item" data-time="<fn:formatDate value="${experience.hireDate}" pattern="yyyyMM"/>">
                                <dt>
                                    <input type="hidden" class="id" value="${experience.id}"/>
                                    <div class="company-mod"><p class="company company-name">${experience.company}</p><span class="time">
                                    <span class="hire_date"><fn:formatDate value="${experience.hireDate}" pattern="yyyy-MM"/></span>
                                     ~ 
                                    <span class="leaving_date"><fn:formatDate value="${experience.leavingDate}" pattern="yyyy-MM"/></span>
                                    </span><a class="tool-btn edit" href="javascript:void(0)">编辑</a></div>
                                    <p class="job position">${experience.position}</p>
                                </dt>
                                <dd>
                                    <p class="job_detail">${experience.jobDetail}</p>
                                </dd>
                            </dl>
                            </c:forEach>
                        </div>
                        <p class="title anchor">教育经历<a class="tool-btn" id="add-education" href="javascript:void(0)">添加</a></p>
                        <div id="educations-list" class="experience-list">
                            <div class="edit-box">
                                <form>
                                    <input type="text" style="display: none;" name="id"/>
                                    <dl class="group-input">
                                        <dt><span class="red">*</span>学校</dt>
                                        <dd>
                                            <div class="school-match">
                                                <input datatype="*" nullmsg="请输入您的真实校名" errormsg="请输入您的真实校名" name="school" placeholder="请输入您的真实校名" class="input-text" type="text"/>
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl class="group-input">
                                        <dt><span class="red">*</span>专业</dt>
                                        <dd>
                                            <div class="major-match">
                                                <input datatype="*" nullmsg="请输入您的专业" errormsg="请输入您的专业" name="major"  placeholder="请输入您的专业" class="input-text" type="text"/>
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl class="group-input">
                                        <dt><span class="red">*</span>学历:</dt>
                                        <dd style="width: 150px;">
                                            <select datatype="*" nullmsg="请选择您的学历" errormsg="请选择您的学历" name="type_id" style="width: 150px;" class="input-text">
                                                <option value="">请选择学历</option>
                                                <c:forEach items="${baseEducations}" var="baseEducation">
                                                <option value="${baseEducation.id}">${baseEducation.education}</option>
                                                </c:forEach>
                                            </select>
                                        </dd>
                                        <dd style="width:30px; text-align: center; line-height: 40px;">-</dd>
                                        <dd style="width: 150px;">
                                            <select datatype="*" nullmsg="请选择您的毕业年份" errormsg="请选择您的毕业年份" name="graduation_year" style="width: 150px;" class="input-text">
                                                <c:forEach items="${years}" var="year">
                                                    <option>${year}</option>
                                                </c:forEach>
                                            </select>
                                        </dd>
                                    </dl>
                                    <div class="btn-group" style="padding-left:90px;">
                                        <button type="submit" class="btn">保存</button>
                                        <button type="button" class="btn cancel">取消</button>
                                    </div>
                                    <a class="del" href="javascript:void(0)">删除</a>
                                </form>
                            </div>
                            <c:forEach items="${resume.educations}" var="education">
                            <dl data-time="${education.graduationYear}" class="item">
                                <dt>
                                    <input type="hidden" class="id" value="${education.id}"/>
                                    <div class="company-mod"><p class="company-name school">${education.school}</p><span class="time"><span class="graduation_year">${education.graduationYear>0?education.graduationYear:"--"}</span>毕业</span><a class="tool-btn edit" href="javascript:void(0)">编辑</a></div>
                                    <p class="job"><span class="major">${not empty education.major?education.major:"--"}</span>/<span class="type">${not empty education.type.education?education.type.education:"--"}</span><input type="hidden" name="type_id" value="${education.type.id}"></p>
                                </dt>
                            </dl>
                            </c:forEach>
                        </div>
                        <div style="text-align: center;">
                        <div class="inline-block" style="text-align: left;">
                        <select id="state-select" class="state-select select-custom">
                            <c:forEach items="${workStatuses}" var="workStatuse">
                                <option ${workStatuse.id==resume.workStatus.id ? "selected='selected'": ""} value="${workStatuse.id}">${workStatuse.description}</option>
                            </c:forEach>
                        </select>
                        </div>
                        </div>
                        <div class="clear" style="height: 180px;"></div>
                    </div>
                </div>
            </div>
            <div class="right-cont info-brief hollow">
                <ul class="resume-tool-nav">
                    <li>
                        <a href="/resume/delivery/list">我的投递<i class="icon icon-goto"></i></a>
                    </li>
                </ul>
                <div class="resume-base-info">
                    <p class="label">简历完整度：${resume.completedPercent}%</p>
                    <div class="resume-progress-bar">
                        <div class="bar" style="width: ${resume.completedPercent}%;"></div>
                    </div>
                    <div class="button-group">
                        <a target="_blank" href="/resume/preview?type=1" class="btn">预览</a>
                        <a href="/resume/download" class="btn">下载简历</a>
                    </div>
                </div>
                <div class="resume-base-info">
                    <c:if test="${not empty resume.attachment}">
                    <i id="del_resume" class="del-resume icon icon-icon_close"></i>
                    </c:if>
                    <div class="blank-1"></div>
                    <div class="resume-file">
                        <i class="icon icon-resume"></i>
                        <c:if test="${not empty resume.attachment}">
                        <a id="hasFileResume" class="item" target="_blank" href="${resume.attachmentPdf}">${resume.name}的附件简历</a>
                        </c:if>
                        <c:if test="${empty resume.attachment}">
                        <div id="notHasFileResume" class="item mask-up-wrap item">上传附件简历
                            <div class="mask-up" id="upload_resume" style="height: 35px;">
                            </div>
                        </div>
                        </c:if>
                    </div>
                    <div class="blank-2"></div>
                    <div id="btn-select-resume" class="btn-select-resume">默认投递：<span id="typeName">${resume.deliveryWay=='1'?'在线简历':'附件简历'}</span><span class="arow-b"></span></div>
                    <div class="select-resume-item">
                        <ul>
                            <li ${resume.deliveryWay=='1'?'class="on"':''} data-id = "1">在线简历</li>
                            <c:if test="${not empty resume.attachment}">
                                <li ${resume.deliveryWay=='2'?'class="on"':''} data-id = "2">附件简历</li>
                            </c:if>
                        </ul>
                    </div>
                </div>
                <div id="catalog">
                <div class="resume-base-info catalog" style="margin: 0; width: 250px; padding: 0;">
                    <ul class="resume-info-list">
                        <li class="on"><span class="arow-r"></span><a href="javascript:void(0)"><i class="icon icon-avatar"></i>基本信息</a></li>
                        <li><span class="arow-r"></span><a href="javascript:void(0)"><i class="icon icon-icon_work"></i>工作经历</a></li>
                        <li><span class="arow-r"></span><a href="javascript:void(0)"><i class="icon icon-icon_education"></i>教育经历</a></li>
                    </ul>
                </div>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <script src="${url.cdn}/static/plugins/webuploader/webuploader.js"></script>
    </body>
    <script>
    $(window).scroll(function(){
        var t1=$("#catalog").offset().top;
        var t2=$(window).scrollTop();
        if(t1-t2<=0){
            $("#catalog .catalog").addClass("fixed");
        }else{
            $("#catalog .catalog").removeClass("fixed");
        }
    
        $(".anchor").each(function(index){
            var $t1=$(this).offset().top;
            var $t2=$(window).scrollTop();
            var $index=index;
            if($t1-$t2<=0){
                $("#catalog li").eq($index).addClass("on").siblings("li").removeClass("on");
            }
        })   
    });
    $("#catalog li").click(function(){
        var $index=$(this).index();
        $(".anchor").each(function(index){
            if(index==$index){
                var $t1=$(this).offset().top;
                $("html,body").animate({scrollTop:$t1},400);
            }
        })
    });
    </script>
</html>
