<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
<div class="title-bar">
    <h3>应聘：${deliveryEmployee.category}</h3>
    <div class="tool-bar">
        <span>标记为</span>
        <div class="inline-block">
        <select class="select-custom" name="interviewState">
            <option value="">标记为</option>
            <option value="TO_BE_COMMUNICATED">待沟通</option>
            <option value="INTERVIEWED">已面试</option>
            <option value="TO_BE_USED">待录用</option>
            <option value="TO_BE_ENTRY">待入职</option>
            <option value="HAS_BEEN_ADMITTED">已入职</option>
        </select>
        </div>
        <c:if test="${deliveryEmployee.interviewStatus.name() != 'INAPPROPRIATE'}">
            <i class="line"></i>
            <button type="button" id="eliminate-btn">淘汰/放弃</button>
            <button type="button" id="invitation-btn">邀请面试</button>
        </c:if>
    </div>
</div>
<div class="blank-2"></div>
<div class="info-bar" style="padding: 20px 0px 20px 40px;">
    <div class="avatar">
        <img src="${deliveryEmployee.resume.avatar}"/>
    </div>
    <div class="cont" id="base-info">
        <div class="text-box">
            <form id="baseInitInfo" style="display:none;">
                <input name="name" value="${deliveryEmployee.resume.name}"/>
                <input name="phone" value="${deliveryEmployee.resume.phone}"/>
                <input name="email" value="${deliveryEmployee.resume.email}"/>
                <input name="resume_sex" value="${deliveryEmployee.resume.sex}"/>
                <input name="resume_experience_id" value="${deliveryEmployee.resume.experience.id}"/>
                <input name="resume_education_id" value="${deliveryEmployee.resume.education.id}"/>
                <input name="resume_live_city_id" value="${deliveryEmployee.resume.liveCity.id}"/>
                <input name="province_id" value="${deliveryEmployee.resume.liveCity.parent.id}"/>
                <input name="provinceName" value=""/>
            </form>
            <p class="vm-name name">
            ${deliveryEmployee.resume.name}
            <a href="javascript:void(0)" class="btn chat-btn" data-id = "${deliveryEmployee.resume.id}"><i class="icon icon-msg1"></i>和TA聊聊</a> 
            </p>
            <p>
                <span class="vm-experienceName">${deliveryEmployee.resume.experience.experience}</span>
                <i class="line"></i>
                <span class="vm-educationName">${deliveryEmployee.resume.education.education}</span>
                <i class="line"></i>
                <span class="vm-provinceName">${deliveryEmployee.resume.liveCity.name}</span>
            </p>
            <p>手机：<span class="vm-phone">${deliveryEmployee.resume.phone}</span><span style="padding-left:25px;"></span>邮箱：<span class="vm-email">${deliveryEmployee.resume.email}</span></p>
            <a class="edit" href="javascript:void(0)"><i class="icon icon-edit"></i>编辑</a>
        </div>
        <div style="display: none;" class="edit-box">
            <div class="form-group" style="width:670px;">
            <form id="base-resume">
                <input type="hidden" name="id"/>
                <div>
                    <input data-top="-10" datatype="*" nullmsg="请输入备注名称" errormsg="请输入备注名称" name="name" placeholder="备注名" style="width: 100px;" class="input-text" type="text"/>
                </div>
                <div>
                    <div style="float: left;">
                        <div class="address-box" id="address" style="position: relative; width:338px; display: inline-block;">
                            <input data-top="-10" datatype="*" nullmsg="请输入城市" errormsg="请输入城市" readonly="readonly" style="width:306px;" placeholder="所在城市" class="input-text" type="text"/>
                            <input type="hidden" name="province_id" class="province_id"/>
                            <input type="hidden" name="resume_live_city_id" class="city_id"/>
                            <div class="address-list" style="top:40px;">
                                <div class="province">
                                    <ul>
                                        
                                    </ul>
                                </div>
                                <div class="box-tab">
                                    <div class="city-list" id="city-list">
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="float: left;">
                        <select data-top="-10" datatype="*" nullmsg="请选择经验" errormsg="请选择经验" name="resume_experience_id" style="width:100px;" class="input-text">
                            <option value="">选择经验</option>
                            <c:forEach items="${baseExperiences}" var="baseExperience">
                            <option value="${baseExperience.id}">${baseExperience.experience}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div style="float: left;">
                        <select data-top="-10" name="resume_sex" style="width:100px;" class="input-text">
                            <option value="1">男</option>
                            <option value="0">女</option>
                        </select>
                    </div>
                    <div style="float: left;">
                        <select data-top="-10" datatype="*" nullmsg="请选择学历" errormsg="请选择学历" name="resume_education_id" style="width:100px;" class="input-text">
                            <option value="">选择学历</option>
                            <c:forEach items="${baseEducations}" var="baseEducation">
                            <option value="${baseEducation.id}">${baseEducation.education}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div>
                    <div style="float: left;">
                        <input data-top="-10" datatype="m" nullmsg="请输入手机号" errormsg="请输入正确的手机号" name="phone" style="width:306px;" placeholder="联系方式" class="input-text" type="text"/>
                    </div>
                    <div style="float: left;">
                        <input data-top="-10" datatype="e" nullmsg="请输入邮箱" errormsg="请输入正确的邮箱" name="email" style="width:298px;" placeholder="电子邮箱" class="input-text" type="text"/>
                    </div>
                </div>
                <div class="blank-1"></div>
                <div class="btn-group right" style="padding-right: 12px;">
                    <button type="button" class="btn cancel">取消</button>
                    <button type="submit" class="btn enter">确定</button>
                </div>
            </form>
            </div>    
        </div>
    </div>
</div>
<div class="blank-2"></div>
<div class="resume-cont">
    <p class="name">${deliveryEmployee.resume.name}</p>
    <div class="slogan">${deliveryEmployee.resume.selfIntroduction}</div>
    <p class="min-info">${deliveryEmployee.resume.education.education}/${deliveryEmployee.resume.experience.experience}</p>
    <p class="min-info">${deliveryEmployee.resume.phone}<span style="padding-left: 27px;"></span>${deliveryEmployee.resume.email}</p>
    <p class="blank-2"></p>
    <div class="experience">
        <p class="title">工作经历</p>
        <div class="experience-list">
            <c:forEach items="${deliveryEmployee.resume.experiences}" var="experience">
                <dl>
                    <dt>
                    <div class="company-mod"><p class="company-name">${experience.company}</p><span class="time"><fmt:formatDate value="${experience.hireDate}" pattern="yyyy-MM"/> ~
                    <c:choose>
                        <c:when test="${empty experience.leavingDate}">
                            至今
                        </c:when>
                        <c:otherwise>
                            <fmt:formatDate value="${experience.leavingDate}" pattern="yyyy-MM"/>
                        </c:otherwise>
                    </c:choose>
                    </span></div>
                    <p class="job">${experience.position}</p>
                    </dt>
                    <dd>
                        ${experience.jobDetail}
                    </dd>
                </dl>
            </c:forEach>
        </div>
        <p class="title">教育经历</p>
        <div class="experience-list">
            <c:forEach items="${deliveryEmployee.resume.educations}" var="education">
                <dl>
                    <dt>
                    <div class="company-mod"><p class="company-name">${education.school}</p><span class="time">${education.graduationYear}毕业</span></div>
                    <p class="job">${education.major}/${education.type.education}</p>
                    </dt>
                </dl>
            </c:forEach>
        </div>
        <p class="tip-state"><span>${deliveryEmployee.resume.workStatus.description}</span></p>
    </div>
</div>
</div>