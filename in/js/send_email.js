$("#send-email").click(function(){
    $public.getJson({
        url:"/companies/apply/send-email",
        data:"",
        successFn:function(){
            alert("邮件已发送，请查收")
        },
        erroFn:function(code){
            if(code=="Busy"){
                alert("发送频繁")
            }else if(code=="GoneException"){
                alert("资源不可用")
            }
        }
    })
})
