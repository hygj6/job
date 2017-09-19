$public.Validform({
    obj:$("#complete-material"),
    beforeFn:function(){
    },
    fn:function(curform){
        $public.postJson({
            url:"/companies/info-finally",
            data:{
                abbreviation:$("input[name='abbreviation']").val(),
                exhibition:$("#complete-material .js-platform-tags option").map(function(){
                    return $(this).text();
                }).get(),
                industry_id:$("input[name='industry_id']").val(),
                personnels:$("select[name='personnels']").val(),
                summary:$("textarea[name='summary']").val()
            },
            successFn:function(data){
                location.href=data.next
            },
            erroFn:function(code){
                var msg=$public.AjaxErro(code)
                $("#info").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        });
    }
})

$public.upLoadImg({
    url:"/companies/logo/upload.json",
    btn:"#up-logo-botton",
    width:200,
    height:200,
    limitWidth:180,
    limitHeight:180,
    preview:"#preview",
    progressBar:".pic",
    beforeFn:function(){
        $("#up-btn").prop("disabled",true)
    },
    successFn:function(data){
       $("#up-btn").prop("disabled",false)
    }
})

window.IndustryCallback=function({
    id="",
    nameLv1="",
    nameLv2="",
    nameLv3=""
}){
    $public.OffIndustryFrame(id)
    $("#complete-material [name='industry_id']").val(id)
    if(nameLv3!=""){
        $("#complete-material .industry-name").val(`${nameLv1}/${nameLv2}/${nameLv3}`)
    }else{
        $("#complete-material .industry-name").val(`${nameLv1}/${nameLv2}`)
    }
}
$("#complete-material .industry-name").click(function(){
    var id=$("#complete-material [name='industry_id']").val()
    $public.IndustryFrame(id);
})