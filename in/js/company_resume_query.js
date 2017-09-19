$("#company-resume").submit(function(){
    var q=$("[name='q']",this).val()
    location.href=location.pathname+LocationSearch("q")+"q="+q
    return false
})
$("#jobCategory").change(function(){
    var job_id=$(this).val()
    location.href=location.pathname+LocationSearch("job_id")+"job_id="+job_id
})
var newWin=null;
$(".create-conversation").click(function(){
    if(newWin){
        newWin.close()
    }
    newWin =window.open('/companies/conversations');
    var candidate=$(this).attr("data-id")
    var job=$("#jobCategory").val()
    var $CurrentJobId=CurrentJobId
    if(CurrentJobId==0){
        $CurrentJobId=$("#jobCategory option:eq(1)").attr("value")
    }
    $public.post({
        url:"/companies/conversations/create.json",
        data:{
            "candidate":candidate,
            "job":$CurrentJobId
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
