function QuerySchedule(scheduleType=2){
    $public.get({
        url:"/companies/schedule/list.json",
        data:{schedule:scheduleType,size:10},
        successFn:function(data){
            var schedule=data.schedule
            if(schedule.length>0){
                $("#default-box").html("")
                var html=""
                for(let i=0;i<schedule.length;i++){
                    var item=schedule[i]
                    html+=`<tr>
                        <td>${moment(item.schedule_date).format('MM月DD日 dddd HH:mm')}</td>
                        <td><span class="sign">${item.name}</span></td>
                        <td>${item.mobile}</td>
                        <td>${item.job_name}</td>
                    </tr>`
                }
                $("#schedule-table tbody").html(html)
            }else{
                $("#schedule-table tbody").html("")
                var msg="今天暂无面试安排"
                if(scheduleType==1){
                    msg="过去无面试安排"
                }else if(scheduleType==2){
                    msg="今天暂无面试安排"
                }else if(scheduleType==3){
                    msg="未来暂无面试安排"
                }
                UnusualState({
                    obj:"#default-box",
                    top:"100px",
                    msg:msg,
                })  
            }
        }
    })
}
$("#schedule-tab li").click(function(){
    $(this).addClass("on").siblings("li").removeClass("on")
    var id=$(this).attr("data-id");
    QuerySchedule(id);
})
$("#company-resume").submit(function(){
    var q=$("[name='q']",this).val()
    location.href="/companies/resumes"+LocationSearch("q")+"q="+encodeURI(q)
    return false;
})
