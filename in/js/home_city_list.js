$(".city-list dd a").click(function(){
    var url=getQueryString("url")
    var id=$(this).attr("data-id")
    if(url){
        location.href=url+LocationSearch("city_id")+"city_id="+id
    }
})
