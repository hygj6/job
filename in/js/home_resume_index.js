$public.upLoadImg({
    url:"/resume/main/upload.json",
    width:120,
    height:120,
    btn:'#mask-up',
    preview:"#picview",
    limitWidth:120,
    limitHeight:120,
    noprogressBar:true,
    startFn:function(){
        $(".up-avatar-box").addClass("active")
        $(".up-avatar-box .ring-right i").css({
            "transform":"rotate(180deg)"
        })
    },
    successFn:function(){
        setTimeout(function(){
            $(".up-avatar-box").addClass("active")
            $(".up-avatar-box .ring-left i").css({
                "transform":"rotate(180deg)"
            })
            setTimeout(function(){
                $(".up-avatar-box").removeClass("active")
                $(".up-avatar-box .ring-right i,.up-avatar-box .ring-left i").css({
                    "transform":"rotate(0deg)"
                })
                $public.tip("上传完毕")
            },500)
        },500)
    }
})
// 工作经历=============================================================
function initExperienceForm(){
    $public.Validform({
        obj:$("#experience-list form"),
        fn:function(curform){
            var item=$public.getFormData(curform);
            var hire_date=item.hire_date;
            item.hire_date=new Date(hire_date).getTime()
            var leaving_date=item.leaving_date;
            item.leaving_date=new Date(leaving_date).getTime()
            if(item.id!=""){
                $public.postJson({
                    url:"/resume/experiences/update",
                    data:item,
                    successFn:function(data){
                        var editBox=$(curform).parents(".edit-box");
                        var wrap=editBox.prev("dl.item");
                        wrap.show();
                        editBox.hide();
                        $(".company",wrap).text($("input[name='company']",editBox).val())
                        $(".position",wrap).text($("input[name='position']",editBox).val())
                        $(".hire_date",wrap).text($("input[name='hire_date']",editBox).val())
                        $(".leaving_date",wrap).text($("input[name='leaving_date']",editBox).val())
                        $(".job_detail",wrap).html(encodeTextAreaString($("textarea[name='job_detail']",editBox).val()))
                        var hire_date=$("input[name='hire_date']",editBox).val().replace(/-/,"");
                        wrap.attr("data-time",hire_date);
                        var hire_date= parseInt($("input[name='hire_date']",editBox).val().replace(/-/,""));
                        var $item=null;
                        $("#experience-list dl.item").each(function(){
                            var this_date=parseInt($(this).attr("data-time"));
                            if(this_date>hire_date){
                                $item=$(this);
                            }
                        })
                        if($item){
                            $(wrap).insertAfter($item)
                        }
                        else{
                            $(wrap).prependTo("#experience-list")   
                        }
                    },
                    alwaysFn:function(curform){
                        $("button[type='submit']",curform).prop("disabled",false);
                    }
                })
            }else{
                $public.postJson({
                    url:"/resume/experiences/create",
                    data:item,
                    successFn:function(data){
                        var editBox=$(curform).parents(".edit-box");
                        var wrap=editBox.prev("dl.item");
                        wrap.show();
                        editBox.hide();
                        var hire_date= parseInt($("input[name='hire_date']",editBox).val().replace(/-/,""));
                        var $item=null;
                        $("#experience-list dl.item").each(function(){
                            var this_date=parseInt($(this).attr("data-time"));
                            if(this_date>hire_date){
                                $item=$(this);
                            }
                        })
                        var $html=`<dl data-time="${hire_date}" class="item">
                                <dt>
                                    <input type="hidden" class="id" value="${data.id}"/>
                                    <div class="company-mod"><p class="company company-name">${$("input[name='company']",editBox).val()}</p><span class="time">
                                    <span class="hire_date">${$("input[name='hire_date']",editBox).val()}</span>
                                     ~ 
                                    <span class="leaving_date">${$("input[name='leaving_date']",editBox).val()}</span>
                                    </span><a class="tool-btn edit" href="javascript:void(0)">编辑</a></div>
                                    <p class="job position">${$("input[name='position']",editBox).val()}</p>
                                </dt>
                                <dd>
                                    <p class="job_detail">${$("textarea[name='job_detail']",editBox).val()}</p>
                                </dd>
                            </dl>`
                        if($item){
                            $item.after($html);
                        }else{
                            $($html).prependTo("#experience-list");
                        }
                    },
                    alwaysFn:function(curform){
                        $("button[type='submit']",curform).prop("disabled",false);
                    }
                })
            }
        }
    })
}
$("#experience-list").on("click",".edit",function(){
    var wrap=$(this).parents("dl.item:eq(0)");
    wrap.hide().siblings("dl.item").show();
    var editBox=$("#experience-list .edit-box")
    editBox.insertAfter(wrap);
    editBox.show();
    $("input[name='id']",editBox).val($(".id",wrap).val())
    $("input[name='company']",editBox).val($(".company",wrap).text())
    $("input[name='position']",editBox).val($(".position",wrap).text())
    $("input[name='hire_date']",editBox).val($(".hire_date",wrap).text()).trigger("input")
    $("input[name='leaving_date']",editBox).val($(".leaving_date",wrap).text()).trigger("input")
    var job_detail=decodeTextAreaString($(".job_detail",wrap).html());
    $("textarea[name='job_detail']",editBox).val(job_detail)
    initExperienceForm();
})
$("#experience-list").on("click",".btn.cancel",function(){
    $(this).parents(".edit-box:eq(0)").hide();
    $(this).parents(".edit-box:eq(0)").prev("dl.item").show();
})
$("#add-experience").click(function(){
    if($("#experience-list .edit-box:visible").length==0){    
        $("#experience-list dl").show()
        var editBox=$("#experience-list .edit-box:eq(0)");
        editBox.insertBefore("#experience-list dl.item:eq(0)");
        editBox.show();
        editBox.find("form")[0].reset();
        initExperienceForm();
    }else{
        $public.confirm({
            title:"提醒",
            msg:"当前正在编辑其他工作经验，确认要创建新的工作经验",
            fn:function(){
                $("#experience-list dl").show()
                var editBox=$("#experience-list .edit-box:eq(0)");
                editBox.insertBefore("#experience-list dl.item:eq(0)");
                editBox.show();
                editBox.find("form")[0].reset();
                initExperienceForm();
            }
        })
    }
})
$("#experience-list").on("click",".del",function(){
    var editBox=$(this).parents(".edit-box:eq(0)");
    var item=$(this).parents(".edit-box:eq(0)").prev(".item");
    var id=$(this).parents("form:eq(0)").find("input[name='id']").val();
    $public.confirm({
        title:"删除工作经验",
        msg:"确认删除该工作经验",
        fn:function(){
            $public.post({
                url:"/resume/experiences/delete.json",
                data:{"id":id},
                successFn:function(){
                    item.remove();
                    editBox.hide();
                }
            })
        }
    })
    
})


// 教育经历=====================================================
function initEducationForm(){
    $public.Validform({
        obj:$("#educations-list form"),
        fn:function(curform){
            var item=$public.getFormData(curform);
            if(item.id!=""){
                $public.postJson({
                    url:"/resume/educations/update",
                    data:item,
                    successFn:function(data){
                        var editBox=$(curform).parents(".edit-box");
                        var wrap=editBox.prev("dl.item");
                        wrap.show();
                        editBox.hide();
                        $(".school",wrap).text($("input[name='school']",editBox).val())
                        $(".major",wrap).text($("input[name='major']",editBox).val())
                        $(".graduation_year",wrap).text($("[name='graduation_year']",editBox).val())
                        $(".type",wrap).text($("[name='type_id'] option:selected",editBox).text())
                        $("[name='type_id']",wrap).val($("[name='type_id']",editBox).val())

                        var graduation_year=parseInt($("[name='graduation_year']",editBox).val());
                        wrap.attr("data-time",graduation_year);
                        var $item=null;
                        $("#educations-list dl.item").each(function(){
                            var this_date=parseInt($(this).attr("data-time"));
                            if(this_date>graduation_year){
                                $item=$(this);
                            }
                        })
                        if($item){
                            $(wrap).insertAfter($item)
                        }
                        else{
                            $(wrap).prependTo("#educations-list")   
                        }

                    },
                    alwaysFn:function(curform){
                        $("button[type='submit']",curform).prop("disabled",false);
                    }
                })
            }else{
                $public.postJson({
                    url:"/resume/educations/create",
                    data:item,
                    successFn:function(data){
                        var editBox=$(curform).parents(".edit-box");
                        var wrap=editBox.prev("dl.item");
                        wrap.show();
                        editBox.hide();
                        

                        var graduation_year=parseInt($("[name='graduation_year']",editBox).val());
                        wrap.attr("data-time",graduation_year);
                        var $item=null;
                        $("#educations-list dl.item").each(function(){
                            var this_date=parseInt($(this).attr("data-time"));
                            if(this_date>graduation_year){
                                $item=$(this);
                            }
                        })
                        var $html=`<dl data-time="${$("[name='graduation_year']",editBox).val()}" class="item">
                                <dt>
                                    <input type="hidden" class="id" value="${data.id}"/>
                                    <div class="company-mod"><p class="company-name school">${$("[name='school']",editBox).val()}</p><span class="time"><span class="graduation_year">${$("[name='graduation_year']",editBox).val()}</span>毕业</span><a class="tool-btn edit" href="javascript:void(0)">编辑</a></div>
                                    <p class="job"><span class="major">${$("[name='major']",editBox).val()}</span>/<span class="type">${$("[name='type'] option:selected",editBox).text()}</span><input type="hidden" name="type" value="${$("[name='type']",editBox).val()}"></p>
                                </dt>
                            </dl>`;
                        if($item){
                            $item.after($html);
                        }
                        else{
                            $($html).prependTo("#educations-list")   
                        }
                    },
                    alwaysFn:function(curform){
                        $("button[type='submit']",curform).prop("disabled",false);
                    }
                })
            }
        }
    })
}

$("#educations-list").on("click",".edit",function(){
    var wrap=$(this).parents("dl.item:eq(0)");
    wrap.hide().siblings("dl.item").show();
    var editBox=$("#educations-list .edit-box")
    editBox.insertAfter(wrap);
    editBox.show();
    $("input[name='id']",editBox).val($(".id",wrap).val());
    $("input[name='school']",editBox).unbind("input propertychange")
    $("input[name='school']",editBox).val($(".school",wrap).text())
    $("input[name='major']",editBox).unbind("input propertychange")
    $("input[name='major']",editBox).val($(".major",wrap).text())
    $("select[name='graduation_year']",editBox).val($(".graduation_year",wrap).text())
    $("select[name='type_id']",editBox).val($("input[name='type_id']",wrap).val())
    initEducationForm();
    InitMajorMatch();
    InitSchoolMatch();
})

$("#educations-list").on("click",".btn.cancel",function(){
    $(this).parents(".edit-box:eq(0)").hide();
    $(this).parents(".edit-box:eq(0)").prev("dl.item").show();
})




$("#add-education").click(function(){
    if($("#educations-list .edit-box:visible").length==0){
        $("#educations-list dl").show()
        var editBox=$("#educations-list .edit-box:eq(0)");
        editBox.insertBefore("#educations-list dl.item:eq(0)");
        editBox.show();
        editBox.find("form")[0].reset();
        initEducationForm();
    }else{
        $public.confirm({
            title:"提醒",
            msg:"当前正在编辑其他工作经验，确认要创建新的工作经验",
            fn:function(){
                $("#educations-list dl").show()
                var editBox=$("#educations-list .edit-box:eq(0)");
                editBox.insertBefore("#educations-list dl.item:eq(0)");
                editBox.show();
                editBox.find("form")[0].reset();
                initEducationForm();
            }
        })
    } 
})
$("#educations-list").on("click",".del",function(){
    var editBox=$(this).parents(".edit-box:eq(0)");
    var item=$(this).parents(".edit-box:eq(0)").prev(".item");
    var id=$(this).parents("form:eq(0)").find("input[name='id']").val();
    
    $public.confirm({
        title:"删除教育经历",
        msg:"确认删除该教育经历",
        fn:function(){
            $public.post({
                url:"/resume/educations/delete.json",
                data:{"id":id},
                successFn:function(){
                    item.remove();
                    editBox.hide();
                }
            })
        }
    })
    
    
})
$("#state-select").change(function(){
    var status=$(this).val();
    $public.post({
        url:"/resume/work-status/update.json",
        data:{"status":status},
        successFn:function(){
            $public.tip("修改成功")
        }
    })
})

$public.Validform({
    obj:$("#updateInfo"),
    fn:function(curform){
        var item=$public.getFormData(curform);
        var live_city=item.live_city;
        item.live_city={
            id:item.live_city
        }
        var expect_city=item.expect_city;
        item.expect_city={
            id:expect_city
        }
        var experience=item.experience;
        item.experience={
            id:experience,
            name:$("[name='experience'] option:selected",curform).text()
        }
        var education=item.education;
        item.education={
            id:education,
            name:$("[name='education'] option:selected",curform).text()
        }
        $public.postJson({
            url:"/resume/main/update",
            data:item,
            successFn:function(){
                $("#res-base-info").show();
                $("#edit-base-info").hide()
                $("#baseInfo [name='name']").val(item.name);
                $("#res-base-info .name").text(item.name);
                $("#baseInfo [name='sex']").val(item.sex);
                $("#baseInfo [name='live_city']").val(item.live_city.id);
                $("#baseInfo [name='live_province']").val(item.live_province);
                $("#baseInfo [name='expect_city']").val(item.expect_city.id);
                $("#baseInfo [name='expect_province']").val(item.expect_province);
                $("#baseInfo [name='email']").val(item.email);
                $("#res-base-info .email").text(item.email);
                $("#baseInfo [name='phone']").val(item.phone);
                $("#res-base-info .phone").text(item.phone);
                $("#baseInfo [name='experience']").val(item.experience.id);
                $("#baseInfo [name='education']").val(item.education.id);
                $("#res-base-info .education").text(item.education.name+" / "+item.experience.name);
                $("#baseInfo [name='self_introduction']").val(item.self_introduction);
                $("#res-base-info .self_introduction").text(item.self_introduction);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        })
    }
})
$("#updateInfo .btn.cancel").click(function(){
    $("#res-base-info").show();
    $("#edit-base-info").hide()
})
$("#editbase").click(function(){
    $("#res-base-info").hide();
    $("#edit-base-info").show()
    var $form=$("#updateInfo");
    var $formBase=$("#baseInfo");
    var name=$("[name='name']",$formBase).val()
    $("[name='name']",$form).val(name)
    var sex=$("[name='sex']",$formBase).val()
    $("[name='sex']",$form).map(function(){
        if($(this).val()==sex){
            $(this).prop("checked",true)
        }
    })
    var live_province=$("[name='live_province']",$formBase).val()
    $("[name='live_province']",$form).val(live_province).trigger("change")
    var live_city=$("[name='live_city']",$formBase).val()
    $("[name='live_city']",$form).val(live_city).trigger("change")

    var expect_province=$("[name='expect_province']",$formBase).val()
    $("[name='expect_province']",$form).val(expect_province).trigger("change")
    var expect_city=$("[name='expect_city']",$formBase).val()
    $("[name='expect_city']",$form).val(expect_city).trigger("change")

    var email=$("[name='email']",$formBase).val()
    $("[name='email']",$form).val(email)
    
    var phone=$("[name='phone']",$formBase).val()
    $("[name='phone']",$form).val(phone)
    
    var experience=$("[name='experience']",$formBase).val()
    $("[name='experience']",$form).val(experience);

    var education=$("[name='education']",$formBase).val()
    $("[name='education']",$form).val(education);

    var self_introduction=$("[name='self_introduction']",$formBase).val()
    $("[name='self_introduction']",$form).val(self_introduction);

})

$(document).click(function(){
    $(".time-box").remove()
})
$("body").on("click",".time-drop",function(e){
    e.stopPropagation();
    var form=$(this).parents("form:eq(0)")
    var startTime=$(".start-time",form).val()
    var endTime=$(".end-time",form).val()
    
    var yearVal=null;
    var monthVal=null;
    if($(this).val()!=""){
        yearVal=$(this).val().split("-")[0];
        monthVal=$(this).val().split("-")[1];
    }
    var type=""
    if($(this).hasClass("start-time")){
        type="start"
    }else if($(this).hasClass("end-time")){
        type="end"
    }
    $(".time-box").remove()
    var year_list="";
    var month_list=""
    var year=new Date().getFullYear();
    for(let i=year;i>1990;i--){
        if(yearVal-i==0){
            year_list+=`<li class="on">${i}</li>`  
        }else{
            year_list+=`<li>${i}</li>`
        }
    }
    for(let i=1;i<=12;i++){
        
        if(monthVal-i==0){
            month_list+=`<li class="on">${i}月</li>`
        }else{
            month_list+=`<li>${i}月</li>`
        }
    }
    var $html=`<div class="time-box">
        <ul class="year-list">
            ${year_list}
        </ul>
        <div class="month-list">
            <ul>
                ${month_list}
            </ul>
        </div>
    </div>` 
    $(this).after($html)
    $(".time-box .year-list li").click(function(e){
        e.stopPropagation();
        $(".month-list li",timeBox).unbind("click")
        var $year=$(this).text()
        var timeBox=$(this).parents(".time-box");
        $(this).addClass("on").siblings(".on").removeClass("on");
        $(".month-list li",timeBox).bind("click",function(e){
            e.stopPropagation();
            var $month=$(this).index()+1;
            if($month<10){
                $month="0"+$month
            }
            $(this).addClass("on").siblings(".on").removeClass("on");
            if(type=="start"){
                startTime=$year+"-"+$month
            }else if(type=="end"){
                endTime=$year+"-"+$month
            }
            var $startTime=new Date(startTime).getTime()
            var $endTime=new Date(endTime).getTime()
            if($startTime<=$endTime||startTime==""||endTime==""){
                timeBox.siblings(".time-drop").val($year+"-"+$month).trigger("input")
                setTimeout(function(){
                    timeBox.hide()
                },1)
            }else{
                timeBox.hide()
                $public.tip("开始时间请小于结束时间")
            }
        })
    })
    if($(".time-box .year-list li.on").length==0){
        $(".time-box .year-list li:eq(0)").click()
    }else{
        $(".time-box .year-list li.on").click()
    }
})

$("#experience-list").on("input","input[name='hire_date'],input[name='leaving_date']",function(){
    var item=$(this).parents(".group-input:eq(0)");
    var leaving_date=$("input[name='leaving_date']",item).val();
    var hire_date=$("input[name='hire_date']",item).val();
    if(leaving_date!=""&&hire_date!=""){
        item.find(".hide-val").val(leaving_date+"_"+hire_date)
    }else{
        item.find(".hide-val").val("")
    }
})
$("input[name='hire_date'],input[name='leaving_date']","#experience").trigger("input");
$public.get({
    url:"/commons/cities.json",
    successFn:function(data){
        let provinceHtml=`<option >请选择省</option>`;
        for(let i=0;i<data.length;i++){
            provinceHtml+=`<option value="${data[i].id}">${data[i].name}</option>`;
        }
        $(".province-select").html(provinceHtml)
        $(".province-select").each(function(){
            $(this).change(function(){
                var wrap=$(this).parents("dl:eq(0)");
                var index=$(".province-select option:selected",wrap).index()-1
                let cityHtml=`<option value="">请选择城市</option>`;
                if(index>=0){
                    for(let i=0;i<data[index].children.length;i++){
                        cityHtml+=`<option value="${data[index].children[i].id}">${data[index].children[i].name}</option>`;
                    }
                }
                $(".city-select",wrap).html(cityHtml).trigger("change");
                $(".city-select",wrap).change(function(){
                    $(this).parents("dl:eq(0)").find(".hide-val").val($(this).val())
                })
            });
        })
        $(".city-select").trigger("change");
        $(".province-select").trigger("change");
        

        var provinceId=$(".province-select").siblings("input").val();
        var cityId=$(".city-select").siblings("input").val();

        $(".province-select").each(function(){
            var provinceId=$(this).siblings("input").val();
            if(provinceId!=""){
                $(this).val(provinceId).trigger("change");
            }
        })
        $(".city-select").each(function(){
            var cityId=$(this).siblings("input").val();
            if(cityId!=""){
                $(this).val(cityId).trigger("change");
            }
        })
    }
})

$("#btn-select-resume").click(function(){
    var item=$(this).next(".select-resume-item")
    item.toggleClass("show");
    if(item.hasClass("show")){
        $(this).addClass("drop")
    }else{
        $(this).removeClass("drop")
    }
    $("li",item).click(function(){
        var type=$(this).attr("data-id");
        var typeName=$(this).text();
        $(this).addClass("on").siblings("li").removeClass("on")
        $public.post({
            url:"/resume/delivery/default.json",
            data:{type:type},
            successFn:function(){
                $("#typeName").text(typeName)
            }
        })
    })
})
if($("#upload_resume:visible").length>0){
    $public.upLoadFile({
        url:"/resume/attachment/upload.json",
        btn:"#upload_resume",
        successFn:function(data){
           location.reload()
        }
    })
}
$("#del_resume").click(function(){
    $public.post({
        url:"/resume/attachment/delete.json",
        data:"",
        successFn:function(){
            location.reload()
        }
    })
})




