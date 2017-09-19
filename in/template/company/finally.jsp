<%--
  User: xianghuawei
  Date: 2017/6/23
  Time: 18:08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>完善资料 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
        <style>
        .audit-cont .form-certified .input-text{margin: 0;}
        .audit-cont .label-input{margin-top:-20px !important;}
        </style>
        <link rel="stylesheet" href="${url.cdn}/static/plugins/select2/select2.min.css" />
    </head>
    <style>
    .erro_msg{margin-bottom: 20px;}
    </style>
    <body>
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="banner"></div>
        <div class="wrap-820 audit-cont">
            <div style="padding-bottom: 60px;" class="form-certified">
                <i class="state-icon icon-yes" style="font-size:26px;"></i>
                <h3 style="text-align: center; padding-top: 10px; font-weight: normal;"><span style="padding-right: 10px; font-size: 20px;">审核通过</span>完善公司信息就可以发布职位啦</h3>
                <div style="padding-bottom: 60px;" class="form-certified">
                    <form id="complete-material">
                        <p style="margin: 0 !important;" class="label-input">公司简称</p>
                        <input autocomplete="off" placeholder="请填写公司简称" datatype="*1-8" nullmsg="请填写公司简称" errormsg="公司简称不得超过8个字符" name="abbreviation" class="input-text"/>
                        <p class="label-input">公司Logo</p>
                        <div class="up-logo" style="padding-bottom: 30px;">
                            <div class="pic">
                                <div class="watermark icon-logo_default"></div>
                                <img id="preview"/>
                            </div>
                            <div class="text">
                                <div class="btn-up mask-up-wrap">+选择Logo
                                    <div class="mask-up" id="up-logo-botton"></div>
                                </div>
                                <p class="img-tip">尺寸180X180像素<br>
                                                                                                支持JPG、PNG格式，不要超过2M</p>
                            </div>
                        </div>
                        <p class="label-input">选择行业</p>
                        <input readonly="readonly" placeholder="请选择公司行业" class="input-text industry-name" type="text">
                        <input datatype="*" nullmsg="请选择公司行业" errormsg="请选择公司行业" name="industry_id" type="hidden"/>
                        

                            
                        <p class="label-input">公司规模</p>
                        <div style="margin-bottom: 30px;">
                        <select name="personnels" class="input-text select-custom">
                            <option value="1~20人">1~20人</option>
                            <option value="20~99人">20~99人</option>
                            <option value="100~299人">100~299人</option>
                            <option value="300~499人">300~499人</option>
                            <option value="500~999人">500~999人</option>
                            <option value="1000~4999人">1000~4999人</option>
                            <option value="5000人以上">5000人以上</option>
                        </select>
                        </div>
                        <p class="label-input">公司展会平台</p>
                        <select multiple="multiple" class="input-text js-platform-tags">
                        </select>
                        <p style="display: none; font-size: 12px; line-height: 30px; color: #666;"><i class="icon-erro icon" style="color:#00b38a; margin-right: 3px;"></i>回车确认，可以输入多个平台</p>
                        <p class="label-input" style="margin-top:10px !important;">公司简介</p>
                        <div style="height: 152px;" class="input-textarea">
                            <textarea maxlength="1000" class="count-word-box" autocomplete="off" placeholder="请填写公司简介" datatype="*10-1000" nullmsg="请填写公司简介" errormsg="简介必须在10到1000字符之间" name="summary" style="width: 438px; border: 1px solid #e4e7ea;"></textarea>
                            <p class="text-nub"><span class="count-word">0</span>/1000</p>
                        </div>
                        <button id="up-btn" disabled="disabled" class="btn">提交</button>
                        <div class="blank-1"></div>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <script src="${url.cdn}/static/plugins/select2/select2.min.js"></script>
        <script src="${url.cdn}/static/plugins/webuploader/webuploader.js"></script>
        <script>
        $("body").on("focus",".select2-selection",function(){
            var wrap=$(this).parents(".select2-container");
            wrap.next("p:eq(0)").show();
        });
        $("body").on("blur",".select2-selection",function(){
            var wrap=$(this).parents(".select2-container");
            wrap.next("p:eq(0)").hide();
        });
        </script>
    </body>
</html>