<%--
  User: xianghuawei
  Date: 2017/6/20
  Time: 16:19
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>企业资质申请 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <style>
    .erro_msg{margin:-30px 0px 20px 10px !important;}
    .audit-cont .form-certified .tip{padding-bottom:20px;}
    .audit-cont .form-certified .tip .icon{color:#00b38a; margin-right: 3px;}
    </style>
    <body>
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="banner"></div>
        <div class="wrap-820 audit-cont">
            <div class="step step3">
                <ul class="step-text">
                    <li class="on">填写联系方式</li>
                    <li class="on">验证公司邮箱</li>
                    <li>填写公司名称</li>
                </ul>
                <div class="progress">
                    <div class="bar"></div>
                </div>
            </div>
            <div style="padding-bottom: 60px;" class="form-certified">
                <form id="info">
                    <input name="company_name" datatype="*" nullmsg="请填与公司营业执照一致的公司名称" placeholder="请填与公司营业执照一致的公司名称" class="input-text"/>
                    <p style="margin-top: -30px;" class="tip"><i class="icon icon-erro"></i>请填与公司营业执照一致的公司名称，审核通过后不可修改</p>
                    <input ignore="ignore" name="website_url" datatype="url" nullmsg="请输入公司官网" errormsg="请输入正确的公司官网" placeholder="请输入公司官网，如 www.baidu.com" class="input-text"/>
                    <p style="margin-top: -30px;" class="tip"><i class="icon icon-erro"></i>若公司官网未上线，可填写已经由第三方认证的公司主页链接，如 淘宝/天猫，企 业微博、企业公众号等(选填)</p>
                    <div class="upload-img">
                        <div style="display: none;" class="preview-box">
                            <img class="preview" id="preview"/>
                        </div>
                        <div class="edit-box">
                            <div class="blank-2"></div>
                            <div class="up-business-box">
                                <div class="add mask-up-wrap">+
                                </div>上传营业执照、
                                <div class="mask-up" id="filePicker" style="left: 160px; right: 160px;"></div>
                            </div>
                            <p class="tip" style="text-align: center; padding-bottom: 0;">支持jpg,jpeg,png,gif,pdf等格式，文件不超过10M</p>
                        </div>
                        <a style="display: none;" id="back-edit" href=" javascript:void(0)" class="min-btn">返回修改</a>
                        <div id="progress-bar" class="progress-bar">
                            <span class="bar">
                            </span>
                        </div>
                    </div>
                    <div class="blank-2"></div>
                    <button id="up-info-btn" disabled="disabled" type="submit" class="btn">下一步</button>
                    <div class="blank-1"></div>
                    <p class="tip">如有任何问题，请致电 :${contacts.phone}<br>或邮件联系我们 ${contacts.email}，我们会尽快为你解决。</p>
                    
                </form>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <script src="//fex.baidu.com/webuploader/js/webuploader.js"></script>
    </body>
</html>