$public.Validform({
    obj:$("#reset"),
    fn:function(curform){
        $public.postJson({
            url:"/forget/reset",
            data:$public.getFormData($("#reset")),
            successFn:function(data){
                location.href=data.next;
            },
            erroFn:function(code){
                var msg=$public.AjaxErro(code)
                $("#reset").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        });
    }
})



















