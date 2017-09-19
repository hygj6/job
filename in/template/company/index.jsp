<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${company.name}(${company.abbreviation})的主页 - 外贸帮手网</title>
    <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    <link rel="stylesheet" href="${url.cdn}/static/plugins/select2/select2.min.css"/>
</head>
<style>
    .erro_msg { margin-top: -10px; }
    .modal-dialog .erro_msg { margin: 0 0 -10px; }
    .textarea-wrap .erro_msg { margin-top: 0px; text-align: right;}
    .map-modular{width: initial; margin: 0; padding: 0;}
    .modal-backdrop{background: rgba(0, 0, 0, 0.2);}
    .map-modular .map-tool dd .input-text{width: 350px;}
    .modular-item.editing .address-list-box{display: block !important;}
</style>
<body>
<jsp:include page="/WEB-INF/public/public-home-head.jsp"/>
<div class="main contain-header modular-item" style="padding: 0; overflow: hidden;">
    <div class="wrap">
    <div class="company-info modular-box">
        <div class="company-logo up-avatar-box" style="margin-top:10px;">
            <img style="position: relative; z-index:8;" id="logoView" src="${company.logoUrl}"/>
            <c:if test="${isMyself}">
            <div style="z-index:9;" class="mask-avatar mask-up-wrap">
                <div class="mask">
                    <p><i class="icon"></i></p>
                </div>
                <div id="company-logo" class="mask-up"></div>
            </div>
            </c:if>
            
        </div>
        <div id="update-base-info" style="margin-top:0px;" class="text-info">
            <div class="resbox">
                <form style="display:none;" id="update-base-info-data">
                    <input name="abbreviation" value="${company.abbreviation}"/>
                    <input name="web_url" value='<c:if test="${not empty company.webUrl and !fn:startsWith(company.webUrl, 'http')}">http://</c:if>${company.webUrl}'/>
                    <input name="brief" value="${company.brief}"/>
                </form>
                <h3 style="height: 43px;"><a <c:if test='${not empty company.webUrl}'>href="<c:if test="${!fn:startsWith(company.webUrl, 'http')}">http://</c:if>${company.webUrl}"</c:if> class="vm-abbreviation" rel="nofollow" target="_blank">${company.abbreviation}</a><c:if test='${not empty company.webUrl}'><i class="icon icon-icon_link"></i></c:if></h3>
                <p style="min-height:25px;" class="tip vm-brief">${company.brief}</p>
                <div class="edit-group" style="right: 20px; top: 10px;">
                    <c:if test="${isMyself}">
                        <a class="edit-btn" href="javascript:void(0)"><i class="icon icon-edit"></i>编辑</a>
                    </c:if>
                </div>
            </div>
            <div class="editbox">
                <form id="update-base-info-edit" style="position: relative; padding-top: 28px; padding-left: 20px;">
                    <div style="float: left;">
                    <input value="" datatype="*1-8" nullmsg="请填写公司简称" errormsg="公司简称不得超过8个字符"
                           name="abbreviation" style="width: 310px; margin-right: 5px;" class="input-edit"
                           placeholder="请填写公司简称">
                    </div>
                    <div style="float: left;">
                    <input value="" datatype="url" nullmsg="请填写公司网址"
                           errormsg="请填写正确公司网址" ignore="ignore" name="web_url" style="width: 310px;" class="input-edit"
                           placeholder="请填写公司网址">
                    </div>
                    <input value="" datatype="*" nullmsg="请填写公司简述" errormsg="请填写公司简述"
                           name="brief" style="width:648px;" class="input-edit" placeholder="请填写公司简述">
                    <div class="btn-group" style="text-align: right; position: absolute; top:80px; right:104px;">
                        <button type="submit" class="btn enter">确定</button>
                        <button type="button" class="btn cancel">取消</button>
                    </div>
                </form>
            </div>

            <ul class="list-state">
                <li class="first">
                    <p class="nub">${company.countJob}个</p>
                    <p class="label-state" data-tip="该公司的在招职位数量">招聘职位<i class="icon icon-tip"></i></p>
                </li>
                <li>
                    <p class="nub">
                        <c:choose>
                            <c:when test="${company.resumeProcessingRate < 0}">
                                --
                            </c:when>
                            <c:otherwise>
                                ${company.resumeProcessingRate}%
                            </c:otherwise>
                        </c:choose>
                    <p class="label-state" data-tip="该公司所有职位收到的简历中，在投递后7天内处理完成的简历所占比例">简历及时处理率<i class="icon icon-tip"></i></p>
                </li>
                <li>
                    <p class="nub">
                        <c:if test="${company.resumeProcessingTime.timeType == 'NONE'}">
                            --
                        </c:if>
                        <c:if test="${company.resumeProcessingTime.timeType == 'SECOND'}">
                            1小时
                        </c:if>
                        <c:if test="${company.resumeProcessingTime.timeType == 'MINUTE'}">
                            1小时
                        </c:if>
                        <c:if test="${company.resumeProcessingTime.timeType == 'HOUR'}">
                            ${company.resumeProcessingTime.count}小时
                        </c:if>
                        <c:if test="${company.resumeProcessingTime.timeType == 'DAY'}">
                            ${company.resumeProcessingTime.count}天
                        </c:if>
                    </p>
                    <p class="label-state" data-tip="该公司的所有职位管理者完成简历处理的平均用时">简历处理用时<i class="icon icon-tip"></i></p>
                </li>
                <li>
                    <p class="nub">
                        <c:if test="${empty company.loginTime.dateType}">
                            --
                        </c:if>
                        <c:if test="${company.loginTime.dateType == 'MOMENT'}">
                            刚刚
                        </c:if>
                        <c:if test="${company.loginTime.dateType == 'MINUTE'}">
                            ${company.loginTime.time}分钟前
                        </c:if>
                        <c:if test="${company.loginTime.dateType == 'HOUR'}">
                            ${company.loginTime.time}小时前
                        </c:if>
                        <c:if test="${company.loginTime.dateType == 'YESTERDAY'}">
                            昨天
                        </c:if>
                        <c:if test="${company.loginTime.dateType == 'DAYAGO'}">
                            ${company.loginTime.time}天前
                        </c:if>
                        <c:if test="${company.loginTime.dateType == 'MONTH'}">
                            ${company.loginTime.time}月前
                        </c:if>
                        <c:if test="${company.loginTime.dateType == 'LASTYEAR'}">
                            去年
                        </c:if>
                        <c:if test="${company.loginTime.dateType == 'YEAR'}">
                            ${company.loginTime.time}年前
                        </c:if>
                    </p>
                    <p class="label-state" data-tip="该公司职位管理者最近一次登录时间">企业登录<i class="icon icon-tip"></i></p>
                </li>
            </ul>
        </div>
    </div>
    </div>
</div>
<div class="wrap main">
    <div class="left-cont large-padding" style="padding-bottom: 60px;">
        <div class="nav-tab" style="margin: -20px -40px 0px;">
            <ul>
                <li class="on"><a href="/companies/${company.id}.html">公司主页</a></li>
                <li><a href="/companies/${company.id}/jobs/">招聘职位</a></li>
            </ul>
        </div>
        <div class="company-introduction">
            <div id="product-temp">
                <div style="display: none;" class="modular-item product-item">
                    <form style="display: none;">
                        <input name="pic_url"/>
                        <input name="id"/>
                        <input name="name"/>
                        <input name="product_type_id"/>
                        <input name="url"/>
                        <input name="summary"/>
                    </form>
                    <div class="cont" style="padding-bottom: 30px;">
                        <div class="resbox">
                            <div class="pic-left">
                                <img class="product-img" width="300" height="180" src="${product.picture}"/>
                            </div>
                            <div class="text-right">
                                <h3><a target="_blank" class="vm-name"></a><i class="icon icon-icon_link"></i></h3>
                                <div class="summary-scroll">
                                    <p class="vm-summary"></p>
                                </div>
                            </div>
                            <div class="edit-group">
                                <c:if test="${isMyself}">
                                    <a class="del-btn lock" href="javascript:void(0)">删除</a>
                                    <a class="edit-btn lock" href="javascript:void(0)"><i class="icon icon-edit"></i>编辑</a>
                                </c:if>
                            </div>
                        </div> 
                    </div>
                </div>
            </div>
            <c:if test="${company.products.size()>0||isMyself}">
            <div id="product-list" class="modular-box">
                
                <p class="title-modular anchor">公司产品<c:if test="${isMyself}"><a style="top: 20px;" id="creatProduct" class="add" href="javascript:void(0)"><i class="icon icon-icon_add"></i>添加</a></c:if></p>
                <c:forEach items="${company.products}" var="product">
                    <div class="modular-item product-item">
                        <form style="display: none;">
                            <input name="pic_url" value="${product.picture}"/>
                            <input name="id" value="${product.id}"/>
                            <input name="name" value="${product.name}"/>
                            <input name="product_type_id" value="${product.productTypeId}"/>
                            <input name="url" value="${product.url}"/>
                            <input name="summary" value="${product.summary}"/>
                        </form>
                        <div class="cont">
                            <div class="resbox">
                                <div class="pic-left">
                                    <img class="product-img" width="300" height="180" src="${product.picture}"/>
                                </div>
                                <div class="text-right">
                                    <h3><a target="_blank" class="vm-name" <c:if test="${not empty product.url}">href="${product.url}"</c:if>>${product.name}</a><c:if test="${not empty product.url}"><i class="icon icon-icon_link"></i></c:if></h3>
                                    <div class="summary-scroll">
                                    <p class="vm-summary">${product.summary}</p>
                                    </div>
                                </div>
                                <div class="edit-group">
                                    <c:if test="${isMyself}">
                                        <a class="del-btn lock" href="javascript:void(0)"><i class="icon icon-del"></i>删除</a>
                                        <a class="edit-btn lock" href="javascript:void(0)"><i class="icon icon-edit"></i>编辑</a>
                                    </c:if>
                                </div>
                            </div> 
                        </div>
                    </div>
                </c:forEach>
                <div class="modular-item editing product-item" style="display: none;" id="product-edit-box">
                    <div class="cont">
                        <div class="editbox">
                            <div class="pic-left up-product-img">
                                <img id="productPreviewImg" width="300" height="180"/>
                                <div class="mask-black mask-up-wrap">
                                    <p><i class="icon icon-formAvatar_icon_upload"></i>上传产品图片 小于6MB<br>尺寸：600*360px</p>
                                    <div class="mask-up" id="upload_product"></div>
                                </div>
                            </div>
                            <div class="text-right" style="width: 390px;">
                                <form id="product-edit" class="edit-product">
                                    <input datatype="*" nullmsg="请上传产品图片" type="text" style="display: none;" name="id"/>
                                    <input name="name" datatype="*" nullmsg="请填写产品名称"
                                           class="input-edit" placeholder="产品名称"/>
                                    <input name="url" datatype="url" ignore="ignore" nullmsg="请填写产品网址" errormsg="请填写正确的产品网址" class="input-edit" placeholder="http://..."/>
                                    <div class="textarea-wrap" style="width: 390px; height: 170px; margin-bottom: 10px;">
                                        <textarea maxlength="200" name="summary" datatype="*1-200" nullmsg="请填写产品描述" style="height: 158px;" class="input-edit count-word-box" placeholder="请简短描述该产品定位、产品特点、用户群体等"></textarea>
                                        <p class="nub"><span class="count-word">0</span>/200</p>
                                    </div>
                                    <div class="btn-group" style="text-align: right;">
                                        <button type="button" class="btn cancel lock">取消</button>
                                        <button type="submit" class="btn">保存</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="split-line"></div>
            </c:if>
            <div class="modular-box">
                <div class="modular-item">
                    <p class="title-modular anchor">公司介绍</p>
                    <div class="cont" id="add-avatar-cont">
                        <div class="resbox">
                            <div class="introduce vm-summary">${company.summary}</div>
                            <div class="blank-1"></div>
                            <c:if test="${company.avatars.size()>0||isMyself}">
                            <div class="img-wall">
                                <div class="img-box">
                                    <div id="avatar-group" class="swiper-wrapper">
                                        <c:if test="${company.avatars.size()>0}">
                                            <c:forEach items="${company.avatars}" var="avatar">
                                            <div class="item swiper-slide">
                                                <img src="${avatar.avatarUrl}"/>
                                            </div>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${company.avatars.size()==0}">
                                            <div class="default item swiper-slide">
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="prev arrow"></div>
                                    <div class="next arrow"></div>
                                </div>
                                <div class="pagination">
                                </div>
                            </div>
                            </c:if>
                            <div style="top: -50px;" class="edit-group">
                                <c:if test="${isMyself}">
                                <a class="edit-btn" href="javascript:void(0)"><i class="icon icon-edit"></i>编辑</a>
                                </c:if>
                            </div>
                        </div>
                        <div class="editbox">
                            <form id="company-avatar">
                                <div style="height: 134px;" class="textarea-wrap">
                                    <textarea data-top="5" name="summary" maxlength="1000" datatype="*10-1000" nullmsg="请填写公司介绍" errormsg="公司介绍请在10-1000字之间" class="template-theme2 count-word-box">${fn:replace(company.summary, '<br>', newLineChar)}</textarea>
                                    <p class="nub"><span class="count-word">0</span>/1000</p>
                                </div>
                                <p style="color: #999; line-height: 50px;">最多可上传8张照片，已上传（<span id="avatar-nub">${company.avatars.size()}</span>/8）</p>
                                <div class="up-img-group">
                                    <input type="hidden" name="avatar_ids"/>
                                    <ul id="sortable-img" style="max-height: 386px; overflow: hidden;">
                                        <c:forEach items="${company.avatars}" var="avatar">
                                        <li data-id="${avatar.id}">
                                            <img width="180" height="180" src="${avatar.avatarUrl}"/>
                                            <div class="mask-del del-avatar">
                                                <i class="icon icon-icon_close"></i>
                                            </div>
                                        </li>
                                        </c:forEach>
                                        <li class="disabled mask-up-wrap">
                                            <img id="picview-avatar"/>
                                            <div class="mask-black">
                                                <p>请使用10M以下<br>
                                                png/jpg格式的照片</p>
                                            </div>
                                            <div class="mask-up" id="upload-avatar"></div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="btn-group" style="text-align: right;">
                                    <button type="button" class="btn cancel">取消</button>
                                    <button type="submit" class="btn">保存</button>
                                </div>
                            </form>
                        </div>
                        <div class="blank-2"></div>
                    </div>
                </div>
            </div>
            <div class="split-line"></div>
            <div class="modular-box">
                <div class="modular-item map-modular">
                    <p class="title-modular anchor">公司位置
                        <c:if test="${isMyself}"><a style="top: 20px;" id="add-address" class="add" href="javascript:void(0)"><i class="icon icon-icon_add"></i>添加</a></c:if>
                    </p>
                    <div class="cont">
                        <div class="resbox">
                            <p style="display: none;" id="current-company-addresses" class="company-addresses">
                            <i class="icon icon-location"></i>
                            <span id="company-addresses">
                            <c:forEach items="${company.addresses}" var="addresse" varStatus="status">
                                <c:if test="${status.first}">
                                    ${addresse.province}${addresse.city}${addresse.district}${addresse.address}
                                </c:if>
                            </c:forEach>
                            </span>
                            </p>
                            <div class="blank-1"></div>
                            <div id="current-company-addresses-edit-btn" style="display: none;" class="edit-group">
                                <c:if test="${isMyself}">
                                    <a class="edit-btn" href="javascript:void(0)"><i class="icon icon-edit"></i>编辑</a>
                                </c:if>
                            </div>
                        </div>
                        <div class="editbox">
                            <div class="map-tool">
                                <form id="addressForm">
                                    <div class="group-btn" style="top: -60px; right: 0;">
                                        <button type="button" id="cancel-edit-map" type="button" class="btn cancel">取消</button>
                                        <button type="submit" id="save-address" class="btn">保存</button>
                                    </div>
                                    <!--<button type="button" id="del-address" class="del">删除</button>-->
                                    <div style="display:none;">
                                    <input type="text" name="id"/>
                                    <input type="text" name="province_id"/>
                                    <input type="text" name="city_id"/>
                                    <input type="text" name="district_id"/>
                                    <input type="text" name="latitude"/>
                                    <input type="text" name="longitude"/>
                                    </div>
                                    <dl>
                                        <dd style="margin-right: 10px;">
                                            <div class="address-box">
                                                <input data-top="0" datatype="*" nullmsg="地址不能为空" errormsg="地址不能为空" style="cursor: pointer;" autocomplete="off" readonly="readonly" class="input-text address-text"/>
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
                                            <input data-top="0" datatype="*" nullmsg="地址不能为空" errormsg="地址不能为空" autocomplete="off" disabled="disabled" name="address" class="input-text"/>
                                        </dd>
                                    </dl>
                                </form>
                            </div>
                            <div class="blank-1"></div>
                        </div>
                        <c:choose>
                            <c:when test="${!isMyself}">
                                <c:forEach items="${company.addresses}" var="addresse" varStatus="status">
                                    <c:if test="${status.first}">
                                        <c:if test="${addresse.latitude!='0.0'}">
                                            <div class="map-box" id="allmap">
                                            </div>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="map-box" id="allmap"></div>
                            </c:otherwise>
                        </c:choose>
                        <div <c:if test="${company.addresses.size()<=1}">style="display: none;"</c:if> class="address-list-box">
                            <ul>
                                <c:forEach items="${company.addresses}" var="addresse">
                                <li data-id="${addresse.id}">
                                    <label>
                                        <label class="radio-label">
                                            <input 
                                            data-provinceId="${addresse.provinceId}" 
                                            data-cityId="${addresse.cityId}" 
                                            data-districtId="${addresse.districtId}" 
                                            data-address="${addresse.address}" 
                                            data-latitude="${addresse.latitude}" 
                                            data-longitude="${addresse.longitude}"
                                            value="${addresse.id}" name="radio" type="radio"/><i></i>
                                        </label>
                                        <span>${addresse.province}${addresse.city}${addresse.district}${addresse.address}</span>
                                    </label>
                                    <c:if test="${isMyself}">
                                    <a class="del" href="javascript:void(0)">删除</a>
                                    </c:if>
                                </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="right-cont info-brief">
        <div class="modular-item">
            <p class="title-modular">基本信息</p>
            <div class="base-list" id="update-info-res">
                <ul>
                    <li><i class="icon icon-icon_people"></i><span class="text vm-personnels">${company.personnels}</span></li>
                    <li><i class="icon icon-icon_location"></i><span class="text vm-address">
                    <c:forEach items="${company.addresses}" var="addresse" varStatus="status">
                        <c:if test="${status.first}">
                            ${addresse.province}${addresse.city}${addresse.district}
                        </c:if>
                    </c:forEach>
                    </span></li>
                    <li date="${company.industry.parent.parent.industry}/${company.industry.parent.industry}"><i class="icon icon-icon_industry"></i><span class="text vm-industry">${company.industry.industry}</span></li>
                    <li><i class="icon icon-icon_flatform"></i>
                    <span class="text vm-exhibition">
                    <c:forEach items="${company.exhibitions}" var="exhibition" varStatus="status">${exhibition}<c:if test="${!status.last}">/</c:if></c:forEach>
                    </span>
                    </li>
                </ul>
            </div>
            <div style="top: 20px;" class="edit-group">
                <c:if test="${isMyself}">
                    <a id="update-info-btn" class="edit-btn pop" href="javascript:void(0)"><i class="icon icon-edit"></i>编辑</a>
                </c:if>
            </div>
        </div>
        <div class="blank-2"></div>
        <div class="split-line"></div>
        <div class="modular-item">
            <p class="title-modular">公司标签</p>
            <ul id="tag-list-res" class="tag-list">
                <c:forEach items="${company.tags}" var="tag">
                <li>${tag}</li>
                </c:forEach>
            </ul>
            <div style="top: 20px;" class="edit-group">
                <c:if test="${isMyself}">
                    <a style="top: 20px;" id="edit-tags-btn" class="edit-btn pop" href="javascript:void(0)"><i class="icon icon-edit"></i>编辑</a>
                </c:if>

            </div>
        </div>
        <div class="blank-2"></div>
        <div class="split-line"></div>
        <div id="catalog">
          <div class="catalog">
            <div class="blank-2"></div>
            <div class="company-info-nav">
                <ul>
                    <li class="on">公司产品</li>
                    <li>公司介绍</li>
                    <li>公司位置</li>
                </ul>
            </div>
          </div>
        </div>
    </div>
</div>
<div id="update-info-box" style="display:;" class="modal-backdrop">
    <div class="modal-dialog" style="width: 450px;">
        <div class="modal-header center">
            基本信息
            <i class="icon off"></i>
        </div>
        <div class="modal-cont form-wrap">
            <form id="update-info">
                <div class="form-box">
                    <p style="padding: 0;" class="input-label">公司规模</p>
                    <select name="personnels" class="input-text">
                        <option value="1~20人">1~20人</option>
                        <option value="20~99人">20~99人</option>
                        <option value="100~299人">100~299人</option>
                        <option value="300~499人">300~499人</option>
                        <option value="500~999人">500~999人</option>
                        <option value="1000~4999人">1000~4999人</option>
                        <option value="5000人以上">5000人以上</option>
                    </select>
                    <p class="input-label">行业</p>
                    <input readonly="readonly" placeholder="请选择公司行业" class="input-text industry-name" type="text" value="<c:if test="${company.industry.parent.parent.industry}">${company.industry.parent.parent.industry}/</c:if>${company.industry.parent.industry}/${company.industry.industry}">
                    <input value="${company.industryId}" datatype="*" nullmsg="请选择公司行业" errormsg="请选择公司行业" name="industry_id" type="hidden"/>
                    <p class="input-label">平台</p>
                    <select name="exhibition" multiple="multiple" class="input-text js-platform-tags">
                    <c:forEach items="${company.exhibitions}" var="exhibition">
                    <option value="${exhibition}" data-select2-tag="true">${exhibition}</option>
                    </c:forEach>
                    </select>
                    <p class="tip"><i class="icon-erro icon"></i>回车确认，可以输入多个平台</p>
                </div>
                <div class="modal-foot none-border">
                    <div class="btn-group">
                        <button class="btn cancel">取消</button>
                        <button class="btn">确认修改</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="blank-2"></div>
    </div>
</div>
<div id="edit-tags-box" class="modal-backdrop">
    <div class="modal-dialog" style="width:390px;">
        <div class="modal-header center">
            公司标签
            <i class="icon off"></i>
        </div>
        <div class="modal-cont form-wrap">
            <p style="padding:0;" class="input-label">已选标签(<span class="selected-tag">0</span>/8)</p>
            <div class="tag-list-select">
                <ul id="company-tag-list">
                    <li><i class="del icon-icon_close icon"></i></li>
                </ul>
            </div>
            <div style="border-bottom:1px solid #e4e7ed; padding-top: 10px;"></div>
            <p style="padding:0;" class="input-label">可选标签
                <!--<span class="page-tool">
                        <a href="#">上一页/下一页</a>
                    </span>-->
            </p>
            <div class="tag-list-select">
                <ul id="all-tag-list">
                </ul>
            </div>
        </div>
        <div class="modal-foot">
            <div class="btn-group">
                <button class="btn cancel">取消</button>
                <button id="add-tags" class="btn">保存</button>
            </div>
        </div>
        <div class="blank-1"></div>
    </div>
</div>
<jsp:include page="/WEB-INF/public/public-foot.jsp"/>
<jsp:include page="/WEB-INF/public/public-js.jsp"/>
<link rel="stylesheet" href="${url.cdn}/static/plugins/swiper/idangerous.swiper.css" />
<script src="${url.cdn}/static/plugins/swiper/idangerous.swiper.min.js"></script>
<script src="${url.cdn}/static/plugins/select2/select2.min.js"></script>
<script src="${url.cdn}/static/plugins/webuploader/webuploader.js"></script>
<script type="text/javascript" src="//api.map.baidu.com/api?v=2.0&ak=vizCcjf5x8YKTG2DpMoZeBgK4RBifuhp"></script>
<script type="text/javascript" src="//api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
<link rel="stylesheet" href="//api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css"/>
<script src="//apps.bdimg.com/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
</body>
<script type="text/javascript">
    

var mySwiper = new Swiper('.img-box', {
    pagination :'.pagination',
    paginationClickable :true,
    loop:true,
    onlyExternal : true
});
$('.img-box .prev').on('click', function(e){
    e.preventDefault();
    mySwiper.swipePrev();
});
$('.img-box .next').on('click', function(e){
    e.preventDefault();
    mySwiper.swipeNext();
});
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
            $("#catalog li").eq($index).addClass("on").siblings("li").removeClass("on")
        }
    });  
});
$("#catalog li").click(function(){
    var $index=$(this).index();
    $(".anchor").each(function(index){
        if(index==$index){
            var $t1=$(this).offset().top;
            $("html,body").animate({scrollTop:$t1},400);
        }
    });
});
</script>
</html>