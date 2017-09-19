$(".industry-item-cont dd a").click(function(){
    var id=$(this).attr("data-id");
    var nameLv3=$(this).text().trim()
    var nameLv2=$(this).parents("dd:eq(0)").siblings("dt").text().trim()
    var nameLv1=$(".industry-tab li.on").text().trim()
    var data={
        "id":id,
        "nameLv1":nameLv1,
        "nameLv2":nameLv2,
        "nameLv3":nameLv3
    }
    window.parent.IndustryCallback(data);
    window.parent.$public.OffIndustryFrame()
})

$(".industry-item-cont dt a").click(function(){
    var id=$(this).attr("data-id");
    var nameLv2=$(this).text().trim()
    var nameLv1=$(".industry-tab li.on").text().trim()
    var data={
        "id":id,
        "nameLv1":nameLv1,
        "nameLv2":nameLv2
    }
    window.parent.IndustryCallback(data);
    window.parent.$public.OffIndustryFrame()
})

$(".industry-tab li").click(function(){
    $(this).addClass("on").siblings(".on").removeClass("on")
    $(".industry-cont .industry-item-cont").eq($(this).index()).fadeIn().siblings(".industry-item-cont").hide()
});
$("#off-frame").click(function(){
    window.parent.$public.OffIndustryFrame()
});