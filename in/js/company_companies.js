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
    var industryId=getQueryString("industry_id")
    var cityId=$("#cityId").attr("data-id")
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
    location.href=location.pathname+LocationSearch("city_id")+"city_id="+id
})
$("#querySort li").click(function(){
    var type=$(this).attr("data-type");
    location.href=location.pathname+LocationSearch("sort")+"sort="+type
})
$("#allCity").click(function(){
    location.href="/commons/cities"+LocationSearch("city_id")+"&url="+location.pathname
})
