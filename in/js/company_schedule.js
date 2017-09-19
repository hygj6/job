$("#schedule-tab a").click(function(){
    var id=$(this).attr("data-id")
    location.href=location.pathname+LocationSearch("schedule")+"schedule="+id
})
$("#schedule-form").submit(function(){
    var category_id=$("[name='category_id']",this).val()
    var q=$("[name='q']",this).val()
    location.href=location.pathname+LocationSearch("category_id,q,schedule")+"category_id="+category_id+"&q="+q+"&schedule=0";
    return false;
})










