CreateResumeDelivery.Init();
$("#delivery").click(function(){
    CreateResumeDelivery.BaseSet({
        job_id:job_id,
        url:"/resume/delivery",
        SuccessDelivery:function(data){
            $("#delivery").prop("disabled",true).text("已投递")
            $public.showDialog($("#WithdrawBox"));
            CannelDelivery();//撤回功能
            DeliveryId=data.id;
            $("#WithdrawBox .btn").click(function(){
                $public.offDialog();
            })
        }
    })
    CreateResumeDelivery.SubmitResume({
        data:{
            "job_id":job_id
        }
    })
})
function CannelDelivery(){
    var time=10;
    var timer=setInterval(function(){
        time--;
        $("#cannel-delivery .nub").text(time)
        if(time==0){
            $("#cannel-delivery").remove();
            clearInterval(timer);
        }
    },1000)
    $("#cannel-delivery").click(function(){
        $public.post({
            url:"/resume/delivery/withdraw.json",
            data:{id:DeliveryId},
            alwaysFn:function($curform){
                $public.showDialog($("#WithdrawSuccessBox"));
                $("#WithdrawSuccessBox .btn").click(function(){
                    $public.offDialog();
                })
            }
        })
    })
}
$("#del_resume").click(function(){
    $public.post({
        url:"/resume/attachment/delete.json",
        data:""
    })
})