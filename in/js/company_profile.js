$public.upLoadImg({
    url:"/companies/setting/avatar/upload",
    width:120,
    height:120,
    limitWidth:120,
    limitHeight:120,
    btn:'#upload',
    preview:"#picview"
})
$public.Validform({
    obj:$("#save-profile"),
    fn:function(curform){
        var $data=$public.getFormData($("#save-profile"))
        if(IsEnterpriseMail($data.email)){
            $public.postJson({
                url:"/companies/profile/save",
                data:$data,
                successFn:function(data){
                    $public.tip("保存成功")
                },
                alwaysFn:function(curform){
                    $("button[type='submit']",curform).prop("disabled",false);
                }
            })
        }else{
            $("#save-profile input[name='email']").next(".erro_msg").remove()
            $("#save-profile input[name='email']").after(`<div class="erro_msg serious-error"><i class="icon-erro"></i>不支持公共邮箱，请输入你公司的企业邮箱</div>`);
            $("button[type='submit']","#save-profile").prop("disabled",false);
        }
    }
})