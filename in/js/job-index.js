$("#tag-list .add").click(function(){//标签
    $(this).prevAll(".edit").show();
    $(this).prevAll(".edit").find("input").focus()
    $(this).hide();
})
$("#tag-list").on("click",".del",function(){
    $(this).parents(".tag:eq(0)").remove();
    if($("#tag-list .tag.active").length==0){
        $("#tag-list-val").val("")
    }
})
$("#tag-list .enter").click(function(){
    var val=$(this).prev("input").val().trim()
    if(val!=""){
        $("#tag-list .add").show()
        $("#tag-list .edit").hide();
        var $html=`<div class="tag active">${val}<i class="del icon icon-icon_close"></i></div>`
        $("#tag-list .edit").before($html)
        if($("#tag-list .tag.active").length>0){
            $("#tag-list-val").val(1)
        }
    }
    $(".tag.edit input").val("")
})
$("#save-job .category-name").bind("input",function(){
    var val=$(this).val()
    $("#tag-list .category").remove()
    var $html=`<div class="tag category active">${val}<i class="del icon icon-icon_close"></i></div>`
    $("#tag-list .edit").before($html)
    if($("#tag-list .tag.active").length>0){
        $("#tag-list-val").val(1)
    }
})
$public.cityList();
$(".address-list").on("click",".edit",function(){
    var id=$(this).attr("data-id");
    var provinceId=$(this).attr("data-provinceId");
    var cityId=$(this).attr("data-cityId");
    var districtId=$(this).attr("data-districtId");
    var address=$(this).attr("data-address");
    var longitude=$(this).attr("data-longitude");
    var latitude=$(this).attr("data-latitude");
    $public.showDialog($("#map-modular"),function(){
        $("#map-modular input[name='id']").val(id)
        $("#map-modular input[name='province_id']").val(provinceId)
        $("#map-modular input[name='city_id']").val(cityId)
        $("#map-modular input[name='district_id']").val(districtId)
        $("#map-modular input[name='latitude']").val(latitude)
        $("#map-modular input[name='longitude']").val(longitude)
        $("#map-modular input[name='address']").val(address)
        $public.setcityList();
    })
})
$(".address-list .add").click(function(){
    $public.showDialog($("#map-modular"),function(){
        $("#map-modular input[name='id']").val("")
        $("#map-modular input[name='province_id']").val("")
        $("#map-modular input[name='city_id']").val("")
        $("#map-modular input[name='district_id']").val("")
        $("#map-modular input[name='latitude']").val("")
        $("#map-modular input[name='longitude']").val("")
        $("#map-modular input[name='address']").val("")
        $public.setcityList();
    })
})
$("#map-modular .btn.cancel").click(function(){
    $public.offDialog()    
})
$public.Validform({
    obj:$("#save-job"),
    fn:function(curform){
        var item=$public.getFormData($("#save-job"));
        if(item.salary_basic=="on"){
            item.salary_basic=true;
        }else{
            item.salary_basic=false;
        }
        item.highlights=$("input[name='highlights']").map(function(e){
            if($(this).val()!=""){
                return $(this).val()
            }
        }).get()
        item.tags=$("#tag-list .tag.active").map(function(e){
            if($(this).text()!=""){
                return $(this).text();
            }
        }).get()
        $public.postJson({
            url:"/companies/job/save",
            data:item,
            successFn:function(data){
               location.href=data.url;
               isPerfect=true
            },
            erroFn:function(code){
                $public.tip($public.AjaxErro(code))
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        })
    },
    beforeFn:function(){
        $("#JobEditorTextarea").val(UM.getEditor('JobEditor').getContent())
        $(".highlights").val("")
        $("input[name='highlights']").map(function(e){
            if($(this).val()!=""){
                $(this).siblings(".highlights").val(1)
            }
        })
    }
})
$(".count-input .increase").click(function(){
    var obj=$(this).parents(".count-input:eq(0)").find("input");
    var nub=parseInt(obj.val());
    nub++;
    obj.val(nub)
    obj.val(nub).trigger("input");
})
$(".count-input .reduce").click(function(){
    var obj=$(this).parents(".count-input:eq(0)").find("input");
    var nub=parseInt(obj.val());
    if(obj.attr("name")=="salary_max"){
        if(nub>2){
            nub--;
        }
    }else{
        if(nub>1){
            nub--;
        } 
    }   
    obj.val(nub).trigger("input");
})
$("input[name='salary_min']").bind("input",function(){
    var minNub=parseInt($(this).val());
    var maxNub=parseInt($("input[name='salary_max']").val());
    if(minNub>=maxNub){
        $("input[name='salary_max']").val(minNub+1)
    }
    if(minNub<maxNub/2){
        $("input[name='salary_max']").val(minNub*2)
    }
})

$("input[name='salary_max']").bind("input",function(){
    var maxNub=parseInt($(this).val());
    var minNub=parseInt($("input[name='salary_min']").val());
    if(minNub>=maxNub){
        $("input[name='salary_min']").val(maxNub-1)
    }
    if(minNub<maxNub/2){
          $("input[name='salary_min']").val(Math.ceil(maxNub/2))
    }
})
$("#up-addresses").click(function(){
    if(!$(this).parents(".address").hasClass("on")){
        $(this).html(`收起地址<span class="arow-t"></span>`)
        $(this).parents(".address").addClass("on")
    }else{
        $(this).html(`更改地址<span class="arow-b"></span>`)
        $(this).parents(".address").removeClass("on")
    }
})
$("body").on("change","#address-tab input",function(){
    $("#addresses-text").text($(this).parents(".item-add").find(".label").text())
    $("#company-address").val("1")
})
if($("#address-tab input:checked").length>0){
    $("#address-tab input:checked").prop("checked",true).trigger("change")
}else{
    $("#address-tab input:eq(0)").prop("checked",true).trigger("change")
}
if($("[name='work_type_id']:checked").length==0){
    $("[name='work_type_id']:last").prop("checked",true)
}
$("#save-job").on("focus","input,textarea",function(){
    $(".warning-tip").hide()
    $(this).parents("dl:eq(0)").find(".warning-tip").show()
})
um.addListener('focus',function(){
    $(".warning-tip").hide()
    $(".edui-container").parents("dl:eq(0)").find(".warning-tip").show()
});

