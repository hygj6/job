window.BaiDuMap=(function(){
    try{
        function G(id) {
            return document.getElementById(id);
        }
        var map = new BMap.Map('allmap');
        var poi = new BMap.Point(0,0);
        map.centerAndZoom(poi,13);
        function addPoint(latitude,longitude){
            map.clearOverlays();
            var poi = new BMap.Point(longitude,latitude);
            map.centerAndZoom(poi,16);
            var marker=new BMap.Marker(poi);
            map.addOverlay(marker);   
        }
        
        map.enableScrollWheelZoom();
        var ac = new BMap.Autocomplete({
            "location" : map
        });
        var local = new BMap.LocalSearch(map, {
            onSearchComplete: function(results){
              map.clearOverlays();
              if(results.getCurrentNumPois()>0){  
                var poi=results.vr[0].point;
                map.centerAndZoom(poi,16);
                var marker=new BMap.Marker(poi);
                $(".map-modular input[name='longitude']").val(marker.point.lng);
                map.addOverlay(marker);    
              }else{
                  $(".map-modular input[name='longitude']").val("");
                  $(".map-modular input[name='latitude']").val("");
              }
            },
            pageCapacity:10
        });
        
        
        function search(key){
            local.search(key, map.getBounds());
        }
        //ip地位城市
        function myFun(result){
            var cityName = result.name;
            map.setCenter(cityName);
        }
        function init(){
            map.clearOverlays();
            var myCity = new BMap.LocalCity();
            myCity.get(myFun);
            map.centerAndZoom(poi,13);
        }
        //ip地位城市
        return{
            init:init,
            search:search,
            addPoint:addPoint
        }
    }catch(e){
        //TODO handle the exception
    }
})()
window.isSupportWebkitTransform=function(){
    return document.body.style.webkitTransform!=undefined;
}
window.isIE=function(){
    if(!!window.ActiveXObject || "ActiveXObject" in window){
        return true;
    }else{
        return false;
    }
}
window.encodeTextAreaString= function(str) {
    var reg1 = new RegExp("<","g");
    str = str.replace(reg1, "&lt;");
    var reg2 = new RegExp(">","g");
    str = str.replace(reg2, "&gt;");
    
    var reg = new RegExp("\n", "g");
    str = str.replace(reg, "<br>");
    return str;
}
window.decodeTextAreaString= function(str) {
    var reg = new RegExp("<br>", "g");
    str = str.replace(reg, "\n");
    var reg1 = new RegExp("<BR>", "g");
    str = str.replace(reg1, "\n");
    return str;
}
window.set_cookie=function( cookie_name, cookie_value, lifespan_in_days, valid_domain )
{//设置cook------------------------------------------------------------------------
  var domain_string = valid_domain ? ("; domain=" + valid_domain) : '' ;
  document.cookie = cookie_name + "=" + cookie_value +
      "; max-age=" + 60 * 60 * 24 * lifespan_in_days +
      "; path=/" + domain_string ;
}

window.get_cookie=function( name )
{//获取cook------------------------------------------------------------------------
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

window.QueryCity=function(id){
    if(window.cities){
        var province=window.cities;
        for(let i=0;i<province.length;i++){
            var city=window.cities[i].children;
            if(id==window.cities[i].id){
                return (window.cities[i].name)
            }
            for(let k=0;k<city.length;k++){
                var district=city[k].children;
                if(id==city[k].id){
                    return (city[k].name)
                }
                for(let m=0;m<district.length;m++){
                    if(id==district[m].id){
                        return (district[m].name)
                    }  
                }   
            }
            
        }
    }
}
window.UnusualState=function({
    obj="",
    top="0px",
    msg="",
    btnUrl="",
    btnLabel=""
}){
    var btn=""
    if(btnUrl!=""&&btnLabel!=""){
        btn=`<a class="btn" href="${btnUrl}">${btnLabel}</a>`
    }
    var html=`<div class="unusual-box" style="padding-bottom: 100px; padding-top:${top};">
                <div class="state-icon"></div>
                <p>${msg}</p>${btn}</div>`
    $(obj).html(html)
}
window.LocationSearch=function(str){
    var strList=[];
    if(str.split(",")){
        strList=str.split(",")
    }else{
        strList.push(str)
    }
    var searchKey=window.location.search;
    var $searchKey=[];
    if(searchKey!=""){
        $searchKey=searchKey.split("&")
    }
    var $Keylist="";
    for(let i=0;i<$searchKey.length;i++){
        if($searchKey[i]&&$searchKey[i]!=""&&$searchKey[i].indexOf("page")<0&&$searchKey[i].indexOf("url")<0){
            var isInclude=false;
            for(let k=0;k<strList.length;k++){
                if($searchKey[i].indexOf(strList[k])>=0){
                    isInclude=true
                }
            }    
            if(!isInclude){
                $Keylist+=$searchKey[i]+"&";
            }
        }
    }
    if($Keylist==""){
        return "?";
    }else{
        if($Keylist[0]!="?"){
            $Keylist="?"+$Keylist
        }
        return $Keylist;
    }
}
window.getQueryString=function(name) {//获取URL参数
    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    }
    return null;
}
//投递简历
window.CreateResumeDelivery=(function(){
    var $SuccessDelivery=function(){}
    var $job_id;
    var $url;
    function SubmitResume({
        data={},
        curform=""
    }){
        for(var item in data){
            SubmitData[item]=data[item]
        }
        var $curform=curform;
        var ResumeUser="";
        $public.postJson({
            url:$url,
            data:SubmitData,
            successFn:function(data){
                $SuccessDelivery(data);
            },
            erroFn:function(code,data){
                var msg="";
                switch (code){
                    case "ChooseDelivery":
                        msg="选择投递方式异常"
                        $public.showDialog($("#ChooseDeliveryBox"));
                        ResumeUser=data.name
                        $("#ChooseDeliveryBox .user").text(ResumeUser)
                        if(data.is_upload){
                            $("#ChooseDeliveryBox [name='delivery_way']:last").prop("disabled",false)
                            $("#ChooseDeliveryBox .annex-state").hide()
                        }else{
                            $("#ChooseDeliveryBox [name='delivery_way']:last").prop("disabled",true)
                            $("#ChooseDeliveryBox .annex-state").show()
                        }
                        $public.upLoadFile({
                            url:"/resume/attachment/upload.json",
                            btn:"#upload_resume",
                            successFn:function(data){
                                $("#ChooseDeliveryBox [name='delivery_way']:last").prop("disabled",false)
                                $("#ChooseDeliveryBox .annex-state").hide()
                                $("#ChooseDeliveryBox .file-doc").text(ResumeUser+"的简历")
                            }
                        })
                        break;
                    case "IncompleteResume":
                        msg="不完整的简历"
                        var $form=$("#IncompleteResumeBox form");
                        $("[name='email']",$form).val(data.email);
                        $("[name='experience']",$form).val(data.experience_id);
                        $("[name='education']",$form).val(data.education_id);
                        $("[name='name']",$form).val(data.name);
                        $("[name='phone']",$form).val(data.phone);
                        $("input.province_id",$form).val(data.city_parent_id);
                        $("input.city_id",$form).val(data.city_id);
                        $public.SetAddressSelect({
                            obj:$("#address"),
                            province_id:data.city_parent_id,
                            city_id:data.city_id
                        })
                        $public.showDialog($("#IncompleteResumeBox"));
                        break;
                    case "IncompatibleExpect":
                        var stateList=[]
                        if(data.city){
                            stateList.push("期望城市")
                        }
                        if(data.education){
                            stateList.push("学历")
                        }
                        if(data.experience){
                            stateList.push("工作经验")
                        }
                        var state=stateList.toString().replace(/,/g,"、");
                        $("#IncompatibleExpectBox .match-state").text(state)
                        $public.showDialog($("#IncompatibleExpectBox"));
                        msg="预期不匹配"
                        break;
                    case "DuplicateDelivery":
                        $public.showDialog($("#DuplicateDeliveryBox"));
                        msg="重复投递"
                        $("#DuplicateDeliveryBox .btn").click(function(){
                            $public.offDialog();
                        })
                        break;
                    //重复投递
                    case "JobNotFound":
                        msg="岗位不存在"
                        break;
                    default:
                        msg="未知错误"
                        break;
                }
            },
            alwaysFn:function($curform){
                if(curform){
                    $("button[type='submit']",curform).prop("disabled",false);
                }
            }
        })
    }
    function Init(){
        $public.Validform({
            obj:$("#ChooseDeliveryBox form"),
            fn:function(curform){
                var data=$public.getFormData(curform);
                data["job_id"]=$job_id;
                if(data.default_choice=="on"){
                    data.default_choice=true;
                }else{
                    data.default_choice=false;
                }
                SubmitResume({
                    url:$url,
                    data:data,
                    curform:curform
                }); 
            }
        })
        $public.Validform({
            obj:$("#IncompatibleExpectBox form"),
            fn:function(curform){
                var data=$public.getFormData(curform);
                data["job_id"]=$job_id;
                SubmitResume({
                    url:$url,
                    data:data,
                    curform:curform
                }); 
            }
        })
        $public.Validform({
            obj:$("#IncompleteResumeBox form"),
            fn:function(curform){
                var $data=$public.getFormData(curform);       
                $data["job_id"]=$job_id;
                var education=$data["education"];
                $data["education"]={
                    id:education
                }
                var experience=$data["experience"];
                $data["experience"]={
                    id:experience
                }
                var expect_city=$data["expect_city"];
                $data["expect_city"]={
                    id:expect_city
                }
                var data={}
                data["resume"]=$data
                SubmitResume({
                    url:$url,
                    data:data,
                    curform:curform
                }); 
            }
        })
        $public.addressSelect({
            obj:$("#address")
        })
    }
    function BaseSet({
        job_id="",
        url="",
        SuccessDelivery=null
    }){
        if(job_id!=""){
            $job_id=job_id;
        }
        if(url!=""){
            $url=url;
        }
        if(SuccessDelivery){
            $SuccessDelivery=SuccessDelivery
        }
    }
    
    return{
        Init:Init,
        SubmitResume:SubmitResume,
        BaseSet:BaseSet
    }
})()
//投递简历



window.$public=(function(){
    Array.prototype.delete=function(delIndex){
        var temArray=[];
        for(var i=0;i<this.length;i++){
            if(i!=delIndex){
                temArray.push(this[i]);
            }
        }
        return temArray;
    }
    
    var baseSelect2=function(obj){
        try{
            $(".js-platform-tags",obj).select2({
                tags: true,
                language: {
                    noResults: function () {
                        return "请创建公司的展会平台";
                    },
                    searching: function () {
                        return "正在人肉..";
                    },
                    loadingMore: function () {
                        return "加载更多结果";
                    }
                }
            })
            var list=$(".js-platform-tags option",obj).map(function(){
                return $(this).text()
            }).get();
            $(".js-platform-tags",obj).val(list).trigger('change')
        }catch(e){
            //TODO handle the exception
        }
    }
    baseSelect2("body")
    var $offDialog=function(){
        $(".modal-backdrop").hide();
        $("body").removeClass("lock")
        $(".modal-backdrop .off,.modal-backdrop .btn.cancel").click(function(){
            $offDialog();
        })
    }
    var $showDialog=function(obj,fn){
        $offDialog();
        $(obj).show();
        if($(document).height()>$(window).height()){
            $("body").addClass("lock")
        }
        baseSelect2(obj)
        if(fn){
            fn();
        }
    }
    var $confirm=function({
        title="",
        msg="",
        fn=function(){},
        sure="确定",
        cancel="取消"
    }){
        $("#confirmbox").remove()
        var html=`<div id="confirmbox" class="modal-backdrop">
                <div class="modal-dialog" style="width: 350px;">
                    <div class="modal-header">
                    ${title}
                    <i class="icon off"></i>    
                    </div>
                    <div class="modal-cont form-wrap">${msg}</div>
                    <div class="modal-foot">
                        <div class="btn-group" style="text-align: right;">
                            <button type="button" class="btn cancel">${cancel}</button>
                            <button type="submit" class="btn sure">${sure}</button>
                        </div>
                    </div>
                    <div class="blank-2"></div>
                </div>
            </div>`
        $("body").append(html)
        $showDialog("#confirmbox");
        $("#confirmbox .off,#confirmbox .btn.cancel").click(function(){
            $offDialog()
        })
        $("#confirmbox .btn.sure").click(function(){
            fn()
            $offDialog()
        })
    }
    var $tip=function(msg){
        $("#tip-bar-pop").remove();
        var html=`<div id="tip-bar-pop" class="tip-bar-pop">${msg}</div>`
        $("body").append(html)
        var item=$("#tip-bar-pop")
        var h=item.height();
        var w=item.width();
        item.css({
            "margin-left":-w/2
        })
        setTimeout(function(){
            item.fadeOut()
        },500)
    }
    $(".modal-backdrop .off,.modal-backdrop .btn.cancel").click(function(){
        $offDialog();
    })
    
    
    function addressSelect({
        obj="",
    }){
        $(obj).click(function(e){
            e.stopPropagation()
            $(".address-list",this).toggle()
        })
        function InitAddressSelect(data){
            window.cities=data;                
            var provincehtml=""//省HTML
            var provinceIndex=0;//省索引
            var cityIndex=0;//城市索引
            var provinceName="";//省中文
            var cityName="";//城市中文
            var province_id=0;//省id
            var city_id=0;//城市id
            function addressInit(){
                $("input.province_id",obj).val(province_id)
                $("input.city_id",obj).val(city_id)
            }
            for(let i=0;i<data.length;i++){
                provincehtml+=`<li data-id="${data[i].id}">${data[i].name}</li>`
            }
            $(".address-list .province ul",obj).html(provincehtml);
            $(".address-list .province ul li",obj).bind("click _click",function(e){
                e.stopPropagation()
                provinceName=$(this).text()
                city_id=""
                province_id=$(this).attr("data-id")
                addressInit();
                $(this).siblings(".on").removeClass("on")
                $(this).addClass("on")
                provinceIndex=$(this).index()
                let children=data[provinceIndex].children;
                var cityhtml=""
                for(let k=0;k<children.length;k++){
                    cityhtml+=`<div data-id="${children[k].id}" class="item-city"><span class="text">${children[k].name}</span></div>`
                }
                $(".address-list .city-list",obj).html(cityhtml)
                $(".address-box input.input-text",obj).val("");
                $(".address-list .city-list .item-city",obj).bind("click _click",function(e){
                    e.stopPropagation()
                    cityName=$(this).text()
                    city_id=$(this).attr("data-id")
                    addressInit();
                    $(this).siblings(".on").removeClass("on")
                    $(this).addClass("on")
                    cityIndex=$(this).index()
                    $(".address-list").hide()
                    $("input.input-text",obj).val(provinceName+"/"+cityName)
                })
            })
            var $province_id=$("input.province_id",obj).val()
            var $city_id=$("input.city_id",obj).val()
            if($province_id!=""&&$city_id!=""){
                
                SetAddressSelect({
                    obj:obj,
                    province_id:$province_id,
                    city_id:$city_id
                })
            }else{
                $(".address-list .province ul li:eq(0)",obj).trigger("_click")
            }
        }
        if(!window.cities){
            $public.get({
                url:"/commons/cities.json",
                successFn:function(data){
                    window.cities=data;
                    InitAddressSelect(data);
                }
            })
        }else{
            InitAddressSelect(window.cities);
        }
    }
    function SetAddressSelect({
        obj="",
        province_id=0,
        city_id=0
    }){
        if(province_id!=0&&city_id!=0){
            $(obj).find(".province li[data-id='"+province_id+"']").trigger("_click");
            $(obj).find(".city-list .item-city[data-id='"+city_id+"']").trigger("_click");
        }
    }
    
    
    var $Verification=function({
        obj="",
        url="",
        data={},
        fn=function(){
            
        },
        isJson=true
    }){
        if(isJson){
            $public.postJson({
                url:url,
                data:data,
                successFn:(data)=>{
                    var wrap=$(obj).parents("form");
                    wrap.find(".total-erro").remove();
                    var item=wrap.find(".verification-code")
                    item.next(".erro_msg").remove()
                    fn();
                    let s=60;
                    $(obj).prop("disabled",true);
                    $(obj).text(`${s}秒后重新获取`);  
                    $(obj).prop("disabled",true);
                    $public.time=setInterval(()=>{
                        s--;
                        $(obj).text(`${s}秒后重新获取`);            
                        if(s==0){
                            $(obj).prop("disabled",false);
                            clearInterval($public.time);
                            $(obj).text(`获取验证码`);
                            $(obj).prop("disabled",false);
                        }
                    },1000)
                },
                erroFn:(code)=>{
                    var wrap=$(obj).parents("form");
                    wrap.find(".total-erro").remove();
                    var item=wrap.find(".verification-code")
                    item.next(".erro_msg").remove()
                    var msg=""
                    if(code=="NotFound"){
                        msg="输入的手机/邮箱未注册"
                    }else{
                        msg=$AjaxErro(code)
                    }
                    item.after(`<div class="erro_msg serious-error"><i class="icon-erro"></i>${msg}</div>`)
                }
            })
        }else{
            $public.post({
                url:url,
                data:data,
                successFn:(data)=>{
                    var wrap=$(obj).parents("form");
                    wrap.find(".total-erro").remove();
                    var item=wrap.find(".verification-code")
                    item.next(".erro_msg").remove()
                    fn();
                    let s=60;
                    $(obj).prop("disabled",true);
                    $(obj).text(`${s}后重新获取`);  
                    $(obj).prop("disabled",true);
                    $public.time=setInterval(()=>{
                        s--;
                        $(obj).text(`${s}后重新获取`);            
                        if(s==0){
                            $(obj).prop("disabled",false);
                            clearInterval($public.time);
                            $(obj).text(`获取验证码`);
                            $(obj).prop("disabled",false);
                        }
                    },1000)
                },
                erroFn:(code)=>{
                    var wrap=$(obj).parents("form");
                    wrap.find(".total-erro").remove();
                    var item=wrap.find(".verification-code")
                    item.next(".erro_msg").remove()
                    var msg=""
                    if(code=="NotFound"){
                        msg="输入的手机/邮箱未注册"
                    }else{
                        msg=$AjaxErro(code)
                    }
                    item.after(`<div class="erro_msg serious-error"><i class="icon-erro"></i>${msg}</div>`)
                }
            })
        }
    }
    window.IsEnterpriseMail=function(str){
        if(str.length!=0){
            str=str.toLocaleLowerCase()
            var reg=$regexp.emailSuffix;
            var r=str.match(reg);
            if(r==null){
                return true;
            }else{
                return false;
            }
        }else{
            return false;
        }
    }
    var $Validform=function(data){
        var obj=data.obj;
        var fn=data.fn;
        var isSubmit=data.isSubmit;
        var beforeFn=data.beforeFn;
        var erro_obj=data.erro_obj;
        $("input,textarea,select",obj).bind("change input",function(){
            var $item=$(this)
            if($item.parent(".input-textarea").length>0){
                $item.parent(".input-textarea").next(".erro_msg").remove();
            }
            else if($item.parent(".textarea-wrap").length>0){
                $item.parent(".textarea-wrap").next(".erro_msg").remove();
            }
            else if($item.parents(".checked-group:eq(0)").length>0){
                $item.parents(".checked-group:eq(0)").next(".erro_msg").remove();;
            }
            else if($item.parent(".count-input").length>0){
                $item.parent(".count-input").next(".erro_msg").remove();;
            }
            else{
                $item.next(".erro_msg").remove();;
            }
        })
        obj.Validform({
            showAllError:true,
            tipSweep:true,
            tiptype: function (msg, o, cssctl) {
                if(o.type==3){
                    var isSeriousError="serious-error"
                    var icon=`<i class="icon-erro"></i>`
                    if(!erro_obj){
                        var top=parseInt(o.obj.attr("data-top"))
                        var topStyle=""
                        if(o.obj.attr("data-top")!=""){
                            topStyle=`style="margin-top:${top}px;"`
                        }
                        if(o.obj.parent(".input-textarea").length>0){
                            o.obj.parent(".input-textarea").next(".erro_msg").remove()
                            o.obj.parent(".input-textarea").after(`<div ${topStyle} class="erro_msg ${isSeriousError}">${icon}${msg}</div>`);
                        }
                        else if(o.obj.parent(".textarea-wrap").length>0){
                            o.obj.parent(".textarea-wrap").next(".erro_msg").remove()
                            o.obj.parent(".textarea-wrap").after(`<div ${topStyle} class="erro_msg ${isSeriousError}">${icon}${msg}</div>`);
                        }
                        else if(o.obj.parents(".checked-group:eq(0)").length>0){
                            o.obj.parents(".checked-group:eq(0)").next(".erro_msg").remove()
                            o.obj.parents(".checked-group:eq(0)").after(`<div ${topStyle} class="erro_msg ${isSeriousError}">${icon}${msg}</div>`);
                        }
                        else if(o.obj.parent(".count-input").length>0){
                            o.obj.parent(".count-input").next(".erro_msg").remove()
                            o.obj.parent(".count-input").after(`<div ${topStyle} class="erro_msg ${isSeriousError}">${icon}${msg}</div>`);
                        }
                        else{
                            o.obj.next(".erro_msg").remove()
                            o.obj.after(`<div ${topStyle} class="erro_msg ${isSeriousError}">${icon}${msg}</div>`);
                        }
                    }else{
                        o.obj.parents("form:eq(0)").prepend(`<p class="total-erro">${icon}${msg}</p>`);
                    }
                }
            },
            datatype:{
                "int":/^\+?(?!0)\d*$/,
                "account":$regexp.account,
                "e":$regexp.e,
                "m":$regexp.m
            },
            beforeCheck:function(curform){
                $(curform).find(".erro_msg").remove();
                $(curform).find(".total-erro").remove();
                
                $("input,textarea",curform).each(function(){
                    var val=$(this).val().trim();
                    $(this).val(val)
                })
                if(beforeFn){
                    beforeFn(curform);
                }
            },
            beforeSubmit: function (curform) {
                $("button[type='submit']",curform).prop("disabled",true);
                $(".total-erro").remove();
                setTimeout(()=>{
                    fn(curform);
                },10)
                return false;
            }
        });
    }
    var $getFormData=function ($form){
        var unindexed_array = $form.serializeArray();
        var indexed_array = {};
    
        $.map(unindexed_array, function(n, i){
            indexed_array[n['name']] = n['value'];
        });    
        return indexed_array;
    }
    var $post=function({
        url="",
        data="",
        successFn=function(){
            
        },
        erroFn=function(code){
            $tip($AjaxErro(code));
        },
        alwaysFn=function(){
            
        }
    }){
        $.ajax({
            url: url,
            type: "POST",
            datType: "JSON",
            data: data,
            async: true,
        }).always(function() {
            if(alwaysFn){
                alwaysFn();
            }
        })
        .done(function(data, textStatus, jqXHR){
            if(successFn){
                successFn(data);
            }
            return false;
        })
        .fail(function( xhr, textStatus, errorThrown){
            var err = eval("(" + xhr.responseText + ")");
            if(erroFn){
                erroFn(err.code);
            }
            return false;
        });
    }
    var $AjaxErro=function(code){
        var msg
        switch (code){
            case "InternalServerError":
                msg="服务器错误"
                break;
            case "MissingQueryParameter":
                msg="参数错误"
                break;
            case "MultipartMalformed":
                msg="参数缺失"
                break;
            case "NotFound":
                msg="请求不存在"
                break;
            case "MethodNotAllowed":
                msg="请求类型错误"
                break;
            case "NotAcceptable":
                msg="请求体错误"
                break;
            case "UnsupportedMediaType":
                msg="媒体类型错误"
                break;
            case "ValidationFailed":
                msg="验证失败"
                break;
            case "TypeMismatch":
                msg="方法参数类型不匹配"
                break;
            case "ConversionFailed":
                msg="你发送的内容可能是残缺的"
                break;
            case "Busy":
                msg="验证码发送频繁，请稍后再试"
                break;
            case "BadRequest":
                msg="请求失败"
                break;
            case "InvalidImageCode":
                msg="图形验证码错误"
                break;
            case "InvalidEmailCode":
                msg="邮件验证码错误"
                break;
            case "EmptyParameter":
                msg="参数不能为空"
                break;
            case "InvalidPhoneCode":
                msg="手机验证码错误"
                break;
            case "UserNotFound":
                msg="用户不存在"
                break;
            case "PhoneAlreadyExisted":
                msg="手机已经存在"
                break;
            case "EmailAlreadyExisted":
                msg="邮箱已经存在"
                break;
            case "AuthenticationFailed":
                msg="身份验证失败，请检查您的用户名和密码"
                break;
            case "IncompleteResume":
                msg="简历不完整"
                break;
            case "DuplicateDelivery":
                msg="重复投递"
                break;
            case "ExperienceMatchedError":
                msg="经验不匹配"
                break;
            case "InfoMatchedError":
                msg="信息不匹配"
                break;
            case "ChooseDelivery":
                msg="请选择投递方式"
                break;
            case "UnknownJob":
                msg="未知工作"
                break;
            case "ConversationNotFound":
                msg="没有找到会话"
                break;
            case "NotAllowExtensionException":
                msg="不允许的后缀名"
                break;
            case "ForbiddenException":
                msg="禁止请求"
                break;
            case "ConflictException":
                msg="请求冲突"
                break;
            case "GoneException":
                msg="请求失败"
                break;
            case "InterviewInfoNotFound":
                msg="这要求采访的信息是不存在的"
                break;
            case "AddressIsLocked":
                msg="这个请求地址锁定"
                break;
            case "WebUrlError":
                msg="链接格式错误"
                break;
            case "CryptoFailed":
                msg="token错误"
                break;
            case "CompanyNotPermission":
                msg="不能重复操作"
                break;
            case "JobNotPermission":
                msg="你的职位发布已达上限"
                break;
            case "CompanyAlreadyExisted":
                msg="公司名已存在"
                break;
            default:
                msg="未知错误:"+code
                break;
        }
        return msg
    }
    var $postJson=function({
        url="",
        data={},
        successFn=function(){
            
        },
        erroFn=function(code){
            $tip($AjaxErro(code));
        },
        alwaysFn=function(){
            
        }
    }){
        $.ajax({
            url: url,
            type: "POST",
            datType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            async: true,
        }).always(function() {
            if(alwaysFn){
                alwaysFn();
            }
        })
        .done(function(data, textStatus, jqXHR){
            if(successFn){
                successFn(data);
            }
        })
        .fail(function( xhr, textStatus, errorThrown){
            var err = eval("(" + xhr.responseText + ")");
            if(erroFn){
                erroFn(err.code,err);
            }
        });
    }
     var $get=function({
        url="",
        data="",
        successFn=function(){
            
        },
        erroFn=function(code){
            $tip($AjaxErro(code));
        },
        alwaysFn=function(){
            
        }
     }){
        $.ajax({
            url: url,
            type: "GET",
            datType: "JSON",
            data: data,
            async: true,
        }).always(function() {
            if(alwaysFn){
                alwaysFn();
            }
        })
        .done(function(data, textStatus, jqXHR){
            if(successFn){
                successFn(data);
            }
            return false;
        })
        .fail(function( xhr, textStatus, errorThrown){
            var err = eval("(" + xhr.responseText + ")");
            if(erroFn){
                erroFn(err.code,err);
            }
            return false;
        });
    }
    var $getJson=function({
        url="",
        data={},
        successFn=function(){
            
        },
        erroFn=function(code){
            $tip($AjaxErro(code));
        },
        alwaysFn=function(){
            
        }
    }){
        $.ajax({
            url: url,
            type: "GET",
            datType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            async: true,
        }).always(function() {
            if(alwaysFn){
                alwaysFn();
            }
        })
        .done(function(data, textStatus, jqXHR){
            if(successFn){
                successFn(data);
            }
            return false;
        })
        .fail(function( xhr, textStatus, errorThrown){
            var err = eval("(" + xhr.responseText + ")");
            if(erroFn){
                erroFn(err.code);
            }
            return false;
        });
    }
    
    var $upLoadImg=function({
        url="",
        preview="",
        btn="",
        width=0,
        height=0,
        limitWidth=0,
        limitHeight=0,
        Limiting=function(){
            return true;
        },
        beforeFn=function(){},
        startFn=function(){},
        successFn=function(){},
        completeFn=function(){},
        data={},
        progressBar="",
        noprogressBar=false
    }){
        
            if(progressBar==""){
                  progressBar=btn;
            }
            var viewImg="";
            var compress={
                // 压缩后的尺寸
                width: limitWidth*2,
                height: limitHeight*2,
                quality:100,
                // 是否允许放大，如果想要生成小图的时候不失真，此选项应该设置为false
                allowMagnify: true,
                // 是否允许裁剪
                crop: true,
                // 是否保留头部meta信息
                type:"image/jpeg",
                compressSize: 0
            }
            if(limitWidth==0||limitHeight==0){
                compress=null
            }
            var uploader = WebUploader.create({
                formData:data,
                // swf文件路径
                swf:'/static/plugins/webuploader/Uploader.swf',
                // 文件接收服务端。
                server: url,
                fileNumLimit:1,
                fileSingleSizeLimit:10*1024*1024,
                // 选择文件的按钮。可选。
                // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                pick: btn,
                auto:true,
                // 只允许选择图片文件。
                accept: {
                    extensions:'gif,jpg,jpeg,bmp,png',
                    mimeTypes:'image/jpg,image/jpeg,image/png'
                },
                compress:compress
            });
            uploader.on("error", function (type) {
                if (type == "Q_TYPE_DENIED") {
                    alert("请上传JPG、PNG、GIF、BMP格式文件");
                } else if (type == "F_EXCEED_SIZE") {
                    alert("文件大小不能超过10M");
                }else {
                    alert("上传出错！请检查后重新上传！错误代码"+type);
                }
            });
            uploader.on('fileQueued',function( file ) {//缩略图返回
                uploader.makeThumb( file,function( error, ret ) {
                    if ( error ) {
                        alert(error);
                   } else {
                        viewImg=ret;
                        var info = file._info || $upLoadImg.info();        
                        if(info.type!="image/jpeg"&&limitHeight!=0&&limitWidth!=0){
                            if(info.height!=limitHeight||info.width!=limitWidth){
                                uploader.cancelFile( file );
                                $(".progress-bar",progressBar).hide()
                                alert(`图片尺寸请符合${limitWidth}x${limitHeight}`)
                            }else{ 
                                if(!Limiting()){
                                    uploader.cancelFile( file );
                                }else{
                                    $(preview).attr("src",ret);
                                }
                            }
                        }else{
                            if(!Limiting()){
                                uploader.cancelFile( file );
                            }else{
                                $(preview).attr("src",ret);
                            }
                        }
                   }
                },width,height);
            });
            uploader.on('beforeFileQueued', function(file) {
                beforeFn();
                $(".progress-bar",progressBar).remove()
                if(!noprogressBar&&$(".progress-bar",progressBar).length==0){
                    $(progressBar).append(`<div class="progress-bar">
                        <span class="bar"></span>
                    </div>`);
                }
                $(".progress-bar .bar",progressBar).css({
                    "width":"0%"
                })
                $(".progress-bar",progressBar).show() 
                $("#up-info-btn").prop("disabled",true)
                uploader.reset();
            });
            uploader.on('uploadProgress', function( file, percentage ) {
                startFn();
                $(".progress-bar .bar",progressBar).css({
                    "width":"50%"
                })
        
            });
            uploader.on('uploadError',function(data){
                alert("上传失败")
            });
            uploader.on('uploadSuccess',(file, json)=>{
                successFn(json,viewImg);
            });
            uploader.on('uploadComplete',(json)=>{
                $(".progress-bar .bar",progressBar).css({
                    "width":"100%"
                })
                setTimeout(()=>{
                    $(".progress-bar",progressBar).hide()
                    completeFn();
                    if(!noprogressBar){
                        $tip("上传完毕")
                    }
                },500)
            })   
    }
    
    
    var $upLoadFile=function({
        url="",
        preview="",
        btn="",
        successFn=function(){},
        data={}
    }){
        var uploader = WebUploader.create({
            formData:data,
            // swf文件路径
            swf:'/static/plugins/webuploader/Uploader.swf',
            // 文件接收服务端。
            server: url,
            fileNumLimit:1,
            fileSingleSizeLimit:10*1024*1024,
            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: btn,
            auto:true,
            // 只允许选择图片文件。
            accept: {
                extensions: 'doc,docx,pdf',
            },
        });
        uploader.on("error", function (type) {
            if (type == "Q_TYPE_DENIED") {
                alert("请上传doc,docx,pdf格式文件");
            } else if (type == "F_EXCEED_SIZE") {
                alert("文件大小不能超过10M");
            }else {
                alert("上传出错！请检查后重新上传！错误代码"+type);
            }
        });
        uploader.on('beforeFileQueued', function() {
            $(".progress-bar",btn).remove()
            if($(".progress-bar",btn).length==0){
                $(btn).append(`<div class="progress-bar">
                    <span class="bar"></span>
                </div>`);
            }
            $(".progress-bar .bar",btn).css({
                "width":"0%"
            })
            $(".progress-bar",btn).show() 
            $("#up-info-btn").prop("disabled",true)
            uploader.reset();
        });
        uploader.on('uploadProgress', function( file, percentage ) {
            $(".progress-bar .bar",btn).css({
                "width":"50%"
            })
        });
        uploader.on('uploadError',function(data){
            alert("上传失败")
        });
        uploader.on('uploadSuccess',(file, json)=>{
            successFn(json);
        });
        uploader.on('uploadComplete',(json)=>{
            $(".progress-bar .bar",btn).css({
                "width":"100%"
            })
            setTimeout(()=>{
                $(".progress-bar",btn).hide()
            },500)
        })    
    }
    
    var $setcityList=function(){
        BaiDuMap.addPoint(0,0);
        setTimeout(function(){
            var provinceId= $(".map-modular input[name='province_id']").val()
            var cityId=$(".map-modular input[name='city_id']").val()
            var districtId=$(".map-modular input[name='district_id']").val()
            var address=$(".map-modular input[name='address']").val()
            var latitude=$("#map-modular input[name='latitude']").val()
            var longitude=$("#map-modular input[name='longitude']").val()
            if(provinceId!=""&&cityId!=""&&districtId!=""){
                $(".map-tool .address-list .province li[data-id='"+provinceId+"']").click()
                setTimeout(function(){
                $(".map-tool .address-list .city-list .item-city[data-id='"+cityId+"']").click()
                },1)
                setTimeout(function(){
                    $(".map-tool .address-list .city-list .item-city[data-id='"+cityId+"'] .area-list .area-item[data-id='"+districtId+"']").click()
                },2)
                setTimeout(function(){
                    $(".map-modular input[name='address']").val(address)
                    $("#map-modular input[name='latitude']").val(latitude)
                    $("#map-modular input[name='longitude']").val(longitude)
                },3)
            }else{
                $(".map-tool .address-list .province li:eq(0)").click()
            }
            
            if(latitude!=""&&longitude!=""){
                BaiDuMap.addPoint(latitude,longitude);
            }else{
                BaiDuMap.init()
            }
        },100)
    }
    var $cityList=function(){
        $(".map-modular .address-box input").click(function(e){
            e.stopPropagation();
            $(this).siblings(".address-list").toggle()
        })
        $(".map-modular input[name='address']").click(function(e){
            e.stopPropagation();
            $(this).siblings(".address-list").toggle()
        })
        $(".address-box input.input-text").bind("input",function(){
            $(".map-modular input[name='address']").prop("disabled",false)
            $(".map-modular input[name='address']").focus()
        })
        let query_time=null;
        $(".map-modular input[name='address']").bind("input propertychange",function(){
            if($(this).val().trim()!=""){        
                var key=$("input.address-text").val().replace(/\//g,"")+$(this).val()
                clearTimeout(query_time)
                query_time=setTimeout(()=>{   
                    BaiDuMap.search(key)
                },100)
            }
        })
        $("#save-address").click(function(){
            var init_id=$(".map-modular input[name='id']").val()
            var province_id=$(".map-modular input[name='province_id']").val()
            var city_id=$(".map-modular input[name='city_id']").val()
            var district_id=$(".map-modular input[name='district_id']").val()
            var longitude=$(".map-modular input[name='longitude']").val();
            var latitude=$(".map-modular input[name='latitude']").val();
            var address=$(".map-modular input[name='address']").val()
            var addressText=$(".map-modular input.address-text").val()
            $postJson({
                url:"/companies/address/create",
                data:$getFormData($("#addressForm")),
                successFn:function(data){

                    var id=data.id;
                    if(init_id==""){
                        $(".map-modular input[name='id']").val(id)
                        var html=`<div class="item">
                                        <label class="item-add">
                                            <label class="radio-label"><input value="${id}" name="address_id" type="radio"/><i></i></label>
                                            <span class="label">${addressText}/${address}</span>
                                            </label>
                                            <a data-id="${id}"
                                                data-provinceId="${province_id}"
                                                data-cityId = "${city_id}"
                                                data-districtId = "${district_id}"
                                                data-address = "${address}"
                                                data-longitude = "${longitude}"
                                                data-latitude = "${latitude}"
                                            class="edit" href="javascript:void(0)">编辑</a>
                                        </div>`
                        $("#address-tab").append(html)
                        $("#address-tab input[type='radio']:last").prop("checked",true).trigger("change")
                    }else{
                       var item=$("#address-tab .edit[data-id='"+id+"']");
                       item.parents(".item:eq(0)").find(".label").text(`${addressText}/${address}`)
                       item.attr("data-provinceId",province_id);
                       item.attr("data-cityId",city_id);
                       item.attr("data-districtId",district_id);
                       item.attr("data-address",address);
                       item.attr("data-longitude",longitude);
                       item.attr("data-latitude",latitude);
                    }
                    $offDialog();
                }

            })
        })
        $get({
            url:"/commons/cities.json",
            successFn:function(data){
                var provincehtml=""//省HTML
                var provinceIndex=0;//省索引
                var cityIndex=0;//城市索引
                var areaIndex=0;//区索引
                var provinceName="";//省中文
                var cityName="";//城市中文
                var areaName="";//区中文
                var province_id=0;//省id
                var city_id=0;//城市id
                var district_id=0;//区id
                function addressInit(){
                    $(".map-modular input[name='province_id']").val(province_id)
                    $(".map-modular input[name='city_id']").val(city_id)
                    $(".map-modular input[name='district_id']").val(district_id)
                    $(".map-modular input[name='latitude']").val("");
                    $(".map-modular input[name='longitude']").val("");
                    $(".map-modular input[name='address']").val("")
                }
                for(let i=0;i<data.length;i++){
                    provincehtml+=`<li data-id="${data[i].id}">${data[i].name}</li>`
                }
                $(".map-modular .address-list .province ul").html(provincehtml);
                $(".map-modular .address-list .province ul li").click(function(){
                    $(".map-modular input[name='address']").prop("disabled",true)
                    provinceName=$(this).text()
                    city_id=""
                    district_id=""
                    province_id=$(this).attr("data-id")
                    addressInit();
                    $(this).siblings(".on").removeClass("on")
                    $(this).addClass("on")
                    provinceIndex=$(this).index()
                    let children=data[provinceIndex].children;
                    var cityhtml=""
                    for(let k=0;k<children.length;k++){
                        cityhtml+=`<div data-id="${children[k].id}" class="item-city"><span class="text">${children[k].name}</span><div class="area-list"></div></div>`
                    }
                    $(".map-modular .address-list .city-list").html(cityhtml)
                    $(".map-modular .address-box input.input-text").val("");
                    $(".map-modular .address-list .city-list .item-city").click(function(){
                        $(".map-modular input[name='address']").prop("disabled",true)
                        cityName=$(this).text()
                        district_id=""
                        city_id=$(this).attr("data-id")
                        addressInit();
                        $(this).siblings(".on").removeClass("on")
                        $(this).addClass("on")
                        cityIndex=$(this).index()
                        let children=data[provinceIndex].children[cityIndex].children;
                        var areahtml=""
                        for(let m=0;m<children.length;m++){
                            areahtml+=`<div data-id="${children[m].id}" class="area-item">${children[m].name}</div>`;
                        }
                        $(".area-list",this).html(areahtml)
                        $(".map-modular .address-box input.input-text").val("");
                        $(".area-list .area-item",this).click(function(e){
                            e.stopPropagation();
                            areaName=$(this).text()
                            $(this).siblings(".on").removeClass("on")
                            $(this).addClass("on")
                            let id=$(this).attr("data-id")
                            district_id=id
                            $(".map-modular .address-box input.input-text").val(provinceName+"/"+cityName+"/"+areaName).trigger("input")
                            $(".map-modular .address-list").hide()
                            addressInit();
                        })
                    })
                })
                
            }
        })
    }
    var ResetIndustryFrame=function(id){
        $("#industry-frame").attr("src",`/commons/industries?headless=true&industry_id=${id}`)
    }
    var IndustryFrame=function(id){
        if($(document).height()>$(window).height()){
            $("body").addClass("lock")
        }
        if($("#industry-frame").length==0){
            var url=`/commons/industries?headless=true`
            if(id){
                url=`/commons/industries?headless=true&industry_id=${id}`
            }
            var frame=`<iframe width="100%" height="100%" id="industry-frame" src="${url}"></iframe>`
            $("body").append(frame);
        }else{
            $("#industry-frame").show()
        }
    }
    var OffIndustryFrame=function(id){
        $("#industry-frame").hide()
        if($(".modal-backdrop:visible").length==0){
            $("body").removeClass("lock")
        }        
        if(id){
            $("#industry-frame").attr("src",`/commons/industries?headless=true&industry_id=${id}`)
        }
    }
    return {
        ResetIndustryFrame:ResetIndustryFrame,
        IndustryFrame:IndustryFrame,
        OffIndustryFrame:OffIndustryFrame,
        cityList:$cityList,
        setcityList:$setcityList,
        Validform:$Validform,
        getFormData:$getFormData,
        AjaxErro:$AjaxErro,
        post:$post,
        postJson:$postJson,
        get:$get,
        getJson:$getJson,
        upLoadImg:$upLoadImg,
        upLoadFile:$upLoadFile,
        offDialog:$offDialog,
        showDialog:$showDialog,
        tip:$tip,
        confirm:$confirm,
        Verification:$Verification,
        addressSelect:addressSelect,
        SetAddressSelect:SetAddressSelect
    }
})()
window.InitWord=function(){
    $(".count-word-box").each(function(){
        var nub=$(this).val().length;
        $(this).parents("div:eq(0)").find(".count-word").text(nub)
    })
}
$(function(){
    InitWord()
    $(".count-word-box").bind("input focus",function(){
        var nub=$(this).val().length;
        $(this).parents("div:eq(0)").find(".count-word").text(nub)
    })
    $("img.captcha").click(function(){
        var src=$(this).attr("src");
        var index=src.indexOf("?")
        src=src.substring(0,index)+"?"
        $(this).attr("src",src+Math.random());
    })
    $("input").attr("autocomplete","off")
    $("input[type='password']").each(function(){
        var item=$(this)
        item.attr("type","text");
        setTimeout(function(){
            item.attr("type","password")
        },1)
    })
    //下拉
    window.selectCustom=function(obj){
        if(isSupportWebkitTransform()){
            $(obj).each(function(){
                var $width=$(this).width()
                var $padding=($(this).innerWidth()-$width)/2;
                if($padding<=5){
                    $padding=10;
                }
                var $height=$(this).innerHeight()
                var $text=$("option:selected",this).text()
                var optionHtml="";
                $("option",this).each(function(){
                    var on=""
                    if($(this).prop("selected")){
                        on="on"
                    }
                    optionHtml+=`<div style="padding:0px ${$padding}px;" data-val="${$(this).attr('value')}" class="option-item ${on}">${$(this).text()}</div>`
                })
                $(this).wrap(`<div class="select-box" style="width:${$width}px; height:${$height}px; line-height:${$height}px; padding:0px ${$padding}px;">
                    <div style="height:${$height}px;" class="current-val"><span class="text">${$text}</span><i class="arow-b"></i></div>
                    <div class="option-group" style="top:${$height}px;">${optionHtml}</div>
                </div>`)
            })
        }
    }
    selectCustom(".select-custom");
    $(document).bind("mousedown",function(){
        $(".option-group").hide();
        $(".select-box").removeClass("active");
        $(".select-box.active").removeClass("active")
    })
    $("body").on("mousedown",".select-box .current-val",function(e){
        e.stopPropagation();
        var item=$(this).next(".option-group")
        $(".option-group").not(item).hide()
        item.toggle();
        var wrap=$(this).parents(".select-box:eq(0)")
        if($(this).next(".option-group:visible").length>0){
            wrap.addClass("active")
        }else{
            wrap.removeClass("active")
        }
    })
    $("body").on("mousedown",".select-box .option-item",function(e){
        e.stopPropagation();
        if(!$(this).hasClass("on")){
            var dataVal=$(this).attr("data-val")
            var wrap=$(this).parents(".select-box:eq(0)")
            wrap.find("select").val(dataVal).trigger("change")
        }
    })
    $("body").on("change",".select-box select",function(){
        var dataVal=$(this).val()
        var wrap=$(this).parents(".select-box:eq(0)")
        wrap.find(".current-val .text").text($("option:selected",this).text())
        wrap.find(".option-group").hide()
        wrap.find(".option-item[data-val='"+dataVal+"']").addClass("on").siblings(".option-item").removeClass("on")
        wrap.removeClass("active")
    })
    //下拉
    //tip框
    $("[data-tip]").hover(function(){
        var item=$(".icon-tip",this)
        var $text=$(this).attr("data-tip");
        var html=`<div style="display: none;" class="tip-box-pop" id="tip-box-pop">
                       <p>${$text}</p>
                       <span class="arow-b"><i></i></span>
                    </div>`
        $("body").append(html)
        $("#tip-box-pop").show()
        var top=item.offset().top
        var left=item.offset().left
        var width=$("#tip-box-pop").outerWidth();
        var height=$("#tip-box-pop").outerHeight();
        $("#tip-box-pop").css({
            "top":top,
            "left":left,
            "margin-top":-height-10,
            "margin-left":(-width/2)+5,
        })
    },function(){
        $("#tip-box-pop").remove()
    })
    //tip框
    //学校专业查询
    $(document).click(function(){
        $(".match-list").remove()
    })
    window.InitSchoolMatch=function(){
        $(".school-match input").bind("input propertychange",function(){
            var name=$(this).val()
            if(name!=""){
                $public.get({
                url:"/resume/educations/collage.json",
                data:{
                    name:name
                },
                successFn:(data)=>{
                    if(data.length>0){
                        $(this).siblings(".match-list").remove()
                        var list=""
                        for(var i=0;i<data.length;i++){
                            list+=`<li>${data[i].name}</li>`
                        }
                        var html=`<div class="match-list">
                                        <ul>
                                            ${list}
                                        </ul>
                                    </div>`
                        $(this).after(html)
                    }else{
                        $(this).siblings(".match-list").remove()
                    }
                }
                })
            }else{
                $(this).siblings(".match-list").remove()
            }     
        })        
    }
    InitSchoolMatch();
    $(".school-match").on("click mousedown",".match-list li",function(e){
        e.stopPropagation()
        var $text=$(this).text()
        var $input=$(this).parents(".match-list:eq(0)").siblings("input");
        $input.unbind("input propertychange")
        $input.val($text)
        InitSchoolMatch()
        $(this).parents(".match-list:eq(0)").remove()
    })
    window.InitMajorMatch=function(){
        $(".major-match input").bind("input propertychange",function(){
            var name=$(this).val()
            if(name!=""){
                $public.get({
                url:"/resume/educations/major.json",
                data:{
                    name:name
                },
                successFn:(data)=>{
                    if(data.length>0){
                        $(this).siblings(".match-list").remove()
                        var list=""
                        for(var i=0;i<data.length;i++){
                            list+=`<li>${data[i].name}</li>`
                        }
                        var html=`<div class="match-list">
                                        <ul>
                                            ${list}
                                        </ul>
                                    </div>`
                        $(this).after(html)
                    }else{
                        $(this).siblings(".match-list").remove()
                    }
                }
                })
            }else{
                $(this).siblings(".match-list").remove()
            }
            
        })
    }
    InitMajorMatch()    
    $(".major-match").on("click mousedown",".match-list li",function(e){
        e.stopPropagation()
        var $text=$(this).text()
        var $input=$(this).parents(".match-list:eq(0)").siblings("input");
        $input.unbind("input propertychange")
        $input.val($text)
        InitMajorMatch()
        $(this).parents(".match-list:eq(0)").remove()
    })
    //学校专业查询
    $(document).click(function(){
        $(".map-tool .address-list").hide()
        $(".address-box .address-list").hide()
        $(".job-list-mod").hide()
    })
    $(".map-tool .address-list").click(function(e){
        e.stopPropagation();
    })
    $(".job-list").click(function(e){
        e.stopPropagation();
    })
    $(".modal-dialog .off,.modal-dialog .btn.cancel").click(function(){
        $public.offDialog();
    })
    //行业
    $("#industryList").siblings("input").click(function(){
        $("#industryList").show();
    })
    if($("#industryList").length!=0){
        $public.getJson({
            url:"/companies/industry",
            data:"",
            successFn:function(data){
                window.industryData=data;
                var Lv1=""
                for(var item in data){
                    Lv1+=`<li data-id="${item}"><p>${data[item].industry}</p><span class="arow-r"><i></i></span></li>`
                }
                var $html=`<div class="job-val"><p class="val">请选择所属的行业</p><span class="arow-b"></span></div>
                    <div class="job-type">
                        <ul>${Lv1}</ul>
                    </div>
                    <div class="job-item">
                        <dl></dl>
                    </div>`
                $("#industryList").html($html);
                $("#industryList .job-type li").click(function(){
                    $(this).siblings("li").removeClass("on")
                    $(this).addClass("on");
                    var id=$(this).attr("data-id");
                    var Lv2="";
                    for(var item in data[id].children){
                        if(data[id].children[item].id){
                            Lv2+=`<dd data-id="${data[id].children[item].id}">${data[id].children[item].industry}</dd>`
                        }
                    }
                    $("#industryList .job-item dl").html(Lv2);
                    $("#industryList .job-item dl dd").click(function(){
                        $(this).siblings("dd").removeClass("on")
                        $(this).addClass("on");
                        $("#industryList .val").text($(this).text())
                        $("#industryList").hide()
                        $("#industryList").siblings("input.input-text").val($(this).text());
                        $("#industryList").siblings("input.hide-val").val($(this).attr("data-id"));
                    })
                })
                $("#industryList .job-type li:eq(0)").click()
                var initVal=$("#industryList").siblings("input.hide-val").val()
                if(initVal!=""){
                    for(let i=0;i<industryData.length;i++){
                        var item=industryData[i].children;
                        for(let k=0;k<item.length;k++){
                            if(item[k].id==initVal){
                                $("#industryList .job-type li:eq("+i+")").click();
                                $("#industryList .job-item dl dd:eq("+k+")").click();
                                return;
                            }
                        }
                    }
                }
            }
        })
    }
    //行业
    //职业
    $("#jobList").siblings("input").click(function(){
        $("#jobList").toggle();
    })
    $("#jobList").on("click",".job-val",function(){
        $("#jobList").toggle();
    })
    if($("#jobList").length!=0){
        var data=jobCategories;
        var Lv1=""
        for(var item in data){
            if(data[item].id){
                Lv1+=`<li data-id="${item}"><p>${data[item].job}</p><span class="arow-r"><i></i></span></li>`
            }
        }
        var $html=`<div class="job-val"><p class="val">请选择所属的行业</p><span class="arow-b"></span></div>
            <div class="job-type">
                <ul>${Lv1}</ul>
            </div>
            <div class="job-item">
                <dl></dl>
            </div>`
        $("#jobList").html($html);
        $("#jobList .job-type li").click(function(){
            var lvIndustry=$(this).text()
            $(this).siblings("li").removeClass("on")
            $(this).addClass("on");
            var id=$(this).attr("data-id");
            var Lv2="";
            for(var item in data[id].children){
                if(data[id].children[item].id){
                    Lv2+=`<dd data-id="${data[id].children[item].id}">${data[id].children[item].job}</dd>`
                }
            }
            $("#jobList .job-item dl").html(Lv2);
            $("#jobList .job-item dl dd").click(function(){
                $(this).siblings("dd").removeClass("on")
                $(this).addClass("on");
                $("#jobList .val").text($(this).text())
                $("#jobList").hide()
                $("#jobList").siblings("input.input-text").val($(this).text()).trigger("input");
                $("#jobList").siblings("input.input-text").val(lvIndustry+"/"+$(this).text())
                $("#jobList").siblings("input.hide-val").val($(this).attr("data-id")).trigger("input");
            })
        })
        $("#jobList .job-type li:eq(0)").click()
    }
    //职业
    $(".foot-left-tool-bar .item.up").click(function(){
       $("html,body").animate({scrollTop:0},400);
    });
})