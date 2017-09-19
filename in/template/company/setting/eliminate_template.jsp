<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  User: xianghuawei
  Date: 2017/6/28
  Time: 11:50
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>招聘设置 - 淘汰模板 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body ms-controller="interviewInfo">
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="company-cont wrap-1200">
            <div class="middle-cont">
                <div class="nav-tab">
                    <ul>
                        <li><a href="/companies/setting/profile">个人信息</a></li>
                        <li><a href="/companies/setting/template/interview">面试信息</a></li>
                        <li class="on"><a href="/companies/setting/template/eliminate">淘汰模板</a></li>
                    </ul>
                </div>
                <ul id="list-Tempview" ms-class-show="TempBase.list.length>0" class="temp-list hide">
                    <li ms-repeat-el="TempBase.list">
                        
                        <div class="template-block res" ms-class-show="!el.show">
                            <div class="top-bar">
                                <span ms-text="el.title"></span>
                                <div class="tool-box">
                                    <a ms-click="TempBase.eidtTemp($index)" href="javascript:void(0)"><i class="icon icon-edit"></i>编辑</a>
                                </div>
                            </div>
                            <div class="cont">
                                <p style="color: #666;" ms-text="el.description"></p>
                            </div>
                        </div>
                        <div class="template-block edit" ms-class-show="el.show">
                            <div class="form-template">
                                <div class="form-cont min">
                                    <form>
                                    <input type="hidden" name="id" ms-duplex="TempBase.editList.eliminate_id"/>
                                    <dl>
                                        <dt>原因</dt>
                                        <dd>
                                            <input datatype="*" nullmsg="请输入淘汰原因" errormsg="请输入淘汰原因" name="title" ms-duplex="TempBase.editList.title" class="input-text" type="text"/>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>解释说明</dt>
                                        <dd>
                                            <div class="input-textarea" style="margin-bottom: 10px;">
                                                <textarea datatype="*" nullmsg="请输入解释说明" errormsg="请输入解释说明" maxlength="500" class="count-word-box" name="description" ms-duplex="TempBase.editList.description"></textarea>
                                                <p class="text-nub"><span class="count-word">0</span>/500</p>
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt></dt>
                                        <dd>
                                            <button type="submit" class="btn enter">保 存</button>
                                            <button ms-click="TempBase.eidtTemp($index)" type="button" class="btn cancel">取消</button>
                                        </dd>
                                    </dl>
                                    </form>
                                    <div class="blank-1"></div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>                    
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <script src="${url.cdn}/static/plugins/avalon/avalon.js"></script>
        <script>
        var templateJson = ${templateJson};
        templateJson.forEach(function(el){
            el.show=false;
        })
        </script>
    </body>
</html>