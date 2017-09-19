$(".condition-list .more").click(function(){
    var $wrap=$(this).parents("dl:eq(0)")
    $wrap.toggleClass("active")
    if($wrap.hasClass("active")){
        $(this).html(`收起<i class="arow-t"></i>`)
    }else{
        $(this).html(`更多<i class="arow-b"></i>`)
    }
})
$(".condition-list .drop-down").click(function(){
    var $wrap=$(this).parents(".condition-list:eq(0)")
    $wrap.addClass("active")
})
function init(){
    var industryId=getQueryString("industry_id");
    //城市ID
    var cityId=$("#cityId").attr("data-id");
    if(cityId){
        var item=$("#cityId li[data-id='"+cityId+"']")
        item.addClass("on")
        if(item.parents(".details:eq(0)").length>0){
            $(this).parents("dl:eq(0)").addClass("active")
        }
    }
    var currentCityName=$("#cityId").attr("data-name");
    var currentCityId=$("#cityId").attr("data-id");
    var currentItem=$("#cityId li[data-id='"+currentCityId+"']")
    if(currentCityId!=""&&currentItem.length==0){
        $("#cityId ul:eq(0)").prepend(`<li data-id="${currentCityId}" class="item on">${currentCityName}</li>`)
    }
    var salaryMax=getQueryString("salary_max")
    var salaryMin=getQueryString("salary_min")
    $("#salary").val(salaryMin+"-"+salaryMax)
    
}
init()
$("#industryId li.item").click(function(){
    var id=$(this).attr("data-id")
    if(id&&id!=""){    
        location.href=location.pathname+LocationSearch("industry_id")+"industry_id="+id
    }else{
        location.href=location.pathname+LocationSearch("industry_id")
    }
})
$("#cityId li.item").click(function(){
    var id=$(this).attr("data-id")
    if(id&&id!=""){
        location.href=location.pathname+LocationSearch("city_id")+"city_id="+id
    }else{
        location.href=location.pathname+LocationSearch("city_id")
    }
})
$("#experienceId li.item").click(function(){
    var id=$(this).attr("data-id")
    if(id&&id!=""){
        location.href=location.pathname+LocationSearch("experience_id")+"experience_id="+id
    }else{
        location.href=location.pathname+LocationSearch("experience_id")
    }
})
$("#educationId li.item").click(function(){
    var id=$(this).attr("data-id")
    if(id&&id!=""){
        location.href=location.pathname+LocationSearch("education_id")+"education_id="+id
    }else{
        location.href=location.pathname+LocationSearch("education_id")
    }
})


$("#querySort li").click(function(){
    var type=$(this).attr("data-type");
    location.href=location.pathname+LocationSearch("sort")+"sort="+type
})
$("#allCity").click(function(){
    location.href="/commons/cities"+LocationSearch("city_id")+"&url="+location.pathname
})
$("#work_type").change(function(){
    var id=$(this).val()
    if(id&&id!=""){
        location.href=location.pathname+LocationSearch("work_type_id")+"work_type_id="+id
    }else{
        location.href=location.pathname+LocationSearch("work_type_id")
    }
})
$("#salary").change(function(){
    if($(this).val().split("-").length>1){
        var salaryMin=$(this).val().split("-")[0]
        var salaryMax=$(this).val().split("-")[1]
        location.href=location.pathname+LocationSearch("salary_min,salary_max")+"salary_min="+salaryMin+"&salary_max="+salaryMax
    }else{
        location.href=location.pathname+LocationSearch("salary_min,salary_max")
    }
})
$("#keywords").submit(function(){
    var keywords=$(this).find("[name='keywords']").val();
    if(keywords!=""){
        location.href=location.pathname+LocationSearch("keywords")+"keywords="+encodeURI(keywords)
    }else{
        location.href=location.pathname+LocationSearch("keywords")
    }
    return false;
})
$("#job-link").attr("href","/jobs/"+LocationSearch("type")+"type=1")
$("#company-link").attr("href","/jobs/"+LocationSearch("type")+"type=2")
