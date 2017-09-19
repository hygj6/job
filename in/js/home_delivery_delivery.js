function CreateInfo({
    obj="",
    data={}
}){
    var stateHtml=""
    var infoHtml=""
    var infoList=[]
    for(let i=0;i<4;i++){
        var msg=""
        var state=""
        if(i<data.length){
            var active=""
            if(i==data.length-1){
                active="active"
            }
            var item=data[i]
            switch (item.label){
            	case "SUCCESS":
                    msg="投递成功"
                    infoList.unshift(`<dd>
                        <p class="view-time">${moment(item.date).format('YYYY-MM-DD HH:mm:ss')}</p>
                        <p class="${active}">已成功接收你的简历</p>
                    </dd>`)
                    break;
                case "EXAMINE":
                    msg="简历被查看"
                    infoList.unshift(`<dd>
                        <p class="view-time">${moment(item.date).format('YYYY-MM-DD HH:mm:ss')}</p>
                        <p class="${active}">查看了你的简历</p>
                    </dd>`)
                    break;
                
                case "INTERVIEW":
                    msg="面试"
                    infoList.unshift(`<dd>
                        <p class="view-time">${moment(item.date).format('YYYY-MM-DD HH:mm:ss')}</p>
                        <p class="${active}">${item.companyAddress}给你发来面试邀请</p>
                        <p>面试时间：${moment(item.interviewDate).format('YYYY-MM-DD HH:mm:ss')}</p>
                        <p>联系人：${item.companyAddress}</p>
                        <p>联系电话：${item.contactPhone}</p>
                        <p>面试地点：${item.companyAddress}</p>
                    </dd>`)
                    break;
                    
            	case "TO_BE_COMMUNICATED":
            	    msg="待沟通"
            	    infoList.unshift(`<dd>
                        <p class="view-time">${moment(item.date).format('YYYY-MM-DD HH:mm:ss')}</p>
                        <p class="${active}">你的简历已经通过初筛，企业可能会在近期与你沟通，请保持联系方式畅通</p>
                    </dd>`)
            		break;
                case "INTERVIEWED":
                    msg="已面试"
                    infoList.unshift(`<dd>
                        <p class="view-time">${moment(item.date).format('YYYY-MM-DD HH:mm:ss')}</p>
                        <p class="${active}">你投递的简历已被对方标记为：${msg}</p>
                    </dd>`)
                    break;
                case "TO_BE_USED":
                    msg="待录用"
                    infoList.unshift(`<dd>
                        <p class="view-time">${moment(item.date).format('YYYY-MM-DD HH:mm:ss')}</p>
                        <p class="${active}">你投递的简历已被对方标记为：${msg}</p>
                    </dd>`)
                    break;
                case "TO_BE_ENTRY":
                    msg="待入职"
                    infoList.unshift(`<dd>
                        <p class="view-time">${moment(item.date).format('YYYY-MM-DD HH:mm:ss')}</p>
                        <p class="${active}">你投递的简历已被对方标记为：${msg}</p>
                    </dd>`)
                    break;
                case "HAS_BEEN_ADMITTED":
                    msg="已入职"
                    infoList.unshift(`<dd>
                        <p class="view-time">${moment(item.date).format('YYYY-MM-DD HH:mm:ss')}</p>
                        <p class="${active}">你投递的简历已被对方标记为：${msg}</p>
                    </dd>`)
                    break;
                case "INAPPROPRIATE":
                    msg="不合适"
                    infoList.unshift(`<dd>
                        <p class="view-time">${moment(item.date).format('YYYY-MM-DD HH:mm:ss')}</p>
                        <p class="${active}">你投递的简历已被对方标记为：${msg}</p>
                    </dd>`)
                    break;
            	default:
            		break;
            }
            state="on"
        }else{
            switch (i){
                case 0:
                    msg="投递成功"
                    break;
                case 1:
                    msg="被查看"
                    break;
                case 2:
                    msg="待沟通"
                    break;
                case 3:
                    msg="面试"
                    break;
                default:
                    break;
            }
        }
        stateHtml+=`<dd class="${state}">
                <i class="icon"></i>
                <p>${msg}</p>
            </dd>`;
    }
    infoHtml=infoList.join("")
    var html=`<div class="detailed-block">
        <dl class="state-step">
            ${stateHtml}
            <dt class="line"></dt>
        </dl>
        <dl class="view-list">
            ${infoHtml}
            <dt></dt>
        </dl>
    </div>`
    $(".detailed-block",obj).remove()
    obj.append(html)
}
$("#res-list li .drop-btn").click(function(){
    if(!$(this).hasClass("on")){
        var id=$(this).parents("li:eq(0)").attr("data-id");
        $(this).addClass("on")
        $public.postJson({
            url:"/resume/delivery/"+id,
            data:"",
            successFn:(data)=>{
                CreateInfo({
                    obj:$(this).parents("li:eq(0)"),
                    data:data
                })
            }
        })
        
        
    }else{
        $(this).removeClass("on")
        $(this).parents("li:eq(0)").find(".detailed-block").remove()
    }
})
