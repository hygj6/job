$("#tab-menu li").click(function(){
    var index=$(this).index();
    $(this).addClass("on").siblings("li").removeClass("on")
    $("#tab-cont .other-bind-cont:eq("+index+")").show().siblings(".other-bind-cont").hide()
})
$("#update-password-btn").click(function(){
    $public.showDialog($("#update-password-box"));
})
$public.Validform({//更新密码
    obj:$("#update-password-box form"),
    fn:function(curform){
        $public.postJson({
            url:"/user/security/password/update",
            data:$public.getFormData($("#update-password-box form")),
            successFn:function(data){
                $public.offDialog();
                $public.showDialog($("#update-password-success-box"),function(){
                    $("#update-password-success-box .btn").click(function(){
                        location.href=data.next;
                    })
                    var i=10
                    setInterval(function(){
                        i--;
                        $("#update-password-success-box .nub").text(i)
                        if(i==0){
                            location.href=data.next;
                        }
                    },1000)
                });
            },
            erroFn:function(code){
                var msg=$public.AjaxErro(code)
                $("#update-password-box form").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        });
    }
})
$public.Validform({//更改手机
    obj:$("#update-phone2 form"),
    fn:function(curform){
        $public.postJson({
            url:"/user/security/phone/update",
            data:$public.getFormData($("#update-phone2 form")),
            successFn:function(data){
                $public.offDialog();
                $public.showDialog($("#update-phone-success-box"),function(){
                    $("#update-phone-success-box .btn").click(function(){
                        location.reload()
                    })
                });
            },
            erroFn:function(code){
                var msg=$public.AjaxErro(code)
                $("#update-phone2 form").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        });
    }
})

$("#get-validation").click(function(){
    $public.Verification({
        obj:$(this),
        url:"/user/security/code.json",
        data:{}
    })
})
$("#get-validation2").click(function(){
    var phone=$("#update-phone2 input[name='phone']").val();
    var image_code=$("#update-phone2 input[name='image_code']").val();
    if(phone!=""&&image_code!=""){
        $public.Verification({
            obj:$(this),
            url:"/user/security/phone/code",
            data:{
                "phone":phone,
                "image_code":image_code
            }
        })
    }
    else{
        $(this).parents("form").find(".total-erro").remove()
        $(this).parents("form").prepend(`<p class="total-erro"><i class="erro-icon"></i>请填写手机号和图形验证码后获取验证码</p>`);
    }
})
$public.Validform({
    obj:$("#update-phone form"),
    fn:function(curform){
        $public.post({
            url:"/user/security/token.json",
            data:$public.getFormData($("#update-phone form")),
            successFn:function(data){
                $public.offDialog();
                $public.showDialog($("#update-phone2"),function(){
                    $("#update-phone2 input[name='token']").val(data.token)
                })
            },
            erroFn:function(code){
                var msg=$public.AjaxErro(code)
                $("#update-phone form").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        })
    }
})

$public.Validform({
    obj:$("#security-validation form"),
    fn:function(curform){
        var $data=$public.getFormData($("#security-validation form"))
        $public.post({
            url:"/user/security/token.json",
            data:$data,
            successFn:function(data){
                $public.offDialog();
                
                if($data["edit-type"]==2){
                    $("#create-email form [name='token']").val(data.token)
                    $public.showDialog($("#create-email"),function(){})
                }else{
                    $("#update-phone2 form [name='token']").val(data.token)
                    $public.showDialog($("#update-phone2"),function(){})
                }
            },
            erroFn:function(code){
                var msg=$public.AjaxErro(code)
                $("#security-validation form").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        })
    }
})
$public.Validform({
    obj:$("#create-email form"),
    fn:function(curform){
        $public.postJson({
            url:"/user/security/email/update",
            data:$public.getFormData($("#create-email form")),
            successFn:function(data){
                $public.offDialog();
                $public.showDialog($("#update-email-success-box"),function(){
                    $("#update-email-success-box .btn").click(function(){
                        location.reload()
                        $public.offDialog();
                    })
                })
            },
            erroFn:function(code){
                var msg=$public.AjaxErro(code)
                $("#create-email form").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        })
    }
})
$("#get-email-validation").click(function(){
    var type=$public.getFormData($("#security-validation form")).type;
    $public.Verification({
        obj:$(this),
        url:"/user/security/code.json",
        data:{type:type},
        isJson:false
    })
})
$("#get-email-validation2").click(function(){
    var email=$("#create-email form").find("input[name='email']").val()
    if(email!=""){
        $public.Verification({
            obj:$(this),
            url:"/user/security/email/code.json",
            data:{
                email:email
            },
            isJson:false
        })
    }
    else{
        $(this).parents("form").find(".erro_msg").remove()
        $(this).parents("form").find(".verification-code").after(`<div class="erro_msg serious-error"><i class="icon-erro"></i>请输入邮箱</div>`);
    }
})

$("#update-phone-btn").click(function(){
    $("#security-validation [name='edit-type']").val(1)
    var phone=$(this).attr("data-phone");
    $public.showDialog($("#security-validation"));    
    if($("#security-validation .update-mail-phome-tab .tab-input").length>1){
        $("#security-validation .update-mail-phome-tab .tab-input:eq(0)").prop("checked",true)
    }else{
        $("#security-validation .update-mail-phome-tab .tab-input:eq(0)").prop("checked",true)
    }
    $("#security-validation .update-mail-phome-tab .tab-input:checked").trigger("change")
})
$("#update-email-btn").click(function(){
    $("#security-validation [name='edit-type']").val(2)
    var email=$(this).attr("data-email");
    $public.showDialog($("#security-validation"));
    if($("#security-validation .update-mail-phome-tab .tab-input").length>1){
        $("#security-validation .update-mail-phome-tab .tab-input:eq(1)").prop("checked",true)
    }else{
        $("#security-validation .update-mail-phome-tab .tab-input:eq(0)").prop("checked",true)
    }
    $("#security-validation .update-mail-phome-tab .tab-input:checked").trigger("change")
})



$("#update-mail-tab input[name='type']").change(function(){
    var type=$(this).val()
    var item=$(this).parents("label:eq(0)")
    $("#update-mail-cont").insertAfter(item)
    clearInterval($public.time);
    $("#update-mail-cont .get-validation").prop("disabled",false).text("获取验证码")
    $("#update-mail-cont .erro_msg").remove()
    if(type==2){//邮件
        $("#update-mail-cont .mail-label").show()
        $("#update-mail-cont .phone-label").hide()
        $("#update-mail-cont .verification-code").attr("placeholder","请输入邮箱验证码")
    }else{//手机
        $("#update-mail-cont .mail-label").hide()
        $("#update-mail-cont .phone-label").show()
        $("#update-mail-cont .verification-code").attr("placeholder","请输入手机验证码")
    }
})
