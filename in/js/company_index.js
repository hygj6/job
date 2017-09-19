$("body").on("click",".resbox .edit-btn:not(.lock)",function(){
    $("body").append(`<div class="modal-backdrop lock" style="display: block;"></div>`)
    var modularItem=$(this).parents(".modular-item:eq(0)");
    modularItem.addClass("editing")
})
$("body").on("click",".editbox .btn.cancel:not(.lock)",function(){
    $(".modal-backdrop.lock").remove()
    var modularItem=$(this).parents(".modular-item:eq(0)");
    modularItem.removeClass("editing")
})

$("#update-base-info .edit-btn").click(function(){
    var $Data=$public.getFormData($("#update-base-info-data"))
    for(let item in $Data){
        $("#update-base-info-edit").find("[name='"+item+"']").val($Data[item]);
    }
})

$public.upLoadImg({
    url:"/companies/logo/upload.json",
    preview:"#logoView",
    btn:"#company-logo",
    width:180,
    height:180,
    limitWidth:180,
    limitHeight:180
})

$public.Validform({//更新基本信息
    obj:$("#update-base-info-edit"),
    fn:function(curform){
        var $data=$public.getFormData($("#update-base-info-edit"));
        var $url=$data.web_url;
        if($url!=""&&$url.indexOf("http://")!=0&&$url.indexOf("https://")!=0){
            $data.web_url="http://"+$url
        }
        $public.postJson({
            url:"/companies/name/update",
            data:$data,
            successFn:function(data){
                var $Data=$data
                for(let item in $Data){
                    $("#update-base-info").find(".vm-"+item).text($Data[item]);
                    $("#update-base-info-data [name='"+item+"']").val($Data[item])
                }
                $("#update-base-info .vm-abbreviation").next(".icon-icon_link").remove()
                if($Data["web_url"]!=""){
                    $("#update-base-info .vm-abbreviation").after(`<i class="icon icon-icon_link"></i>`)
                    $("#update-base-info .vm-abbreviation").attr("href",$Data["web_url"])
                }else{
                    $("#update-base-info .vm-abbreviation").removeAttr("href")
                }
                $(".editing").removeClass("editing")
                $(".modal-backdrop.lock").remove()
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        });
    }
})
function getTagName(id){
    var contrast=[
        {id:1,name:"网站"},
        {id:2,name:"客户端"},
        {id:3,name:"移动app"},
        {id:4,name:"硬件"},
        {id:5,name:"其他"}
    ]
    var str=""
    for (let i = 0; i < contrast.length; i++) {
        if(contrast[i].id==id){
            str=contrast[i].name
        }
    };
    return str;
}
function InitProductEdit(){//编辑产品初始化
    InitWord();
    $public.upLoadImg({
        url:"/companies/product/upload.json",
        width:300,
        height:180,
        preview:"#productPreviewImg",
        btn:"#upload_product",
        limitWidth:300,
        limitHeight:180,
        data:{
            product_id:$("#product-edit [name='id']").val()
        },
        successFn:function(data){
            $("#product-edit [name='id']").val(data.id)
            var $wrap=$("#product-edit").parents(".modular-item:eq(0)");
            $wrap.prev(".modular-item").find(".product-img").attr("src",data.url)
            $wrap.prev(".modular-item").find("[name='pic_url']").val(data.url)
        }
    })
    $public.Validform({
        obj:$("#product-edit"),
        fn:function(curform){
            var $data=$public.getFormData($("#product-edit"))
            var $url=$data.url;
            if($url!=""&&$url.indexOf("http://")!=0&&$url.indexOf("https://")!=0){
                $data.url="http://"+$url
            }  
            $public.postJson({
                url:"/companies/product/add",
                data:$data,
                successFn:function(){
                    $(".modal-backdrop.lock").remove()
                    var $Data=$data
                    var $wrap=$("#product-edit").parents(".modular-item:eq(0)");
                    $wrap.hide()
                    var resBox=$wrap.prev(".modular-item:eq(0)")
                    for(let item in $Data){
                        $("[name='"+item+"']",resBox).val($Data[item])
                        $(".vm-"+item,resBox).text($Data[item])
                    }
                    $(".vm-name",resBox).next(".icon-icon_link").remove()
                    if($Data["url"]!=""){
                        $(".vm-name",resBox).after(`<i class="icon icon-icon_link"></i>`);
                        $(".vm-name",resBox).attr("href",$Data["url"]);
                    }else{
                        $(".vm-name",resBox).removeAttr("href");
                    }
                    $(".vm-tag",resBox).text(getTagName($Data["product_type_id"]));
                    resBox.show();
                },
                alwaysFn:function(curform){
                    $("button[type='submit']",curform).prop("disabled",false);
                }
            })
        }
    })
}
$("#product-list").on("click",".edit-btn",function(){//编辑产品
    $("body").append(`<div class="modal-backdrop lock" style="display: block;"></div>`)
    var $wrap=$(this).parents(".modular-item:eq(0)");
    $wrap.hide().siblings(".modular-item").show()
    $("#product-edit-box").show().addClass("editing").insertAfter($wrap);
    var $Data=$public.getFormData($("form",$wrap))
    for(let item in $Data){
        if(item!="product_type_id"){
            $("#product-edit").find("[name='"+item+"']").val($Data[item]);
        }    
    }
    $("#product-edit").find("[name='product_type_id']").map(function(){
        if($(this).val()==$Data["product_type_id"]){
            $(this).prop("checked",true)
        }
    })
    $("#productPreviewImg").attr("src",$Data["pic_url"])
    InitProductEdit()
})
$("#product-list").on("click",".del-btn",function(){//删除产品
    var wrap=$(this).parents(".modular-item")
    var id=wrap.find("[name='id']").val()
    $public.confirm({
        title:"删除产品",
        msg:"确认删除该产品",
        fn:function(){
            $public.post({
                url:"/companies/product/delete.json",
                data:{"id":id},
                successFn:function(){
                    wrap.remove()
                }
            })
        }
    })
    
})
$("#product-edit").on("click",".btn.cancel",function(){//取消编辑产品
    $(".modal-backdrop.lock").remove()
    var $wrap=$(this).parents(".modular-item:eq(0)");
    $wrap.hide().prev(".modular-item").show()
    var $data=$public.getFormData($("#product-edit-box").prev(".product-item").find("form"))
    if($data.id==""){
        $("#product-edit-box").prev(".modular-item").remove()
    }
})
$("#creatProduct").click(function(){//新建产品
    $("#product-edit-box").show().insertAfter("#product-list .product-item:last")
    $("#product-edit-box").before($("#product-temp").html())
    $("#product-edit-box form")[0].reset()
    $("#productPreviewImg").attr("src","")
    InitProductEdit()
    $("body").append(`<div class="modal-backdrop lock" style="display: block;"></div>`)
})
function limtFn(){
    if($("#sortable-img li:not(.disabled)").length<8){
        return true
    }else{
        alert("最多可以上传8张图片")
        return false
    }
}
function InitAvatar(){
    $public.upLoadImg({//上传图片
        url:"/companies/avatar/upload.json",
        width:180,
        height:180,
        btn:'#upload-avatar',
        preview:"#picview-avatar",
        Limiting:limtFn,
        successFn:(data,viewImg)=>{
            $("#sortable-img").prepend(`<li data-id="${data.id}">
                                            <img width="180" height="180" src="${data.url}"/>
                                            <div class="mask-del del-avatar">
                                                <i class="icon icon-icon_close"></i>
                                            </div>
                                        </li>`);
            $("#company-avatar [name='avatar_ids']").val($("#sortable-img li:not(.disabled)").map(function(){
                return $(this).attr("data-id")
            }).get().join(","))
            $("#avatar-nub").text($("#sortable-img li:not(.disabled)").length)
            if($("#sortable-img li:not(.disabled)").length>=8){
                $("#sortable-img li.disabled").hide()
            }
        },
        completeFn:function(){
            $("#picview-avatar").attr("src","")
        }
    })
    setTimeout(function(){
        if($("#sortable-img li:not(.disabled)").length>=8){
            $("#sortable-img li.disabled").hide()
        }
    },0)
}
$("#sortable-img").on("click",".del-avatar",function(){//删除图片
    var wrap=$(this).parents("li:eq(0)")
    var id=wrap.attr("data-id");
    $public.post({
        url:"/companies/avatar/delete.json",
        data:{"avatar_id":id},
        successFn:function(){
            wrap.remove()
            $("#avatar-nub").text($("#sortable-img li:not(.disabled)").length)
            $("#sortable-img li.disabled").show()
        }
    })
})
$("#company-avatar [name='avatar_ids']").val($("#sortable-img li:not(.disabled)").map(function(){
    return $(this).attr("data-id")
}).get().join(","))
$( "#sortable-img").sortable({//图片排序
    items: "li:not(.disabled)",
    stop:function(e){
        $("#company-avatar [name='avatar_ids']").val($("#sortable-img li:not(.disabled)").map(function(){
            return $(this).attr("data-id")
        }).get().join(","))
    }
});
$("#add-avatar-cont .edit-btn").click(function(){
    InitAvatar();
})
$("#add-avatar-cont .btn.cancel").click(function(){
    setTimeout(function(){
        InitImgWall()
    },10)
})

window.InitImgWall=function(){
    mySwiper.removeAllSlides();
    var $html=""
    if($("#sortable-img li:not(.disabled)").length>0){
        $("#sortable-img li:not(.disabled)").map(function(){
            mySwiper.appendSlide(`<img src="${$('img',this).attr('src')}"/>`,'item swiper-slide','div');
        })
    }else{
        mySwiper.appendSlide(' ','default item swiper-slide','div');
    }
    mySwiper.swipeTo(0,100, false);
}

$public.Validform({
    obj:$("#company-avatar"),
    fn:function(curform){
        var $data=$public.getFormData($("#company-avatar"));
        var avatar_ids=$data.avatar_ids.split(",");
        $data.avatar_ids=avatar_ids;
        $public.postJson({
            url:"/companies/avatar/add",
            data:$data,
            successFn:function(){
                $(".modal-backdrop.lock").remove()
                $("#add-avatar-cont .vm-summary").html(encodeTextAreaString($data["summary"]))
                $(".modular-item:not(#product-edit-box)").removeClass("editing")
                InitImgWall()
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        })
    }
})
// 地图
$public.Validform({
    obj:$("#addressForm"),
    fn:function(curform){
        var $data=$public.getFormData($("#addressForm"));
        $public.postJson({
            url:"/companies/address/create",
            data:$data,
            successFn:function(data){
                $(".modal-backdrop.lock").remove()
                var id=data.id;
                var item=$(".address-list-box li[data-id='"+id+"'] input");
                var DetailedAddress=QueryCity($data["province_id"])+QueryCity($data["city_id"])+QueryCity($data["district_id"])+$data["address"]
                if(item.length>0){
                    item.attr("data-provinceId",$data["province_id"])
                    item.attr("data-cityId",$data["city_id"])
                    item.attr("data-districtId",$data["district_id"])
                    item.attr("data-address",$data["address"])
                    item.attr("data-latitude",$data["latitude"])
                    item.attr("data-longitude",$data["longitude"])
                    item.parents("li:eq(0)").find("span").text(DetailedAddress)
                }else{
                    var $html=`<li data-id="${id}">
                                    <label>
                                        <label class="radio-label">
                                            <input 
                                            data-provinceId="${$data["province_id"]}" 
                                            data-cityId="${$data["city_id"]}" 
                                            data-districtId="${$data["district_id"]}" 
                                            data-address="${$data["address"]}" 
                                            data-latitude="${$data["latitude"]}" 
                                            data-longitude="${$data["longitude"]}"
                                            value="${id}" name="radio" type="radio"/><i></i>
                                        </label>
                                        <span>${DetailedAddress}</span>
                                    </label>
                                    <a class="del" href="javascript:void(0)">删除</a>
                                </li>`;
                    $(".address-list-box ul").append($html);
                    $(".address-list-box ul li:last input").prop("checked",true).trigger("change")
                }
                $(".modular-item.map-modular.editing").removeClass("editing")
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        })
    }
})

var query_time=null//模糊搜索计时器
$(".map-modular input[name='address']").bind("input propertychange",function(){
    if($(this).val().trim()!=""){        
        var key=$("input.address-text").val().replace(/\//g,"")+$(this).val()
        clearTimeout(query_time)
        query_time=setTimeout(()=>{   
            BaiDuMap.search(key)
        },100)
    }
})
$(".map-modular .edit-btn").click(function(){
    $("#del-address").show()
})
$(".address-list-box").on("click",".del",function(){//删除地图
    var id=$(this).parents("li").attr("data-id");
    var text=$(this).prev("label").text()
    $public.confirm({
        title:"删除操作",
        msg:`确认删除地址:${text}`,
        sure:"删除",
        fn:function(){
            $public.post({
                url:"/companies/address/delete.json",
                data:{"id":id},
                successFn:function(data){
                    $(".address-list-box li[data-id='"+id+"']").remove();
                    if($(".address-list-box li").length>0){
                        $(".address-list-box li:eq(0) input").prop("checked",true).trigger("change")
                    }else{
                        $("#current-company-addresses-edit-btn,#current-company-addresses").hide()
                        BaiDuMap.init()
                    }
                }
            })
        }
    })
    
})
$("#add-address").click(function(){//添加地图
    var wrap=$(this).parents(".modular-item")
    wrap.addClass("editing")
    $("#addressForm")[0].reset()
    $(".address-list-box input").prop("checked",false)
    $("body").append(`<div class="modal-backdrop lock" style="display: block;"></div>`)
    $("#del-address").hide()
})
$("#cancel-edit-map").click(function(){//关闭编辑地图
    if($(".address-list-box input:checked").length==0){
        $(".address-list-box input:eq(0)").prop("checked",true).trigger("change")
    }
})


$(".address-list-box").on("change","input",function(){
    $("#current-company-addresses-edit-btn,#current-company-addresses").show()
    var id=$(this).val();
    var latitude=$(this).attr("data-latitude")
    var longitude=$(this).attr("data-longitude")
    var provinceId=$(this).attr("data-provinceId")
    var cityId=$(this).attr("data-cityId")
    var districtId=$(this).attr("data-districtId")
    var address=$(this).attr("data-address")
    if($("#allmap").length>0){
        if(latitude!=0&&longitude!=0){
            BaiDuMap.addPoint(latitude,longitude)
        }else{
            BaiDuMap.search($(this).parents("li:eq(0)").text().trim())
        }
    }
    $("#company-addresses").text($(this).parents("li:eq(0)").find("label").text().trim())
    $(".map-tool .address-list .province li[data-id='"+provinceId+"']").click()
    setTimeout(function(){
    $(".map-tool .address-list .city-list .item-city[data-id='"+cityId+"']").click()
    },1)
    setTimeout(function(){
        $(".map-tool .address-list .city-list .item-city[data-id='"+cityId+"'] .area-list .area-item[data-id='"+districtId+"']").click()
    },2)
    setTimeout(function(){
        $(".map-modular input[name='id']").val(id)
        $(".map-modular input[name='address']").val(address)
        $(".map-modular input[name='latitude']").val(latitude)
        $(".map-modular input[name='longitude']").val(longitude)
    },3)
})
var $cityList=function({fn=function(){}}){
    $(".map-modular .address-box input").click(function(e){
        e.stopPropagation();
        if($(this).val()==""){
            $(this).siblings(".address-list").find(".province li:eq(0)").click()
        }
        $(this).siblings(".address-list").show()
    })
    $(".map-modular input[name='address']").click(function(){
        if($(this).val()==""){
            $(this).siblings(".address-list").find(".province li:eq(0)").click()
        }
        $(this).siblings(".address-list").show()
    })
    $(".address-box input.input-text").bind("input",function(){
        $(".map-modular input[name='address']").prop("disabled",false)
        $(".map-modular input[name='address']").focus()
    })
    $public.get({
        url:"/commons/cities.json",
        successFn:function(data){
            window.cities=data;
            var provincehtml=""//省HTML
            var provinceIndex=0;//省索引
            var cityIndex=0;//城市索引
            var areaIndex=0;//区索引
            var provinceName="";//省中文
            var cityName="";//城市中文
            var areaName="";//区中文
            var province_id=0;//省id
            var city_id=0;//城市id
            var district_id=0;//区id
            function addressInit(){
                $(".map-modular input[name='province_id']").val(province_id)
                $(".map-modular input[name='city_id']").val(city_id)
                $(".map-modular input[name='district_id']").val(district_id)
                $(".map-modular input[name='latitude']").val("");
                $(".map-modular input[name='longitude']").val("");
                $(".map-modular input[name='address']").val("")
            }
            for(let i=0;i<data.length;i++){
                provincehtml+=`<li data-id="${data[i].id}">${data[i].name}</li>`
            }
            $(".map-modular .address-list .province ul").html(provincehtml);
            $(".map-modular .address-list .province ul li").click(function(){
                $(".map-modular input[name='address']").prop("disabled",true)
                provinceName=$(this).text()
                city_id=""
                district_id=""
                province_id=$(this).attr("data-id")
                addressInit();
                $(this).siblings(".on").removeClass("on")
                $(this).addClass("on")
                provinceIndex=$(this).index()
                let children=data[provinceIndex].children;
                var cityhtml=""
                for(let k=0;k<children.length;k++){
                    cityhtml+=`<div data-id="${children[k].id}" class="item-city"><span class="text">${children[k].name}</span><div class="area-list"></div></div>`
                }
                $(".map-modular .address-list .city-list").html(cityhtml)
                $(".map-modular .address-box input.input-text").val("");
                $(".map-modular .address-list .city-list .item-city").click(function(){
                    $(".map-modular input[name='address']").prop("disabled",true)
                    cityName=$(this).text()
                    district_id=""
                    city_id=$(this).attr("data-id")
                    addressInit();
                    $(this).siblings(".on").removeClass("on")
                    $(this).addClass("on")
                    cityIndex=$(this).index()
                    let children=data[provinceIndex].children[cityIndex].children;
                    var areahtml=""
                    for(let m=0;m<children.length;m++){
                        areahtml+=`<div data-id="${children[m].id}" class="area-item">${children[m].name}</div>`;
                    }
                    $(".area-list",this).html(areahtml)
                    $(".map-modular .address-box input.input-text").val("");
                    $(".area-list .area-item",this).click(function(e){
                        e.stopPropagation();
                        areaName=$(this).text()
                        $(this).siblings(".on").removeClass("on")
                        $(this).addClass("on")
                        let id=$(this).attr("data-id")
                        district_id=id
                        $(".map-modular .address-box input.input-text").val(provinceName+"/"+cityName+"/"+areaName).trigger("input")
                        $(".map-modular .address-list").hide()
                        addressInit();
                    })
                })
            })
            fn()
        }
    })
}
$cityList({
    fn:function(){
        if($(".address-list-box input").length>0){
            $(".address-list-box input:eq(0)").prop("checked",true).trigger("change")
        }else{
            BaiDuMap.init()
        }
    }
});
// 地图
//基本信息
$("#update-info-btn").click(function(){
    $public.showDialog("#update-info-box");
    $("#update-info-box [name='personnels']").val($("#update-info-res .vm-personnels").text())
})

window.IndustryCallback=function({
    id="",
    nameLv1="",
    nameLv2="",
    nameLv3=""
}){
    $public.OffIndustryFrame(id)
    $("#update-info [name='industry_id']").val(id)
    if(nameLv3!=""){
        $("#update-info .industry-name").val(`${nameLv1}/${nameLv2}/${nameLv3}`)
        $("#update-info .industry-name").attr("data-val",nameLv3)
    }else{
        $("#update-info .industry-name").val(`${nameLv1}/${nameLv2}`)
        $("#update-info .industry-name").attr("data-val",nameLv2)
    }
    
}
$("#update-info .industry-name").click(function(){
    var id=$("#update-info [name='industry_id']").val()
    $public.IndustryFrame(id);
})
$public.Validform({
    obj:$("#update-info"),
    fn:function(curform){
        var $data={
                exhibition:$("#update-info .js-platform-tags option").map(function(){
                    return $(this).text();
                }).get(),
                industry_id:$("input[name='industry_id']").val(),
                personnels:$("select[name='personnels']").val(),
            }
        var Lv3_name=$("#update-info .industry-name").attr("data-val")
        $public.postJson({
            url:"/companies/info/update",
            data:$data,
            successFn:function(data){
                $public.offDialog();
                $("#update-info-res .vm-personnels").text($data["personnels"]);
                $("#update-info-res .vm-industry").text(Lv3_name);
                $("#update-info-res .vm-exhibition").text($data["exhibition"].toString().replace(/,/g,"/"));
            },
            erroFn:function(code){
                var msg=$public.AjaxErro(code)
                $("#update-info").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        });
    }
})
$("#edit-tags-btn").click(function(){
    $public.showDialog("#edit-tags-box");
    $public.getJson({
        url:"/companies/tag",
        data:"",
        successFn:function(data){
            var allCompanyTagsHtml=""
            var AllCompanyTags=data.allCompanyTags
            for(let i=0;i<AllCompanyTags.length;i++){
                allCompanyTagsHtml+=`<li data-tag="${AllCompanyTags[i]}">${AllCompanyTags[i]}</li>`
            }
            $("#all-tag-list").html(allCompanyTagsHtml)


            var companyTagHtml=""
            var CompanyTags=data.companyTags
            for(let i=0;i<CompanyTags.length;i++){
                $("#all-tag-list li[data-tag='"+CompanyTags[i]+"']").remove()
                companyTagHtml+=`<li data-tag="${CompanyTags[i]}">${CompanyTags[i]}<i class="icon-icon_close icon"></i></li>`
            }
            $("#company-tag-list").html(companyTagHtml)
            $("#edit-tags-box .selected-tag").text(data.companyTags.length)
        }
    })
})
$("#company-tag-list").on("click","li",function(){
    var id=$(this).attr("data-id");
    var tag=$(this).attr("data-tag")
    $(this).remove()
    $("#all-tag-list").append(`<li data-id="${id}" data-tag="${tag}">${tag}</li>`)
    $("#edit-tags-box .selected-tag").text($("#company-tag-list li").length)
})
$("#all-tag-list").on("click","li",function(){
    if($("#company-tag-list li").length<8){
        var id=$(this).attr("data-id");
        var tag=$(this).attr("data-tag")
        $(this).remove()
        $("#company-tag-list").append(`<li data-id="${id}" data-tag="${tag}">${tag}<i class="icon-icon_close icon"></i></li>`)
        $("#edit-tags-box .selected-tag").text($("#company-tag-list li").length)
    }else{
        $public.tip("最多可选8个标签")
    }
})
$("#add-tags").click(function(){
    var tags=$("#company-tag-list li").map(function(){
        return $(this).attr("data-tag")
    }).get();
    $public.post({
        url:"/companies/tags/add.json", 
        data:{
            "tags":tags.toString()
        },
        successFn:function(){
            var html=""
            for(let i=0;i<tags.length;i++){
                html+=`<li>${tags[i]}</li>`
            }
            $("#tag-list-res").html(html)
            $public.offDialog()
        }
    })
})


