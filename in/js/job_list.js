function JobState(data){
    $public.postJson({
        url:"/companies/job-status/update",
        data:data,
        successFn:function(data){
            location.reload();
        }
    })
}
$(".job-state a").click(function(){
    JobState({
        id:$(this).parents("li:eq(0)").attr("data-id"),
        job_status:$(this).attr("data-type")
    })
})
$("#search-job").submit(function(){
    var keywords=$("input[name='keywork']",this).val()
    location.href=location.pathname+LocationSearch("keywords")+"keywords="+keywords+'&page=1'
    return false;
})
$(".refresh-job").click(function(){
    if($(this).hasClass("enable")){
        var id=$(this).parents("li:eq(0)").attr("data-id");
        $public.postJson({
            url:`/companies/job/${id}/refresh`,
            data:{"id":id},
            successFn:function(){
                $public.tip("刷新成功")
            },
            erroFn:function(code){
                if(code=="JobNotPermission"){
                    $public.tip("当前已经刷新过了，无需刷新")
                }else{
                    $public.tip($public.AjaxErro(code))
                }
            }
        })
    }else{
        $public.tip("当前已经刷新过了，无需刷新")
    }
})


$("#refresh-all-job").click(function(){
    $public.confirm({
        title:"刷新职位",
        msg:"你是否要刷新所有职位",
        fn:function(){
            $public.postJson({
                url:`/companies/job/refresh`,
                successFn:function(){
                    $public.tip("批量刷新成功")
                }
            })
        },
        sure:"刷新"
    })
    
})
$(".unauthorized").click(function(){
    $("#activation").remove()
    var html=`<div id="activation" class="modal-backdrop">
            <div class="modal-dialog" style="width: 460px;">
                <div class="modal-header">
                                          帮手网+特权<span class="tag">未激活</span>
                <i class="icon off"></i>
                </div>
                <div class="modal-cont activation-cont">
                    <p style="color:#333; line-height: 46px; padding-top: 2px;">职位发布数量已达上限，升级帮手网+将享受以下特权</p>
                    <div class="mod-list">
                        <ul>
                            <li><i class="index">1</i>在线/发布职位<span>上限 × 100</span></li>
                            <li><i class="index">2</i>每天<span>300次</span>主动沟通次数</li>
                            <li><i class="index">3</i>提升职位曝光，猛增投递量</li>
                            <li><i class="index">4</i>职位每日刷新，保持新鲜度</li>
                            <li><i class="index">5</i>全库海量人才任你挑</li>
                        </ul>
                    </div>
                    <a href="#" class="btn">了解详情</a>
                    <div class="blank-2"></div>
                </div>
            </div>
        </div>`
    $("body").append(html)
    $public.showDialog("#activation")
})
