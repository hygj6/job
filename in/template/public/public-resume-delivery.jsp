<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--选择默认投递简历-->
<div id="ChooseDeliveryBox" class="modal-backdrop">
    <div class="modal-dialog" style="width:500px;">
        <div class="modal-header">
                    投递简历
        <i class="icon off"></i>    
        </div>
        <form>
        <div class="modal-cont form-wrap" style="padding-top: 15px;">
            <div class="form-box">
                <p class="title" style="padding-bottom: 13px;">请选择你要投递出去的简历</p>
                <div class="radio-group">
                    <label class="item"><input value="1" name="delivery_way" checked="checked" type="radio"/>在线简历<span class="label"><span class="user">用户</span>的在线简历</span></label>
                    <label class="item"><input disabled="disabled" value="2" name="delivery_way" type="radio"/>附件简历<span class="annex-state label red file-doc">暂无附件简历</span></label>
                </div>
                <p class="checkbox-group" style="padding:3px 0px 5px;">
                    <label><input name="default_choice" type="checkbox"/>默认使用此投递方式，下次不再提示</label>
                </p>
                <div class="tool-box">
                    <div class="tool-group">
                        <a class="item" target="_blank" href="/resume/preview?type=1">预览</a><i class="line"></i>
                        <a class="item" target="_blank" href="/resume">修改</a>
                    </div>
                    <div class="tool-group" style="margin-top: 14px;">
                        <div class="item mask-up-wrap">上传附件简历
                        <div class="mask-up" id="upload_resume" style="height: 35px;">
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-foot">
            <div class="blank-1"></div>
            <div class="btn-group" style="text-align: center;">
                <button type="submit" class="btn">立即投递</button>
            </div>
        </div>
        </form>
        <div class="blank-2"></div>
    </div>
</div>
<!--个人信息完善-->
<div id="IncompleteResumeBox" class="modal-backdrop">
    <div class="modal-dialog" style="width:500px;">
        <div class="modal-header">
                                 个人信息确认
        <i class="icon off"></i>    
        </div>
        <form>
        <div class="modal-cont form-wrap" style="padding-top: 15px;">
            <div class="form-box">
                <p class="title" style="padding-bottom: 13px;">为方便所投企业HR查询，请确认个人信息，HR将通过此联系方式与你沟通</p>
                <dl class="input-group">
                    <dd><input datatype="*" nullmsg="请输入你的名字" errormsg="请输入你的名字" placeholder="请输入你的名字" name="name" class="input-text" type="text"/></dd>
                    <dd>
                        <select datatype="*" nullmsg="请选择学历" errormsg="请选择学历" name="education" class="input-text">
                            <option value="">请选择学历</option>
                            <c:forEach items="${baseEducations}" var="baseEducation">
                            <option ${baseEducation.id==education.type.id ? "selected='selected'": ""} value="${baseEducation.id}">${baseEducation.education}</option>
                            </c:forEach>
                        </select>
                    </dd>
                </dl>
                <dl class="input-group">
                    <dd>
                        <select datatype="*" nullmsg="请选择工作经验" errormsg="请选择工作经验" name="experience" class="input-text">
                            <option value="">请选择工作经验</option>
                            <c:forEach items="${baseExperiences}" var="baseExperience">
                            <option ${baseExperience.id==resume.experience.id ? "selected='selected'": ""} value="${baseExperience.id}">${baseExperience.experience}</option>
                            </c:forEach>
                        </select>
                    </dd>
                    <dd class="address-box" id="address" style="position: relative;">
                        <input readonly="readonly" datatype="*" nullmsg="请选择期望城市" errormsg="请选择期望城市" placeholder="请选择期望城市" class="input-text" type="text"/>
                        <input type="hidden" class="province_id"/>
                        <input type="hidden" name="expect_city" class="city_id"/>
                        <div class="address-list" style="left: inherit; right: 0; top: 35px;">
                            <div class="province">
                                <ul>
                                    
                                </ul>
                            </div>
                            <div class="box-tab">
                                <div class="city-list" id="city-list">
                                    
                                </div>
                            </div>
                        </div>
                    </dd>
                </dl>
                <dl class="input-group">
                    <dd><input datatype="m" nullmsg="请输入手机号码" errormsg="请输入正确的手机号码" placeholder="请输入手机号码" name="phone" class="input-text" type="text"/></dd>
                    <dd><input datatype="e" nullmsg="请输入你的邮箱" errormsg="请输入正确的邮箱" placeholder="请输入你的邮箱" name="email" class="input-text" type="text"/></dd>
                </dl>
            </div>
        </div>
        <div class="modal-foot">
            <div class="blank-1"></div>
            <div class="btn-group" style="text-align: center;">
                <button type="submit" class="btn">立即投递</button>
            </div>
        </div>
        </form>
        <div class="blank-2"></div>
    </div>
</div>
<!--预期不匹配-->
<div id="IncompatibleExpectBox" class="modal-backdrop">
    <div class="modal-dialog" style="width:500px;">
        <div class="modal-header">
                                 投递确认
        <i class="icon off"></i>    
        </div>
        <form>
        <input name="ignore_match" type="hidden" value="true"/>
        <div class="modal-cont form-wrap" style="padding-top: 15px;">
            <div class="form-box">
                <p style="padding-bottom: 10px;" class="title">你的简历中：</p>
                <p class="title" style="padding-bottom:5px;">
                    <span class="red">
                        <span class="match-state"></span>
                    </span>与该职位要求不匹配，确认要投递吗？
                </p>
            </div>
        </div>
        <div class="modal-foot">
            <div class="blank-1"></div>
            <div class="btn-group">
                <button type="button" class="btn cancel">放弃</button>
                <button type="submit" class="btn">立即投递</button>
            </div>
        </div>
        </form>
        <div class="blank-2"></div>
    </div>
</div>
<!--投递成功-->
<div id="WithdrawBox" class="modal-backdrop">
    <div class="modal-dialog" style="width:500px;">
        <div class="modal-header">
                    投递简历
        <i class="icon off"></i>    
        </div>
        <form>
        <div class="blank-1"></div>
        <div class="modal-cont form-wrap" style="padding-top: 15px;">
            <div class="form-box">
                <p class="title" style="padding-bottom:5px;">简历已成功投递出去，请静候佳音！<a id="cannel-delivery" href="javascript:void(0)">撤回(<span class="nub">10</span>s)</a></p>
            </div>
        </div>
        <div class="blank-1"></div>
        <div class="modal-foot">
            <div class="blank-1"></div>
            <div class="btn-group" style="text-align: center;">
                <button type="button" class="btn">知道了</button>
            </div>
        </div>
        </form>
        <div class="blank-2"></div>
    </div>
</div>
<!--撤回成功-->
<div id="WithdrawSuccessBox" class="modal-backdrop">
    <div class="modal-dialog" style="width:500px;">
        <div class="modal-header">
                     投递简历
        <i class="icon off"></i>    
        </div>
        <form>
        <div class="blank-1"></div>
        <div class="modal-cont form-wrap" style="padding-top: 15px;">
            <div class="form-box">
                <p class="title" style="padding-bottom:5px;">已成功撤回，企业将无法看到本次投递</p>
            </div>
        </div>
        <div class="blank-1"></div>
        <div class="modal-foot">
            <div class="blank-1"></div>
            <div class="btn-group" style="text-align: center;">
                <button type="submit" class="btn">知道了</button>
            </div>
        </div>
        </form>
        <div class="blank-2"></div>
    </div>
</div>
<!--请不要重复投递-->
<div id="DuplicateDeliveryBox" class="modal-backdrop">
    <div class="modal-dialog" style="width:500px;">
        <div class="modal-header">
                                 提醒
        <i class="icon off"></i>    
        </div>
        <form>
        <div class="blank-1"></div>
        <div class="modal-cont form-wrap" style="padding-top: 15px;">
            <div class="form-box">
                <p class="title" style="padding-bottom:5px;">该职位已投递简历，请不要重复投递</p>
            </div>
        </div>
        <div class="blank-1"></div>
        <div class="modal-foot">
            <div class="blank-1"></div>
            <div class="btn-group" style="text-align: center;">
                <button type="submit" class="btn">知道了</button>
            </div>
        </div>
        </form>
        <div class="blank-2"></div>
    </div>
</div>
<style>
.modal-backdrop .modal-dialog .modal-cont .title{font-size: 16px;}
.modal-backdrop .modal-dialog .modal-cont .title .red{color:#ff5d5d;}
.modal-backdrop .modal-dialog .modal-cont .title a{color:#00b38a;}
.modal-backdrop .modal-dialog .modal-cont .radio-group label.item{display: block; color: #333; line-height: 35px; margin-bottom: 10px;}
.modal-backdrop .modal-dialog .modal-cont .radio-group label.item input{margin:-2px 10px 0px 0px; }
.modal-backdrop .modal-dialog .modal-cont .radio-group label.item .label{color: #999; padding-left:30px; font-size: 12px;}
.modal-backdrop .modal-dialog .modal-cont .radio-group label.item .label.red{color:#ff5d5d;}
.modal-backdrop .modal-dialog .modal-cont .checkbox-group{font-size: 12px; color: #333;}
.modal-backdrop .modal-dialog .modal-cont .checkbox-group input{margin:-2px 10px 0px 0px;}
.modal-backdrop .modal-dialog .modal-cont .form-box{position: relative;}
.modal-backdrop .modal-dialog .modal-cont .form-box .tool-box{position: absolute; right: 0; top:35px;}
.modal-backdrop .modal-dialog .modal-cont .form-box .tool-box .tool-group{text-align: right; line-height: 35px;}
.modal-backdrop .modal-dialog .modal-cont .form-box .tool-box .tool-group .item{background: no-repeat; border: none; color:#00b38a; margin-bottom: 5px;}
.modal-backdrop .modal-dialog .modal-cont .form-box .tool-box .tool-group .line{width:1px; display: inline-block; vertical-align: middle; height:15px; background: #ebebeb; margin:-4px 10px 0px 12px;}
.modal-backdrop .modal-dialog .modal-cont .form-box .input-group{margin-left: -20px;}
.modal-backdrop .modal-dialog .modal-cont .form-box .input-group dd{float: left; width: 220px; margin-left: 20px;}
.modal-backdrop .modal-dialog .modal-cont .form-box .input-group dd .input-text{width: 198px; height: 24px; line-height: 24px; border: 1px solid #ddd; background: #f6f6f6;}
.modal-backdrop .modal-dialog .modal-cont .form-box .input-group dd select.input-text{width:220px; height: 36px;}
</style>
<script>
var SubmitData={}
</script>
<script src="${url.cdn}/static/plugins/webuploader/webuploader.js"></script>