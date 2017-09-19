$("#experience").on("input",".bind",function(){  
    $(this).siblings(".total-erro").remove()
    var data={}
    var $form=$(this).parents("form:eq(0)");
    var id=$("input[name='id']",$form).val();
    var isPass=true;
    data=$public.getFormData($form)
    if(id==""){
        delete data["id"]
        $(".bind",$form).map(function(){
            if($(this).val()==""){
                isPass=false;
            }
        })
    }
    var hire_date=data.hire_date;
    data.hire_date=new Date(hire_date).getTime()
    var leaving_date=data.leaving_date;
    data.leaving_date=new Date(leaving_date).getTime()
    if(isPass){
        if(id!=""){//更新
            $public.postJson({
                url:"/resume/guide/experiences/update",
                data:data,
                successFn:function(data){
                }
            })
        }else{//创建
            if(!$(this).data("lock")){
                $(this).data("lock",true);
                $public.postJson({
                    url:"/resume/guide/educations/create.json",
                    data:data,
                    successFn:function(data){
                        
                    }
                })
            }
        }
    }
})
$("#experience").on("click",".delete",function(){
    var $form=$(this).parents("form:eq(0)");
    var id=$form.find("input[name='id']").val();
    $public.post({
        url:"/resume/guide/experiences/delete.json",
        data:{"id":id},
        successFn:function(data){
            $form.remove();
        }
    })
})
$("#addItem").click(function(){
    $public.post({
        url:"/resume/guide/experiences/create.json",
        successFn:function(data){
            var html=$("#temp").html();
            $("#temp").before(html);
            $("#temp").prev("form").find("input[name='id']").val(data.id)
        }
    })
})
$(".skip").click(function(){
    $public.postJson({
        url:"/resume/guide/main/skip.json",
        successFn:function(data){
            location.href=data.next;
        }
    })
})
$("#nextPage").click(function(){
    var isPass=true;
    $("#experience .bind").map(function(){
        if($(this).parents("#temp").length<=0){            
            if($(this).val()==""){
                var nullmsg=$(this).attr("nullmsg");
                if(nullmsg&&nullmsg!=""){
                    $(this).siblings(".total-erro").remove()
                    $(this).after(`<p class="total-erro"><i class="erro-icon"></i>${nullmsg}</p>`);
                    isPass=false;
                }
            }
        }
    })
    if(isPass){
        location.href=$(this).attr("data-href")
    }
})
$("#nextPage").hover(function(){
    $(".book-corner").addClass("on")
},function(){
    $(".book-corner").removeClass("on")
})
$("#experience").on("input","input[name='hire_date'],input[name='leaving_date']",function(){
    var item=$(this).parents(".group-input:eq(0)");
    var leaving_date=$("input[name='leaving_date']",item).val();
    var hire_date=$("input[name='hire_date']",item).val();
    if(leaving_date!=""&&hire_date!=""){
        item.find(".hide-val").val(leaving_date+"_"+hire_date)
    }else{
        item.find(".hide-val").val("")
    }
})
$(document).click(function(){
    $(".time-box").remove()
})
$("body").on("click",".time-drop",function(e){
    e.stopPropagation();
    var form=$(this).parents("form:eq(0)")
    var startTime=$(".start-time",form).val()
    var endTime=$(".end-time",form).val()
    
    var yearVal=null;
    var monthVal=null;
    if($(this).val()!=""){
        yearVal=$(this).val().split("-")[0];
        monthVal=$(this).val().split("-")[1];
    }
    var type=""
    if($(this).hasClass("start-time")){
        type="start"
    }else if($(this).hasClass("end-time")){
        type="end"
    }
    $(".time-box").remove()
    var year_list="";
    var month_list=""
    var year=new Date().getFullYear();
    for(let i=year;i>1990;i--){
        if(yearVal-i==0){
            year_list+=`<li class="on">${i}</li>`  
        }else{
            year_list+=`<li>${i}</li>`
        }
    }
    for(let i=1;i<=12;i++){
        
        if(monthVal-i==0){
            month_list+=`<li class="on">${i}月</li>`
        }else{
            month_list+=`<li>${i}月</li>`
        }
    }
    var $html=`<div class="time-box">
        <ul class="year-list">
            ${year_list}
        </ul>
        <div class="month-list">
            <ul>
                ${month_list}
            </ul>
        </div>
    </div>` 
    $(this).after($html)
    $(".time-box .year-list li").click(function(e){
        e.stopPropagation();
        $(".month-list li",timeBox).unbind("click")
        var $year=$(this).text()
        var timeBox=$(this).parents(".time-box");
        $(this).addClass("on").siblings(".on").removeClass("on");
        $(".month-list li",timeBox).bind("click",function(e){
            e.stopPropagation();
            var $month=$(this).index()+1;
            if($month<10){
                $month="0"+$month
            }
            $(this).addClass("on").siblings(".on").removeClass("on");
            if(type=="start"){
                startTime=$year+"-"+$month
            }else if(type=="end"){
                endTime=$year+"-"+$month
            }
            var $startTime=new Date(startTime).getTime()
            var $endTime=new Date(endTime).getTime()
            if($startTime<=$endTime||startTime==""||endTime==""){
                timeBox.siblings(".time-drop").val($year+"-"+$month).trigger("input")
                setTimeout(function(){
                    timeBox.hide()
                },1)
            }else{
                timeBox.hide()
                $public.tip("开始时间请小于结束时间")
            }
        })
    })
    if($(".time-box .year-list li.on").length==0){
        $(".time-box .year-list li:eq(0)").click()
    }else{
        $(".time-box .year-list li.on").click()
    }
})


