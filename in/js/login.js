$public.Validform({
    obj:$("#login"),
    fn:function(curform){
        $public.postJson({
            url:"/login",
            data:$public.getFormData($("#login")),
            successFn:function(data){
                location.href=data.next;
            },
            erroFn:function(code){
                var msg=$public.AjaxErro(code)
                $("#login").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        });
    }
})
