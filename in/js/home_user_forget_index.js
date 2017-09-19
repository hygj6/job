$public.Validform({
    obj:$("#forget"),
    fn:function(curform){
        var data=$public.getFormData($("#forget"));
        $public.post({
            url:"/forget/token.json",
            data:data,
            successFn:function(data){
                location.href=data.next;
            },
            erroFn:function(code){
                var msg;
                if(code=="InvalidPhoneCode"){
                    if((data.phone).indexOf("@")>=0){
                        msg="邮箱验证码错误"
                    }else{
                        msg="手机验证码错误"
                    }
                }else{
                    msg=$public.AjaxErro(code)
                }
                $("#forget").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        });
    }
})
function GetCode(obj){
    $(obj).click(function(){
        var data={
            phone:$("input[name='phone']").val(),
            image_code:$("input[name='image_code']").val()
        }
        if(data.phone!=""&&data.image_code){
            $public.Verification({
                obj:$(this),
                url:"/forget/code",
                data:data,
                fn:function(){
                    $("#img-code").attr("src",$("#img-code").attr("src")+Math.random());
                    $("#forget [name='phone_code']").next(".erro_msg").remove()
                    if((data.phone).indexOf("@")>=0){
                        $("#forget [name='phone_code']").after(`<div style="color: #00b38a;" class="erro_msg serious-error"><i class="icon-erro"></i>请用邮箱查收验证码</div>`);
                    }else{
                        $("#forget [name='phone_code']").after(`<div style="color: #00b38a;" class="erro_msg serious-error"><i class="icon-erro"></i>请用手机查收验证码</div>`);
                    }
                }
            })
        }else{
            $(this).parents("form").find(".total-erro").remove()
            $(this).parents("form").prepend(`<p class="total-erro"><i class="erro-icon"></i>请填写手机号/邮箱和图形验证码后获取验证码</p>`);
        }
    })
}
GetCode("#phone_validate")