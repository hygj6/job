$public.upLoadImg({
    url:"/resume/guide/main/upload.json",
    width:220,
    height:220,
    limitWidth:220,
    limitHeight:220,
    btn:'#mask-up',
    preview:"#picview",
    noprogressBar:true,
    startFn:function(){
        $(".up-avatar-box").addClass("active")
        $(".up-avatar-box .ring-right i").css({
            "transform":"rotate(180deg)"
        })
    },
    successFn:function(data){
        setTimeout(function(){
            $(".up-avatar-box").addClass("active")
            $(".up-avatar-box .ring-left i").css({
                "transform":"rotate(180deg)"
            })
            setTimeout(function(){
                $(".up-avatar-box").removeClass("active")
                $(".up-avatar-box .ring-right i,.up-avatar-box .ring-left i").css({
                    "transform":"rotate(0deg)"
                })
                $public.tip("上传完毕")
            },500)
        },500)
    }
})
$public.Validform({
    obj:$("#update"),
    fn:function(curform){
        var item=$public.getFormData($("#update"));
        var experience=item.experience;
        var live_city=item.live_city;
        item.experience={id:experience};
        item.live_city={id:live_city}
        $public.postJson({
            url:"/resume/guide/main/update",
            data:item,
            successFn:function(data){
                location.href=data.next;
            },
            erroFn:function(code){
                var msg=$public.AjaxErro(code)
                $("#login").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        });
    }
})

$("#skip").click(function(){
    $public.postJson({
        url:"/resume/guide/main/skip.json",
        successFn:function(data){
            location.href=data.next;
        }
    })
})
$("#update [type='submit']").hover(function(){
    $(".book-corner").addClass("on")
},function(){
    $(".book-corner").removeClass("on")
})
$(".city-select").change(function(){
    var val=$(this).val()
    if($(".city-select option:selected").index()>0){
        $("input[name='live_city']").val(val)
    }else{
        $("input[name='live_city']").val("")
    }
})
$public.get({
    url:"/commons/cities.json",
    successFn:function(data){
        let provinceHtml=`<option>请选择省</option>`;
        for(let i=0;i<data.length;i++){
            provinceHtml+=`<option value="${data[i].id}">${data[i].name}</option>`;
        }
        $(".province-select").html(provinceHtml)
        $(".province-select").change(function(){
            var index=$(".province-select option:selected").index()-1
            let cityHtml=`<option>请选择城市</option>`;
            if(index>=0){
                for(let i=0;i<data[index].children.length;i++){
                    cityHtml+=`<option value="${data[index].children[i].id}">${data[index].children[i].name}</option>`;
                }
            }
            $(".city-select").html(cityHtml).trigger("change");
        });
        $(".city-select").trigger("change");
        $(".province-select").trigger("change");
        var provinceId=$(".province-select").siblings("input").val();
        var cityId=$(".city-select").siblings("input").val();
        if(provinceId!=""){
            $(".province-select").val(provinceId).trigger("change");
        }
        if(cityId!=""){
            $(".city-select").val(cityId).trigger("change");
        }
    }
})




