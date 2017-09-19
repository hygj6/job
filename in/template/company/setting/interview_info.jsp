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
        <title>招聘设置 - 面试模板 - 外贸帮手网</title>
        <jsp:include page="/WEB-INF/public/public-icon.jsp"/>
    </head>
    <body ms-controller="interviewInfo">
        <jsp:include page="/WEB-INF/public/public-company-head.jsp"/>
        <div class="company-cont wrap-1200">
            <div class="middle-cont">
                <div class="nav-tab">
                    <ul>
                        <li><a href="/companies/setting/profile">个人信息</a></li>
                        <li class="on"><a href="/companies/setting/template/interview">面试信息</a></li>
                        <li><a href="/companies/setting/template/eliminate">淘汰模板</a></li>
                    </ul>
                    <div class="tool-group">
                        <a ms-click="interviewBase.createTemp()" href="javascript:void(0)">新增面试模板</a>
                    </div>
                </div>
                <ul id="list-interview" class="temp-list hide" ms-class-show="interviewBase.list.length>0">
                    <li ms-repeat-el="interviewBase.list" ms-class-selected="el.selected">
                        <div class="template-block res" ms-class-show="!el.show">
                            <div class="top-bar">
                                <span ms-text="el.name"></span>
                                <div class="tool-box">
                                    <a ms-if="!el.selected" ms-click="interviewBase.setDefault($index)" href="javascript:void(0)">设为默认</a>
                                    <a ms-click="interviewBase.eidtTemp($index)" href="javascript:void(0)"><i class="icon icon-edit"></i>编辑</a>
                                    <a ms-if="interviewBase.list.length>1&&!el.selected" ms-click="interviewBase.delTemp($index)" href=" javascript:void(0)"><i class="icon icon-del"></i>删除</a>
                                </div>
                            </div>
                            <div class="cont">
                                <p><strong>联系人：</strong><span ms-text="el.contact_name"></span></p>
                                <p><strong>面试地点：</strong><span ms-text="el.company_address"></span></p>
                                <p><strong>联系电话：</strong><span ms-text="el.contact_phone"></span></p>
                            </div>
                        </div>
                        <div class="template-block edit" ms-class-show="el.show">
                            <div class="form-template">
                                <div class="form-cont min">
                                    <form>
                                        <input type="hidden" ms-duplex="interviewBase.editList.id" name="id"/>
                                        <dl>
                                            <dt>模板名</dt>
                                            <dd>
                                                <input name="name" datatype="*" nullmsg="请填写模板名称" errormsg="请填写模板名称" ms-duplex="interviewBase.editList.name" class="input-text" type="text"/>
                                            </dd>
                                        </dl>
                                        <dl>
                                            <dt>称呼</dt>
                                            <dd>
                                                <input name="contact_name" datatype="*" nullmsg="请填写您的称呼" errormsg="请填写您的称呼" ms-duplex="interviewBase.editList.contact_name" class="input-text" type="text"/>
                                            </dd>
                                        </dl>
                                        <dl>
                                            <dt>面试地点</dt>
                                            <dd>
                                                <input name="company_address" datatype="*" nullmsg="请填写面试地点" errormsg="请填写面试地点" ms-duplex="interviewBase.editList.company_address" class="input-text" type="text"/>
                                            </dd>
                                        </dl>
                                        <dl>
                                            <dt>手机</dt>
                                            <dd>
                                                <input name="contact_phone" datatype="m" nullmsg="请填写您的手机号" errormsg="请填写正确手机号" ms-duplex="interviewBase.editList.contact_phone" class="input-text" type="text"/>
                                            </dd>
                                        </dl>
                                        <dl>
                                            <dt></dt>
                                            <dd>
                                                <button type="submit" class="btn enter">保 存</button>
                                                <button type="button" ms-click="interviewBase.eidtTemp($index)" class="btn cancel">取消</button>
                                            </dd>
                                        </dl>
                                    </form>
                                    <div class="blank-1"></div>
                                </div>
                            </div>
                        </div>
                        <div ms-if="el.selected" class="default-sig">
                            <i class="icon icon-default-sig"></i>
                        </div>
                    </li>
                </ul>
                <div ms-class-show="interviewBase.list.length==0" class="hide" ms-if="interviewBase.list.length==0">
                    <jsp:include page="/WEB-INF/public/public-unusual-state.jsp" flush="true">
                        <jsp:param name="top" value="100px"/>
                        <jsp:param name="msg" value="当前没有面试模板"/>
                        <jsp:param name="btnUrl" value="javascript:window.model.interviewBase.createTemp()"/>
                        <jsp:param name="btnLabel" value="新增模板"/>
                    </jsp:include>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/public/public-foot.jsp"/>
        <jsp:include page="/WEB-INF/public/public-js.jsp"/>
        <script src="${url.cdn}/static/plugins/avalon/avalon.js"></script>
        <script>
        var interviewInfoJson = ${interviewInfoJson};
        interviewInfoJson.forEach(function(el){
            el.show=false;
        })
        </script>
    </body>
</html>