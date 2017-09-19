<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!--[if lt IE 9]>
    <div style="background:#FFFFCC;height: 35px;display:block; line-height: 35px;padding: 0 5px;color: #0066CC;text-align: center;">你当前浏览器版本过低，这将降低电脑安全性，同时可能会影响你浏览网页。我们建议你<a style="color:#ff6f28;" target="_blank" href="https://www.baidu.com/s?wd=chrome">立即升级到最新版</a>，以防止这些情况发生。</div>
<![endif]-->
<div class="top-tool">
    <div class="wrap">
        <a href="/companies/welcome">企业版</a>
        <shiro:guest>
        <div class="user-tool">
            <a href="/login">登录</a>
                <span class="split-line">|</span>
            <a href="/register/nav">注册</a>
        </div>
        </shiro:guest>
        <shiro:user>
        <div class="user-tool">
            <shiro:hasRole name="company">
                <a href="/companies/conversations">消息</a>
                <span class="split-line">|</span>
            </shiro:hasRole>
            <shiro:hasRole name="candidate">
                <a href="/conversations">消息</a>
                <span class="split-line">|</span>
                <a href="/resume/">我的简历</a>
                <span class="split-line">|</span>
                <a href="/resume/delivery/list">投递箱</a>
                <span class="split-line">|</span>
            </shiro:hasRole>
            <div class="item">
                <a href="javascript:void(0)"><shiro:principal property="name"/><span class="arow-b"></span></a>
                <div class="drop-tool">
                    <ul>
                        <shiro:hasRole name="company">
                        <li>
                            <a href="/companies/<shiro:principal property="id"/>.html">公司主页</a>
                        </li>
                        <li>
                            <a href="/companies/welcome">公司后台</a>
                        </li>
                        
                        <li>
                            <a href="/companies/setting/profile">招聘设置</a>
                        </li>
                        </shiro:hasRole>
                        <li>
                            <a href="/user/security">账号设置</a>
                        </li>
                        <li>
                            <a href="/logout">退出</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>            
        </shiro:user>
    </div>
</div>
