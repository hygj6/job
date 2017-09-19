function InsertResumeList(data,fn){
    $public.post({
        url:"/companies/resume/list",
        data:data,
        successFn:function(data){
            var ResumesList=data.resumes;
            var $html=""
            if(ResumesList.length>0){
                $("#res").show();
                $("#no-res").hide();
                for(let i=0;i<ResumesList.length;i++){
                    
                    var resume=ResumesList[i];
                    var OnlineState=""
                    if(!resume.isRead){
                        OnlineState="on"
                    }
                    $html+=`<div data-job="${resume.jobId}" data-deliveryway="${resume.deliveryWay}" data-attachmentpdf="${resume.attachmentPdf}" data-id="${resume.id}" class="item">
                                <i class="state ${OnlineState}"></i>
                                <div class="avatar">
                                    <img width="50" height="50" src="${resume.avatar}"/>
                                </div>
                                <div class="text" data-id = "${resume.id}">
                                    <p class="name">${resume.name} · ${resume.category} </p>
                                    <p>${moment(resume.createDate).format('YYYY/MM/DD')}</p>
                                </div>
                            </div>`
                }
                if(data.page>1){
                    $("#resume-list .scroll-wrap").append($html)
                }else{
                    $("#resume-list .scroll-wrap").html($html)
                    $("#resume-list .item:eq(0)").trigger("click")
                }
                fn();
            }else{
                $("#res").hide();
                $("#no-res").show();
                $("#resume-list .scroll-wrap").html("")
                $(".interview-info").html("")
                UnusualState({
                    obj:"#no-res",
                    top:"100px",
                    msg:"您还没有收到简历，开通帮手网+特权能提高曝光率",
                    btnLabel:"了解详情"
                })
            }
        }
    })
}
var page=0
$("#resume-list").scroll(function(){
    if($(this).data("lock")!=1&&$(this).scrollTop()+$(this).height()-$(".scroll-wrap",this).height()>=0){
        page++
        $(this).data("lock",1)
        InsertResumeList({
            page:page,
            size:10
        },()=>{
            $(this).data("lock",0)
        });
    }
})
$("#resume-list").on("click",".item",function(){
    var id=$(this).attr("data-id")
    $(this).addClass("on").siblings(".on").removeClass("on")
    $public.get({
        url:"/companies/resume",
        data:{id:id},
        successFn:function(data){
            $(".interview-info").html(data)
            selectCustom(".interview-info .select-custom");
            $(".interview-info [name='id']").val(id)
            $public.addressSelect({
                obj:$("#address")
            })
        }
    })
    if($(this).attr("data-deliveryway")==1){
        $("#download").attr("href","/companies/manage/resume/download?id="+id)
    }else{
        $("#download").attr("href",$(this).attr("data-attachmentpdf"))  
    }      
})
$("#resume-list .item:eq(0)").click()
$(".interview-info").on("change","[name='interviewState']",function(){
    var id=$(".interview-info [name='id']").val();
    var interviewState=$(this).val()
    var item=$("#resume-list [data-id='"+id+"']");
    var state=$("#type-tab li.on").attr("data-status");
    if(state!=interviewState){
        $public.post({
            url:"/companies/resume/state/update.json",
            data:{
                "id":id,
                "interview_status":interviewState
            },
            successFn:function(){
                var nub=$("#type-tab li.on .nub").text()
                $("#type-tab li.on .nub").text(nub-1)
                var nub1=parseInt($("#type-tab li[data-status='"+interviewState+"'] .nub").text());
                $("#type-tab li[data-status='"+interviewState+"'] .nub").text(nub1+1)
                if(item.next(".item").length>0){
                    item.next(".item").click();
                    item.remove()
                }else if(item.prev(".item").length>0){
                    item.prev(".item").click();
                    item.remove()
                }else{
                    $("#type-tab li.on").click()
                }
                $public.tip("修改成功")
            }
        })
    }
})
$(".interview-info").on("click","#eliminate-btn",function(){
    $public.showDialog($("#eliminate-box"),function(){
        var id=$(".interview-info [name='id']").val();
        $("#eliminate-box form [name='id']").val(id);
        $public.postJson({
            url:"/companies/eliminate/list",
            data:"",
            successFn:function(data){
                var tabHtml="";
                for(let i=0;i<data.length;i++){
                    tabHtml+=`<label class="item">
                                <label class="radio-label">
                                <input data-index="${i}" value="${data[i].title}" name="title" type="radio"/><i></i></label>
                                ${data[i].title}
                                </label>`
                }
                $("#eliminate-box .eliminate-tab").html(tabHtml)
                $("#eliminate-box [name='title']").change(function(){
                    var index=$(this).attr("data-index");
                    $("#eliminate-box [name='description']").val(data[index].description);
                })
                $("#eliminate-box [name='title']:eq(0)").prop("checked",true).trigger("change")
            }
        })
    })
})
$public.Validform({
    obj:$("#eliminate-box form"),
    fn:function(curform){
        var data=$public.getFormData($("#eliminate-box form"));
        var id=data.id
        var item=$("#resume-list [data-id='"+id+"']");
        $public.postJson({
            url:"/companies/resume/eliminate",
            data:data,
            successFn:function(){
                var nub=$("#type-tab li.on .nub").text()
                $("#type-tab li.on .nub").text(nub-1)
                var nub1=parseInt($("#type-tab li[data-status='INAPPROPRIATE'] .nub").text());
                $("#type-tab li[data-status='INAPPROPRIATE'] .nub").text(nub1+1)
                $public.offDialog();
                if(item.next(".item").length>0){
                    item.next(".item").click();
                    item.remove()
                }else if(item.prev(".item").length>0){
                    item.prev(".item").click();
                    item.remove()
                }else{
                    $("#type-tab li.on").click()
                }
                $public.tip("修改成功")
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        })
    }
})
$(".interview-info").on("click","#invitation-btn",function(){
    $public.showDialog($("#invitation-box"),function(){
        $("#invitation-box form")[0].reset()
        var html=`<dl>
                <dd>
                    <input ignore="ignore" data-top="-10" datatype="e" nullmsg="请输入面试官邮箱" errormsg="请输入正确的面试官邮箱" name="emails" placeholder="面试官邮箱" style="width:180px;" class="input-text" type="text"/>
                </dd>
                <dd>
                    <input ignore="ignore" data-top="-10" datatype="m" nullmsg="请输入面试官手机" errormsg="请输入正确的面试官手机" name="mobiles" placeholder="面试官手机号" style="width:180px;" class="input-text" type="text"/>
                </dd>
            </dl>`
        $("#interviewer-list").html(html)
    })
})
$public.Validform({
    obj:$("#invitation-box form"),
    fn:function(curform){
        var emails=$("#invitation-box form [name='emails']").map(function(){
                if($(this).val()!=""){
                    return $(this).val()
                }
            }).get().toString()
        var mobiles=$("#invitation-box form [name='mobiles']").map(function(){
                if($(this).val()!=""){    
                    return $(this).val()
                }
            }).get().toString()
        var data={}
        if(emails.length>0){
            data={
                id:$(".interview-info [name='id']").val(),
                interview_date:$("#invitation-box form [name='interview_date']").val(),
                emails:emails
            }
        }else if(mobiles.length>0){
            data={
                id:$(".interview-info [name='id']").val(),
                interview_date:$("#invitation-box form [name='interview_date']").val(),
                mobiles:mobiles
            }
        }else if(mobiles.length>0&&emails.length>0){
            data={
                id:$(".interview-info [name='id']").val(),
                interview_date:$("#invitation-box form [name='interview_date']").val(),
                emails:emails,
                mobiles:mobiles
            }
        }else{
            data={
                id:$(".interview-info [name='id']").val(),
                interview_date:$("#invitation-box form [name='interview_date']").val()
            }
        }
        var time=data["interview_date"];
        if(new Date(moment(time).format('YYYY/MM/DD HH:mm:ss')).getTime()-new Date().getTime()>40*60*1000){
            $public.post({
                url:"/companies/schedule/add.json",
                data:data,
                successFn:function(){
                    $public.offDialog();
                },
                erroFn:function(code){
                    if(code=="InterviewInfoNotFound"){
                        $("#invitation-box [name='interview_date']").after(`<div style="margin-top:-10px" class="erro_msg serious-error"><i class="icon-erro"></i>
                        <a target="_blank" href="/companies/setting/template/interview">需要设置面试模板,才可邀请 <span style="text-decoration: underline;">点击设置</span></a></div>`)
                    }
                },
                alwaysFn:function(curform){
                    $("button[type='submit']",curform).prop("disabled",false);
                }
            })
        }else{
            $("#invitation-box [name='interview_date']").next(".erro_msg").remove()
            $("#invitation-box [name='interview_date']").after(`<div style="margin-top:-10px" class="erro_msg serious-error"><i class="icon-erro"></i>时间请大于当前时间40分钟</div>`)
        }
    }
})
$("#interviewer-list").on("click",".del",function(){
    $(this).parents("dl:eq(0)").remove()
})
$("#add-interviewer").click(function(){
    var html=`<dl>
                <dd>
                    <input name="emails" placeholder="面试官邮箱" style="width:180px;" class="input-text" type="text"/>
                </dd>
                <dd>
                    <input name="mobiles" placeholder="面试官手机号" style="width:180px;" class="input-text" type="text"/>
                </dd>
                <dd><a class="del" href="javascript:void(0)">删除本条</a></dd>
            </dl>`
    $("#interviewer-list").append(html)
})
$(".interview-info").on("click","#base-info .edit",function(){
    $("#base-info .edit-box").show();
    $("#base-info .text-box").hide();
    $public.Validform({
        obj:$("#base-resume"),
        fn:function(curform){
            var data=$public.getFormData($("#base-resume"));
            $public.postJson({
                url:"/companies/resume/update",
                data:data,
                successFn:function(){
                    $("#base-info .edit-box").hide();
                    $("#base-info .text-box").show();
                    var resbox=$("#base-info #baseInitInfo");
                    var textbox=$("#base-info .text-box")
                    data["provinceName"]=QueryCity(data.resume_live_city_id)
                    data["experienceName"]=$("#base-resume [name='resume_experience_id'] option:selected").text()
                    data["educationName"]=$("#base-resume [name='resume_education_id'] option:selected").text()
                    for(let item in data){
                        $("[name='"+item+"']",resbox).val(data[item]);
                        $(".vm-"+item).text(data[item])
                    }
                },
                alwaysFn:function(curform){
                    $("button[type='submit']",curform).prop("disabled",false);
                }
            })
        }
    })
    //绑定
    var baseInitInfo=$public.getFormData($("#baseInitInfo"));
    var editBox=$("#base-info .edit-box");
    for(let item in baseInitInfo){
        $("[name='"+item+"']",editBox).val(baseInitInfo[item]);
    }
    $public.SetAddressSelect({
        obj:$("#address",editBox),
        province_id:baseInitInfo.province_id,
        city_id:baseInitInfo.resume_live_city_id
    })
    //绑定
})
var newWin=null;
$(".interview-info").on("click",".chat-btn",function(){
    if(newWin){
        newWin.close()
    }
    newWin =window.open('/companies/conversations');
    var CurrentJobId=$("#resume-list .item.on").attr("data-job");
    var candidate=$(this).attr("data-id")
    var job=$("#jobCategory").val()
    $public.post({
        url:"/companies/conversations/create.json",
        data:{
            "candidate":candidate,
            "job":CurrentJobId
        },
        successFn:function(data){
            newWin.location.href = '/companies/conversations?id='+data.id;
        },
        erroFn:function(code){
            $public.tip($public.AjaxErro(code))
            newWin.close()
        }
    })
})
$(".interview-info").on("click","#base-info .btn.cancel",function(){
    $("#base-info .edit-box").hide();
    $("#base-info .text-box").show();
})
var interview_status=""
var categoriesId=""
$("#type-tab li").click(function(){
    $(this).addClass("on").siblings(".on").removeClass("on")
    interview_status=$(this).attr("data-status")    
    InsertResumeList({
        category_id:categoriesId,
        interview_status:interview_status,
        page:1,
        size:10
    },()=>{
        $(this).data("lock",0)
    });
})
$("#categories-tab dd").click(function(){
    $(this).addClass("on").siblings(".on").removeClass("on")
    categoriesId=$(this).attr("data-id");
    InsertResumeList({
        category_id:categoriesId,
        interview_status:interview_status,
        page:1,
        size:10
    },()=>{
        $(this).data("lock",0)
    });
})
$("#type-tab li:eq(0)").click()
$("body").on("click","#print",function(){
    $(".resume-cont").insertBefore(".header-company")
    $(".header-company,.company-cont").hide()
    window.print()
    $(".header-company,.company-cont").show()
    $(".resume-cont").insertAfter(".info-bar")
})
