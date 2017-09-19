<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>账号安全 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <style>
    .nav-tab-thme li{width: 16.66%;}
    .erro_msg{margin-top: 0px; margin-bottom: -20px;}
    .total-erro{padding-left: 20px; margin-bottom: -20px;}
    .form-wrap .input-label a{font-size: 12px; color:#00b38a;}
    .form-wrap .input-label a:hover{text-decoration: underline;}
    </style>
    <body>
        <jsp:include page="/WEB-INF/public/public-home-head.jsp"/>
        <div class="wrap main" style="padding-top: 60px;">
            <div class="box-bind">
                <div class="other-bind-tab">
                    <ul id="tab-menu">
                        <!--<li><a href="#binding">第三方绑定</a></li>-->
                        <li class="on"><a>账号安全</a></li>
                    </ul>
                </div>
                <div id="tab-cont" style="float: left;">
                    <!--<div class="other-bind-cont">
                        <h3>第三方账户绑定</h3>
                        <div class="blank-2"></div>
                        <ul class="other-list">
                            <li><i class="icon icon-wechat on"></i><a href="#">绑定微信账号</a></li>
                            <li><i class="icon icon-qq on"></i>已绑定QQ账号：会飞的鱼<a class="btn" href="#">解除绑定</a></li>
                            <li><i class="icon icon-sina on"></i>已绑定新浪账号：会飞的鱼<a class="btn" href="#">解除绑定</a></li>
                        </ul>
                    </div>-->
                    <div class="other-bind-cont" style="display: block;">
                        <h3>账号安全设置</h3>
                        <div class="blank-2"></div>
                        <ul class="tool-list">
                            <li>
                                <i class="icon icon-icon_password"></i>
                                <p class="label">登录密码</p>
                                <p>用户保护账号信息和登录安全</p>
                                <a class="btn" id="update-password-btn" href="javascript:void(0)">修改密码</a>
                            </li>
                            <li>
                                <i class="icon icon-icon_email" style="font-size: 12px;"></i>
                                <p class="label">
                                                                                                安全邮箱
                                </p>
                                <p>仅用于账号登录，和招聘无关</p>
                                <a class="btn" id="update-email-btn" href="javascript:void(0)" data-email="<shiro:principal property="email"/>">修改邮箱</a>
                            </li>
                            <li>
                                <i class="icon icon-icon_mobile2">
                                    <span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>
                                </i>
                                <p class="label">安全手机</p>
                                <p>用于登录，重置密码或其他安全验证</p>
                                <a class="btn" id="update-phone-btn" href="javascript:void(0)" data-phone="<shiro:principal property="phone"/>">修改手机</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-backdrop">
            <div class="modal-dialog">
                <div class="modal-header">
                                                确认解绑
                <i class="icon off"></i>    
                </div>
                <div class="modal-cont">
                    <p class="msg-cont">解除绑定后，你将无法继续使用QQ账户登录外贸帮手网</p>
                </div>
                <div class="modal-foot">
                    <div class="btn-group">
                        <button class="btn cancel">取消</button>
                        <button class="btn">解绑</button>
                    </div>
                </div>
            </div>
        </div>
        <!--修改密码-->
        <div id="update-password-box" class="modal-backdrop">
            <div class="modal-dialog" style="width: 350px;">
                <div class="modal-header center">
                                                修改密码
                <i class="icon off"></i>    
                </div>
                <form>
                <div class="modal-cont form-wrap">
                    <div class="form-box">
                        <p class="input-label">现有密码</p>
                        <input name="old_password" datatype="*6-20" nullmsg="请输入密码" errormsg="密码必须6到20位字符" placeholder="请输入新密码" placeholder="请输入现有密码" class="input-text" type="password"/>
                        <p class="input-label">新密码</p>
                        <input name="new_password" datatype="*6-20" nullmsg="请输入密码" errormsg="密码必须6到20位字符" placeholder="请输入新密码" placeholder="请输入新密码" class="input-text" type="password"/>
                        <p class="input-label">确认新密码</p>
                        <input name="re-password" recheck="new_password" datatype="*" nullmsg="请再次输入密码" errormsg="两次密码不一致" placeholder="请再次输入新密码" placeholder="请再次输入新密码" class="input-text" type="password"/>
                    </div>
                </div>
                <div class="modal-foot none-border">
                    <div class="btn-group">
                        <button type="button" class="btn cancel">取消</button>
                        <button type="submit" class="btn">修改</button>
                    </div>
                </div>
                </form>
                <div class="blank-2"></div>
            </div>
        </div>
        <!--修改密码成功-->
        <div id="update-password-success-box" class="modal-backdrop">
            <div class="modal-dialog" style="width: 410px;">
                <div class="modal-cont form-wrap">
                    <div class="form-box">
                        <div class="blank-2"></div>
                        <p class="tip-label-max">密码修改成功</p>
                        <p class="tip-label">你需要用新密码重新登录，系统将在<span class="nub">10</span>秒后跳转至登录页</p>
                        <button class="btn center">重新登录</button>
                    </div>
                </div>
            </div>
        </div>
        <!--修改手机发送验证码-->
        <div id="update-phone" class="modal-backdrop">
            <div class="modal-dialog" style="width: 350px;">
                <div class="modal-header center">
                                                修改手机
                <i class="icon off"></i>    
                </div>
                <form>
                <div class="modal-cont form-wrap">
                    <div class="form-box">
                        <div class="blank-1"></div>
                        <p class="tip-label">我们将会向你的原始手机 <shiro:principal property="phone"/><br>发送验证码，已验证所有权</p>
                        <div class="blank-1"></div>
                        <dl class="group-input">
                           <dd style="width: 205px;">
                               <input datatype="*6-6" nullmsg="请输入短信验证码" errormsg="短信验证码必须6位"  name="code" style="width: 183px; border-radius: 3px 0px 0px 3px;" placeholder="请输入短信验证码" class="input-text verification-code" type="text"/>
                           </dd>
                           <dd style="width: 105px;" class="code">
                               <button id="get-validation" type="button" class="get-validation">获取验证码</button>
                           </dd>
                       </dl>
                    </div>
                </div>
                <div class="modal-foot none-border">
                    <div class="btn-group">
                        <button type="button" class="btn cancel">取消</button>
                        <button type="submit" class="btn">下一步</button>
                    </div>
                </div>
                </form>
                <div class="blank-2"></div>
            </div>
        </div>
        <!--新手机-->
        <div id="update-phone2" class="modal-backdrop">
            <div class="modal-dialog" style="width: 350px;">
                <div class="modal-header center">
                                                修改手机
                <i class="icon off"></i>    
                </div>
                <form>
                <input name="token" type="hidden"/>
                <div class="modal-cont form-wrap">
                    <div class="form-box">
                        <p class="input-label">新手机号码</p>
                        <input datatype="m" nullmsg="请输入新手机号" errormsg="请输入新手机号" name="phone" placeholder="请输入新手机号" class="input-text" type="text"/>
                        <p class="input-label">图形验证码</p>
                        <dl class="group-input">
                           <dd style="width:205px;">
                               <input datatype="*" nullmsg="请输入图形验证码" errormsg="请输入图形验证码" name="image_code" style="width: 183px; border-radius: 3px 0px 0px 3px;" placeholder="请证明你不是机器人" class="input-text" type="text"/>
                           </dd>
                           <dd style="width: 105px;" class="code"><img class="captcha" width="105" height="40" src="/user/security/phone/captcha?t=<%=Math.random()%>"/></dd>
                       </dl>
                       <p class="input-label">短信验证码</p>
                       <dl class="group-input">
                           <dd style="width: 205px;">
                               <input datatype="*" nullmsg="请输入短信验证码" errormsg="请输入短信验证码" name="phone_code" style="width: 183px; border-radius: 3px 0px 0px 3px;" placeholder="短信验证码" class="input-text verification-code" type="text"/>
                           </dd>
                           <dd style="width: 105px;" class="code">
                               <button type="button" id="get-validation2" class="get-validation">获取验证码</button>
                           </dd>
                       </dl>
                    </div>
                </div>
                <div class="modal-foot none-border">
                    <div class="btn-group">
                        <button type="button" class="btn cancel">取消</button>
                        <button type="submit" class="btn">确认修改</button>
                    </div>
                </div>
                </form>
                <div class="blank-2"></div>
            </div>
        </div>
        <!--修改手机成功-->
        <div id="update-phone-success-box" class="modal-backdrop">
            <div class="modal-dialog" style="width: 410px;">
                <div class="modal-cont form-wrap">
                    <div class="form-box">
                        <div class="blank-2"></div>
                        <p class="tip-label-max">手机修改成功</p>
                        <p class="tip-label center">原手机不能用作登录，请切记</p>
                        <button class="btn center">知道了</button>
                    </div>
                </div>
            </div>
        </div>
        <!--安全验证-->
        <div id="security-validation" class="modal-backdrop">
            <div class="modal-dialog" style="width: 350px;">
                <div class="modal-header center">安全验证<i class="icon off"></i>    
                </div>
                <form>
                <input type="hidden" name="edit-type"/>
                <div class="modal-cont form-wrap">
                    <div class="form-box">
                        <div class="blank-1"></div>
                        <ul id="update-mail-tab" class="update-mail-phome-tab">
                            <c:if test="${not empty phone}">
                            <li>
                                <label>
                                    <input checked="checked" class="tab-input" type="radio" name="type" value="1"/><strong>手机验证: </strong><shiro:principal property="phone"/>
                                </label>
                            </li>
                            </c:if>
                            <c:if test="${not empty email}">
                            <li>
                                <label>
                                    <input class="tab-input" type="radio" name="type" value="2"/><strong>邮箱验证: </strong><shiro:principal property="email"/>
                                </label>
                            </li>
                            </c:if>
                            <li style="display: none;">
                                <div id="update-mail-cont" class="update-mail-phome-cont">
                                    <p style="display: none;" class="tip-label mail-label">我们将会向你的原始邮箱发送邮件</p>
                                    <p style="display: none;" class="tip-label phone-label">我们将会向你的原始手机发送短信</p>
                                    <div class="blank-1"></div>
                                    <dl class="group-input">
                                       <dd style="width:185px;">
                                           <input datatype="*" nullmsg="请输入验证码" errormsg="请输入验证码" name="code" style="width: 164px; border-radius: 3px 0px 0px 3px;" placeholder="请输入验证码" class="input-text verification-code" type="text"/>
                                       </dd>
                                       <dd style="width: 105px;" class="code">
                                           <button id="get-email-validation" type="button" class="get-validation">获取验证码</button>
                                       </dd>
                                    </dl>
                                </div>
                            </li>
                        </ul>                        
                    </div>
                </div>
                <div class="modal-foot none-border">
                    <div class="btn-group">
                        <button type="button" class="btn cancel">取消</button>
                        <button type="submit" class="btn">下一步</button>
                    </div>
                </div>
                </form>
                <div class="blank-2"></div>
            </div>
        </div>
        <!--创建邮箱绑定-->
        <div id="create-email" class="modal-backdrop">
            <div class="modal-dialog" style="width: 350px;">
                <div class="modal-header center">
                                                绑定邮箱
                <i class="icon off"></i>    
                </div>
                <form>
                <input type="hidden" name="token"/>
                <div class="modal-cont form-wrap">
                    <div class="form-box">
                        <p class="input-label">邮箱</p>
                        <input name="email" datatype="e" nullmsg="请输入要绑定邮箱" errormsg="请输入正确的邮箱" placeholder="请输入要绑定邮箱验" class="input-text" type="text"/>
                        <p class="input-label">验证码</p>
                        <dl class="group-input">
                           <dd style="width: 205px;"><input name="code" style="width: 183px; border-radius: 3px 0px 0px 3px;" datatype="*6-6" nullmsg="请输入邮箱验证码" errormsg="邮箱验证码必须为6位" placeholder="请输入邮箱验证码" class="input-text verification-code" type="text"/></dd>
                           <dd style="width: 105px;" class="code">
                               <button id="get-email-validation2" type="button" class="get-validation">获取验证码</button>
                           </dd>
                       </dl>
                    </div>
                </div>
                <div class="modal-foot none-border">
                    <div class="btn-group">
                        <button type="button" class="btn cancel">取消</button>
                        <button type="submit" class="btn">确认绑定</button>
                    </div>
                </div>
                </form>
                <div class="blank-2"></div>
            </div>
        </div>
        <!--修改邮箱成功-->
        <div id="update-email-success-box" class="modal-backdrop">
            <div class="modal-dialog" style="width: 410px;">
                <div class="modal-cont form-wrap">
                    <div class="form-box">
                        <div class="blank-2"></div>
                        <p class="tip-label-max">邮箱修改成功</p>
                        <p class="tip-label center">新邮箱将可以用于账户登录</p>
                        <button class="btn center">知道了</button>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
    </body>
</html>

