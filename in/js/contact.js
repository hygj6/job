$public.Validform({
    obj:$("#contact"),
    fn:function(curform){
        var $data=$public.getFormData($("#contact"))
        if(IsEnterpriseMail($data.email)){
            $public.postJson({
                url:"/companies/apply/contact",
                data:$data,
                successFn:function(data){
                    window.location.reload();
                },
                erroFn:function(code){
                    var msg=$public.AjaxErro(code)
                    $("#contact").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
                },
                alwaysFn:function(curform){
                    $("button[type='submit']",curform).prop("disabled",false);
                }
            });
        }else{
            $("#contact input[name='email']").next(".erro_msg").remove()
            $("#contact input[name='email']").after(`<div class="erro_msg serious-error"><i class="icon-erro"></i>不支持公共邮箱，请输入你公司的企业邮箱</div>`);
            $("button[type='submit']","#contact").prop("disabled",false);
        }
    }
})