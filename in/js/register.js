$public.Validform({
    obj:$("#reg"),
    fn:function(curform){
        $public.postJson({
            url:"/register",
            data:$public.getFormData($("#reg")),
            successFn:function(data){
                location.href=data.next;
            },
            erroFn:function(code){
                var msg=$public.AjaxErro(code)
                $("#reg").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        });
    }
})
function GetCode(obj){
    $(obj).click(function(){
        var phone=$("input[name='phone']").val();
        var code=$("input[name='code']").val();        
        if(phone!=""&&code!=""){
            var data={
                phone:phone,
                image_code:code
            }
            $public.Verification({
                obj:$(this),
                url:"/register/code",
                data:data,
                fn:function(){
                    $("#img-code").attr("src",$("#img-code").attr("src")+Math.random());
                }
            })
        }else{
            $(this).parents("form").find(".total-erro").remove()
            $(this).parents("form").prepend(`<p class="total-erro"><i class="erro-icon"></i>请填写手机号和图形验证码后获取验证码</p>`);
        }
    })
}
GetCode("#phone_validate")
