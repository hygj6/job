<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%--
  User: xianghuawei
  Date: 2017/6/30
  Time: 10:47
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>职位发布/编辑 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <style>
    .form-cont dl dd.w464{width: 464px;}
    </style>
    <body>
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="company-cont wrap-1200">
            <div class="middle-cont">
                <div class="main-title">
                    发布职位
                </div>
                <div class="form-cont">
                    <form id="save-job">
                    <input type="hidden" name="id" value="${job.id}"/>
                    <dl>
                        <dt>职位类别</dt>
                        <dd class="w464">
                            <div class="job-list">
                                <input <c:if test="${!empty job}">value="${job.jobCategory.parent.parent.job}/${job.jobCategory.parent.job}" disabled="disabled"</c:if> readonly="readonly" placeholder="请选择职位所属行业" class="input-text category-name" type="text">
                                <input <c:if test="${!empty job}">value="1"</c:if> name="category_id" datatype="*" nullmsg="请选择职位类别" errormsg="请选择职位类别" type="hidden" class="hide-val"/>
                                <div class="job-list-mod" id="jobList">
                                </div>
                            </div>
                        </dd>
                        <dd>
                            <div class="warning-tip"><i class="icon icon-lamp"></i><p>“职位类别”与“职位名称”在发布后不可修改，请谨慎填写。</p></div>
                        </dd>
                    </dl>
                    <dl>
                        <dt>职位名称</dt>
                        <dd class="w464">
                            <input value="${job.name}" <c:if test="${!empty job}">disabled="disabled"</c:if> datatype="*" nullmsg="请选择职位名称" errormsg="请选择职位名称" name="name" placeholder="请输入职位名称，如：外贸业务员" class="input-text" type="text"/>
                        </dd>
                        <dd>
                            <div class="warning-tip"><i class="icon icon-lamp"></i><p>“职位类别”与“职位名称”在发布后不可修改，请谨慎填写。</p></div>
                        </dd>
                    </dl>
                    <dl>
                        <dt>职位描述</dt>
                        <dd class="w464">
                            <script type="text/plain" id="JobEditor" style="width:1000px;height:240px;">${job.note}</script>
                            <textarea style="display: none;" id="JobEditorTextarea" data-top="0" datatype="*1-5000" nullmsg="请输入职位描述" errormsg="职位描述请在5000字以内" name="note"></textarea>
                        </dd>
                        <dd>
                            <div class="warning-tip"><i class="icon icon-lamp"></i><p>请勿输入公司邮箱、联系电话、薪资面议及其他外链，否则将自动删除，不可恢复。</p></div>
                        </dd>
                    </dl>
                    <dl style="margin-top: -5px;">
                        <dt>职位标签</dt>
                        <dd class="w464">
                            <div id="tag-list" class="tag-list">
                                <c:forEach items="${job.tagList}" var="tag">
                                    <div class="tag active">${tag}<i class="del icon icon-icon_close"></i></div>
                                </c:forEach>
                                <div class="tag edit" style="display: none;">
                                    <input type="text"/>
                                    <button type="button" class="enter">贴上</button>
                                </div>
                                <div class="tag on add">+新增</div>
                            </div>
                            <input type="hidden" <c:if test="${job.tagList.size()>0}">value="1"</c:if> data-top="0" id="tag-list-val" datatype="*" nullmsg="请为你的职位贴上标签" errormsg="请为你的职位贴上标签"/>
                        </dd>
                        <dd>
                            <div class="warning-tip"><i class="icon icon-lamp"></i><p>禁止使用脏话、歧视等词汇；<br>
                                                                            禁止使用国家领导人、邪教等词汇；<br>
                                                                            禁止使用修饰词汇；  e.g.环境好；<br>
                                                                            禁止使用诱惑词汇；  e.g.五险一金；<br>
                                                                            禁止使用不完整词汇；  e.g.人力资、H；<br>
                                                                            禁止使用无具体含义词汇；  e.g.三高人群；<br>
                                                                            禁止使用其他与职位类型、技能不相关的词汇。</p></div>
                        </dd>
                    </dl>
                    <div class="split-line"></div>
                    <div class="blank-2"></div>
                    <dl>
                        <dt>工作性质</dt>
                        <dd class="w464">
                            <div class="checked-group" style="line-height:44px;">
                            <c:forEach items="${workTypes}" var="workType">
                                <label class="item">
                                    <label class="radio-label"><input data-top="-15" datatype="*" nullmsg="请选择工作性质" errormsg="请选择工作性质" <c:if test="${job.workTypeId == workType.id}">checked="checked"</c:if> value = "${workType.id}" name="work_type_id" type="radio"/><i></i></label>
                                    ${workType.workType}
                                </label>
                            </c:forEach>
                            </div>
                        </dd>
                    </dl>
                    <dl>
                        <dt>工作经验</dt>
                        <dd class="w464">
                            <select name="experience_id" class="input-text select-custom">
                                <c:forEach items="${experiences}" var="experience">
                                    <option <c:if test="${job.experience.id == experience.id}">selected</c:if> value= "${experience.id}">${experience.experience}</option>
                                </c:forEach>
                            </select>
                        </dd>
                    </dl>
                    <dl>
                        <dt>学历要求</dt>
                        <dd class="w464">
                            <select name="education_id" class="input-text select-custom">
                                <c:forEach items="${educations}" var="education">
                                    <option <c:if test="${job.education.id == education.id}">selected</c:if> value = "${education.id}">${education.education}</option>
                                </c:forEach>
                            </select>
                        </dd>
                    </dl>
                    <div class="blank-2"></div>
                    <div class="split-line"></div>
                    <div class="blank-2"></div>
                    <dl>
                        <dt>所属部门</dt>
                        <dd class="w464">
                            <input datatype="*" nullmsg="请输入所属部门" errormsg="请输入所属部门" name="department" value="${job.department}" placeholder="请输入" class="input-text" type="text"/>
                        </dd>
                    </dl>
                    <dl>
                        <dt>职业亮点</dt>
                        <dd class="w464">
                            <input name="highlights" maxlength="5" style="width:79px; margin-right: 20px;" placeholder="最多五个字"
                                   class="input-text" type="text" value="${job.highlightList[0]}"/>
                            <input name="highlights" maxlength="5" style="width:79px; margin-right: 20px;" placeholder="最多五个字"
                                   class="input-text" type="text" value="${job.highlightList[1]}"/>
                            <input name="highlights" maxlength="5" style="width:79px; margin-right: 20px;" placeholder="最多五个字"
                                   class="input-text" type="text" value="${job.highlightList[2]}"/>
                            <input name="highlights" maxlength="5" style="width:78px; margin: 0;" placeholder="最多五个字" class="input-text"
                                   type="text" value="${job.highlightList[3]}"/>
                            <input <c:if test="${job.highlightList.size()>0}">value="1"</c:if> class="highlights" type="hidden" datatype="*" nullmsg="请填写至少一个亮点"/>
                        </dd>
                        <dd>
                            <div class="warning-tip"><i class="icon icon-lamp"></i><p>职位亮点将与职位名称一起，直接呈现在求职者的职位搜索结果页面中，丰富、有力的职位亮点对求职者更具吸引力。</p></div>
                        </dd>
                    </dl>
                    <dl>
                        <dt>薪酬范围</dt>
                        <dd class="w464">
                            <div style="float: left;">
                                <div class="count-input">
                                    <input data-top="0" datatype="int" nullmsg="请输入薪资" errormsg="必须大于0的整数" value="${(empty job) ? 1 : job.salaryMin}" name="salary_min" type="text"/>
                                    <div class="nub-tool">
                                        <i class="increase">+</i>
                                        <i class="reduce">-</i>
                                    </div>
                                    <p class="unit">K</p>
                                </div>
                            </div>
                            <span style="line-height: 44px; display:block; float: left; vertical-align: middle; padding: 0px 5px;">至</span>
                            <div style="float: left;">
                                <div class="count-input">
                                    <input data-top="0" datatype="int" nullmsg="请输入薪资" errormsg="必须大于1的整数" value="${(empty job) ? 2 : job.salaryMax}" name="salary_max" type="text"/>
                                    <div class="nub-tool">
                                        <i class="increase">+</i>
                                        <i class="reduce">-</i>
                                    </div>
                                    <p class="unit">K</p>
                                </div>
                            </div>    
                            <label style="margin-left: 5px; display: inline-block; margin-top: 12px;" class="item">
                                <label class="checked-label"><input <c:if test="${job.salaryBasic}">checked="checked"</c:if>  name="salary_basic" type="checkbox"/><i></i></label>
                                                                                            底薪
                            </label>
                        </dd>
                        <dd>
                            <div class="warning-tip"><i class="icon icon-lamp"></i><p>最高月薪不能大于最低月薪的2倍</p></div>
                        </dd>
                    </dl>
                    <dl>
                        <dt>工作地址</dt>
                        <dd class="w464">
                        <div class="address">                                                 
                            <p id="addresses-text">${job.address}</p>
                            <a class="add" id="up-addresses" href="javascript:void(0)">更改地址<span class="arow-b"></span></a>
                            <div class="address-list">
                                <div id="address-tab">
                                <c:forEach items="${addresses}" var="address">
                                    <div class="item">
                                        <label class="item-add">
                                            <label class="radio-label"><input <c:if test="${job.addressId == address.id}">checked="checked"</c:if> value="${address.id}" name="address_id" type="radio"/><i></i></label>
                                            <span class="label">${address.province}/${address.city}/${address.district}/${address.address}</span>
                                        </label>
                                        <a 
                                            data-id="${address.id}"
                                            data-provinceId="${address.provinceId}"
                                            data-cityId = "${address.cityId}"
                                            data-districtId = "${address.districtId}"
                                            data-address = "${address.address}"
                                            data-longitude = "${address.longitude}"
                                            data-latitude = "${address.latitude}"
                                        class="edit" href="javascript:void(0)">编辑</a>
                                    </div>
                                </c:forEach>
                                </div>
                                <div class="blank-1"></div>
                                <a style="margin-left:20px; display: inline-block;" class="add" href="javascript:void(0)">+新增地址</a>
                            </div>
                            <input data-top="0" <c:if test="${addresses.size()>0}">value="1"</c:if> datatype="*" nullmsg="请选择公司地址" errormsg="请选择公司地址" type="hidden" id="company-address"/>
                        </div>
                        </dd>
                    </dl>
                    <dl>
                        <dt></dt>
                        <dd><button type="submit" class="btn enter">发布</button></dd>
                    </dl>
                    </form>
                </div>        
            </div>
        </div>
        <div id="map-modular" class="modal-backdrop">
            <div class="modular-item map-modular">
                <p class="title-modular">公司位置
                <div class="cont">
                    <div class="editbox">
                        <div class="map-tool">
                            <form id="addressForm">
                                <div class="group-btn" style="top: -58px; right: 0;">
                                    <button id="cancel-edit-map" type="button" class="btn cancel">取消</button>
                                    <button type="button" id="save-address" class="btn">保存</button>
                                </div>
                                <input type="hidden" name="id"/>
                                <input type="hidden" name="province_id"/>
                                <input type="hidden" name="city_id"/>
                                <input type="hidden" name="district_id"/>
                                <input type="hidden" name="latitude"/>
                                <input type="hidden" name="longitude"/>
                                <dl>
                                    <dd style="margin-right: 10px;">
                                        <div class="address-box">
                                            <input style="cursor: pointer; width: 365px;" autocomplete="off" readonly="readonly" class="input-text address-text"/>
                                            <span class="arow-b"></span>
                                            <div class="address-list">
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
                                    </dd>
                                    <dd>
                                        <input style="width: 365px;" autocomplete="off" disabled="disabled" name="address" class="input-text"/>
                                    </dd>
                                </dl>
                                <input type="hidden" name="latitude"/>
                                <input type="hidden" name="longitude"/>
                            </form>
                        </div>
                        <div class="blank-1"></div>
                    </div>
                    <div class="map-box" id="allmap">
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        
        <link href="${url.cdn}/static/plugins/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
        <script type="text/javascript" src="${url.cdn}/static/plugins/umeditor/third-party/template.min.js?v=20170908"></script>
        <script type="text/javascript" charset="utf-8" src="${url.cdn}/static/plugins/umeditor/umeditor.config.js"></script>
        <script type="text/javascript" charset="utf-8" src="${url.cdn}/static/plugins/umeditor/umeditor.min.js"></script>
        <script type="text/javascript" src="${url.cdn}/static/plugins/umeditor/lang/zh-cn/zh-cn.js"></script>
        
        <script type="text/javascript" src="//api.map.baidu.com/api?v=2.0&ak=vizCcjf5x8YKTG2DpMoZeBgK4RBifuhp"></script>
        <script type="text/javascript" src="//api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
        <link rel="stylesheet" href="//api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
        <script>
        var um = UM.getEditor('JobEditor',{
            initialFrameWidth :460,
            initialFrameHeight:200,
            zIndex:1
        });
        var jobCategories=[];
        var isPerfect=false;
        <c:if test="${empty job}">
        jobCategories=${jobCategories};
        window.onbeforeunload = function(){
            if(!isPerfect){
                return "确定放弃此次编辑吗";
            }
        }
        </c:if>
        </script>
    </body>
</html>