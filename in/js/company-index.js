window.model = avalon.define("companyInfo", function(vm) {
    vm.companyBase={
        abbreviation:company_info.abbreviation,
        companyBrief:company_info.brief,
        companyHref:company_info.web_url,
    }
    vm.companyBaseEidit={
        abbreviation:company_info.abbreviation,
        companyBrief:company_info.brief,
        companyHref:company_info.web_url,
    }
    vm.publicBase={
        product_types:company_info.product_types,
        industry:company_info.industry,
        exhibitions:company_info.exhibitions,
        logo_url:company_info.logo_url
    }
    vm.productBase={
        companyProduct:company_info.products,
        edit_id:"",//产品id
        edit_name:"",//产品名称
        edit_picture:"",//产品图片
        edit_product_type_id:"",//产品类型id
        edit_summary:"",//产品简介
        edit_url:""//产品链接
    }
    vm.companyAvatars={
        img_group:company_info.avatars,
        avatar_summary:company_info.summary
    }
    vm.companyAvatarsEidit={
        img_group:company_info.avatars,
        avatar_summary:company_info.summary
    }
    vm.addressBase={
        addressesList:company_info.addresses,
        id:"",
        province_id:"",
        city_id:"",
        district_id:"",
        province:"",
        city:"",
        district:"",
        address:"",
        latitude:"",
        longitude:"",
        selectAddress:function(index){
            let item=model.addressBase.addressesList[index];
            model.addressBase.id=item.id;
            model.addressBase.address=item.address;
            model.addressBase.latitude=item.latitude;
            model.addressBase.longitude=item.longitude;
            BaiDuMap.addPoint(model.addressBase.latitude,model.addressBase.longitude);
            $(".map-tool .address-list .province li[data-id='"+item.province_id+"']").click()
            setTimeout(function(){
                $(".map-tool .address-list .city-list .item-city[data-id='"+item.city_id+"']").click()
            },1)
            setTimeout(function(){
                $(".map-tool .address-list .city-list .item-city[data-id='"+item.city_id+"'] .area-list .area-item[data-id='"+item.district_id+"']").click()
                model.addressBase.province_id=item.province_id;
                model.addressBase.city_id=item.city_id;
                model.addressBase.district_id=item.district_id;
            },2)
        }
    }
    vm.allCompanyTags=[];
    vm.companyTags=[];
})
setTimeout(function(){
    model.addressBase.selectAddress(0)
},1000)
$("body").on("click",".modular-item .edit-btn",function(){
    if(!$(this).hasClass("pop")){  
      $(this).parents(".modular-item").addClass("editing");
      $("body").append(`<div class="modal-backdrop show"></div>`);
    }
})
$("body").on("click",".modular-item .cancel.btn",function(){
  closeEiting($(this).parents(".modular-item.editing"))
})
function closeEiting(obj){
    $(".editing").removeClass("editing");
    $(".modal-backdrop.show").remove()
}
function delete_avatar(id,index){
    $public.post({
        url:"/companies/avatar/delete.json",
        data:{
            avatar_id:id
        },
        successFn:()=>{
            model.companyAvatars.img_group.splice(index, 1); 
            mySwiper.update();
        }
    })
}
$public.Validform({
    obj:$("#update-name"),
    beforeFn:function(){
    },
    erro_obj:1,
    fn:function(curform){
        $public.postJson({
            url:"/companies/name/update",
            data:$public.getFormData($("#update-name")),
            successFn:function(data){
                closeEiting($("#update-name").parents(".modular-box"))
                model.companyBase.abbreviation=model.companyBaseEidit.abbreviation;
                model.companyBase.companyBrief=model.companyBaseEidit.companyBrief;
                model.companyBase.companyHref=model.companyBaseEidit.companyHref;
            },
            erroFn:function(code){
                var msg=$public.AjaxErro(code)
                $("#update-name").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        });
    }
})
$public.Validform({
    obj:$("#update-info"),
    fn:function(curform){
        $public.postJson({
            url:"/companies/info/update",
            data:{
                exhibition:$("#update-info .js-platform-tags option").map(function(){
                    return $(this).text();
                }).get(),
                industry_id:$("input[name='industry_id']").val(),
                personnels:$("select[name='personnels']").val(),
            },
            successFn:function(data){
                $public.offDialog();
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
function CreateProduct(obj){
    var index=obj.attr("data-index")
    var item=model.productBase.companyProduct[index]
    model.productBase.edit_id=item.id,//产品id
    model.productBase.edit_name=item.name;
    model.productBase.edit_picture=item.picture;
    model.productBase.edit_product_type_id=item.product_type_id;
    model.productBase.edit_summary=item.summary;
    model.productBase.edit_url=item.url;
    var id=obj.attr("data-id");
    var index=obj.attr("data-index")
    if($('#pic'+id).find(".webuploader-pick").length==0){
        $public.upLoadImg({
            url:"/companies/product/upload.json",
            data:{
                product_id:id
            },
            width:300,
            height:180,
            btn:'#pic'+id,
            preview:"#picview"+id,
            successFn:function(data){
                model.productBase.edit_picture=data.url;
                model.productBase.companyProduct[index].picture=data.url;
                model.productBase.edit_id=data.id;
            }
        })
    }
    $public.Validform({
        obj:$(".edit-product"),
         beforeFn:function(curform){
              $("#edit-product").attr("id","")
              $(curform).attr("id","edit-product")
        },
        fn:function(curform){
            var $data=$public.getFormData($("#edit-product"));
            var $url=$data.website_url;
            if($url.indexOf("http://")!=0&&$url.indexOf("https://")!=0){
                $data.website_url="http://"+$url
            }
            $public.postJson({
                url:"/companies/product/add",
                data:$data,
                successFn:function(data){
                    var nub=$("#edit-product").parents(".product-item:eq(0)").attr("data-index");
                    var item=model.productBase.companyProduct[nub];
                    var editItem=model.productBase;
                    item.id=editItem.edit_id;
                    item.picture=editItem.edit_picture;
                    item.name=editItem.edit_name;
                    item.url=editItem.edit_url;
                    item.summary=editItem.edit_summary;
                    item.product_type_id=$("#edit-product input[name='product_type_id']:checked").val()
                    closeEiting($("#edit-product").parents(".editing"))
                },
                erroFn:function(code){
                    var msg=$public.AjaxErro(code)
                    $("#info").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
                },
                alwaysFn:function(curform){
                    $("button[type='submit']",curform).prop("disabled",false);
                }
            });
        }
    })
}

$("#creatProduct").click(function(){
    model.productBase.companyProduct.push({
        id:0,
        name:"",
        picture:"",
        product_type_id:0,
        summary:"",
        url:""
    })
    $(".product-item:last .edit-btn").click()
})
$("#update-name").parents(".modular-box").find(".edit-btn").click(function(){
    model.companyBaseEidit.abbreviation=model.companyBase.abbreviation;
    model.companyBaseEidit.companyBrief=model.companyBase.companyBrief;
    model.companyBaseEidit.companyHref=model.companyBase.companyHref;
})
$("body").on("click",".product-item .btn.cancel",function(){
    var last=model.productBase.companyProduct.length-1;
    if(model.productBase.companyProduct[last].id==0){
        model.productBase.companyProduct.pop();
    }
})
$("body").on("click",".product-item .edit-btn",function(){
    CreateProduct($(this))
})
$("#update-info-btn").click(function(){
    $public.showDialog("#update-info-box");
})
$public.getJson({
    url:"/companies/tag",
    data:"",
    successFn:function(data){
        model.companyTags=data.companyTags;
        var list=[]
        for(let i=0;i<data.allCompanyTags.length;i++){
            var id=data.allCompanyTags[i].id;
            var iscontain=false;
            for(let k=0;k<data.companyTags.length;k++){
                if(id==data.companyTags[k].id){
                    iscontain=true
                }
            }
            if(!iscontain){
                list.push(data.allCompanyTags[i])
            }
        }
        model.allCompanyTags=list
    }
})
$("body").on("click","#all-tag-list li",function(){
    var id=$(this).attr("data-id");
    var index=$(this).index();
    var contain=false;
    for(let i=0;i<model.companyTags.length;i++){
        if(model.companyTags[i].id==id){
            contain=true;
        }
    }
    if(!contain){
        model.companyTags.push({
            object:model.allCompanyTags[index].object,
            id:model.allCompanyTags[index].id
        });
        var tags=[];
        for(let i=0;i<model.allCompanyTags.length;i++){
            if(i!=index){
                tags.push(model.allCompanyTags[i])
            }
        }
        model.allCompanyTags=tags
    }
})
$("body").on("click","#company-tag-list li",function(){
    var id=$(this).attr("data-id");
    var index=$(this).index();
    var contain=false;
    for(let i=0;i<model.allCompanyTags.length;i++){
        if(model.allCompanyTags[i].id==id){
            contain=true;
        }
    }
    if(!contain){
        model.allCompanyTags.push({
            object:model.companyTags[index].object,
            id:model.companyTags[index].id
        });
        var tags=[];
        for(let i=0;i<model.companyTags.length;i++){
            if(i!=index){
                tags.push(model.companyTags[i])
            }
        }
        model.companyTags=tags
    }
})
$("#add-tags").click(function(){
    var ids=[]
    for(let i=0;i<model.companyTags.length;i++){
        ids.push(model.companyTags[i].id);
    }
    $public.post({
        url:"/companies/tags/add.json", 
        data:{
            "tags":ids.toString()
        }
    })
})
$("#company-avatar").parents(".modular-item").find(".edit-btn").click(function(){
    $public.upLoadImg({
        url:"/companies/avatar/upload.json",
        width:180,
        height:180,
        btn:'#upload-avatar',
        preview:"#picview",
        successFn:(data,viewImg)=>{
            model.companyAvatars.img_group.push({
                "avatar_url":data.url,
                "id":data.id
            })
            ImgGroupInit()
            mySwiper.update();
        }
    })
})
$public.upLoadImg({
    url:"/companies/logo/upload.json",
    width:180,
    height:180,
    limitWidth:180,
    limitHeight:180,
    btn:'#company-logo',
    noprogressBar:true,
    startFn:function(){
        $(".up-avatar-box").addClass("active")
        $(".up-avatar-box .ring-right i").css({
            "transform":"rotate(180deg)"
        })
    },
    successFn:(data,viewImg)=>{
        model.publicBase.logo_url=data.url
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
$public.get({
    url:"/commons/cities.json",
    successFn:function(data){
        var provincehtml=""
        var provinceIndex=0;
        var cityIndex=0;
        var areaIndex=0;
        var provinceName="";
        var cityName="";
        var areaName="";
        for(let i=0;i<data.length;i++){
            provincehtml+=`<li data-id="${data[i].id}">${data[i].name}</li>`
        }
        var itemData=model.addressBase;
        $(".address-list .province ul").html(provincehtml)
        $(".address-list .province ul li").click(function(){
            provinceName=$(this).text()
            itemData.city_id=""
            itemData.district_id=""
            itemData.province_id=$(this).attr("data-id")
            $(this).siblings(".on").removeClass("on")
            $(this).addClass("on")
            provinceIndex=$(this).index()
            let children=data[provinceIndex].children;
            var cityhtml=""
            for(let k=0;k<children.length;k++){
                cityhtml+=`<div data-id="${children[k].id}" class="item-city"><span class="text">${children[k].name}</span><div class="area-list"></div></div>`
            }
            $(".address-list .city-list").html(cityhtml)
            $(".address-list .city-list .item-city").click(function(){
                cityName=$(this).text()
                itemData.district_id=""
                itemData.city_id=$(this).attr("data-id")
                $(this).siblings(".on").removeClass("on")
                $(this).addClass("on")
                cityIndex=$(this).index()
                let children=data[provinceIndex].children[cityIndex].children;
                var areahtml=""
                for(let m=0;m<children.length;m++){
                    areahtml+=`<div data-id="${children[m].id}" class="area-item">${children[m].name}</div>`;
                }
                $(".area-list",this).html(areahtml)
                $(".area-list .area-item",this).click(function(e){
                    e.stopPropagation();
                    areaName=$(this).text()
                    $(this).siblings(".on").removeClass("on")
                    $(this).addClass("on")
                    let id=$(this).attr("data-id")
                    itemData.district_id=id
                    $(".address-box input.input-text").val(provinceName+"/"+cityName+"/"+areaName).trigger("input")
                    $(".address-list").hide()
                })
            })
        })
    }
})
$(".address-box input").focus(function(){
    $(this).siblings(".address-list").show()
})
var query_time=null
$("#address-detailed").bind("input propertychange",function(){
    if($(this).val().trim()!=""){        
        var key=$("input[name='address-text']").val().replace(/\//g,"")+$(this).val()
        clearTimeout(query_time)
        query_time=setTimeout(()=>{   
            BaiDuMap.search(key)
        },500)
    }
})
$("input[name='address-text']").bind("input",function(){
    $("#address-detailed").prop("disabled",false)
    $("#address-detailed").focus()
})
$("#save-address").click(function(){
    var lng=$("input[name='longitude']").val();
    var lat=$("input[name='latitude']").val();
    if(lng!=""&&lat!=""){
        var itemData=model.addressBase;
        $public.postJson({
            url:"/companies/address/save",
            data:{
               id:itemData.id,
               province_id:itemData.province_id,
               city_id:itemData.city_id,
               district_id:itemData.district_id,
               latitude:itemData.latitude,
               longitude:itemData.longitude,
               address:itemData.address
            },
            successFn:function(data){
                closeEiting($("#allmap"))
                model.addressBase.addressesList.push({
                   id:itemData.id,
                   province_id:itemData.province_id,
                   city_id:itemData.city_id,
                   district_id:itemData.district_id,
                   latitude:itemData.latitude,
                   longitude:itemData.longitude,
                   address:itemData.address 
                })
            }
        })
    }
})
$("#add-address").click(function(){
    model.addressBase.id=0
    $(this).parents(".modular-item").find(".edit-btn").click()
})
$("#cancel-edit-map").click(function(){
    //model.addressBase.selectAddress(0)
    
})
function ImgGroupInit(){
    var $html=""
    for(let i=0;i<model.companyAvatars.img_group.length;i++){
        let item=model.companyAvatars.img_group[i];
        $html+=`<li class="active" data-id="${item.id}">
                <img width="180" height="180" src="${item.avatar_url}"/>
                <div class="mask-del">
                ${item.id}
                </div>
            </li>`
    }
    $("#sortable-img li.disabled").prevAll("li").remove()
    $("#sortable-img li.disabled").before($html)
}
ImgGroupInit()
$( "#sortable-img").sortable({
    items: "li:not(.disabled)",
    stop:function(e){
       var list=$("#sortable li.active").map(function(){
            if($(this).attr("data-id")!=""){
                return {
                    avatar_url:$("img",this).attr("src"),
                    id:$(this).attr("data-id")
                }
            }
       }).get();
       model.companyAvatars.img_group=list      
    }
});
$("#sortable-img").on("click","li:not(.disabled) .mask-del",function(){
    var id=$(this).parent("li").attr("data-id");
    var index=$(this).parent("li").index();
    $(this).parent("li").remove();
    delete_avatar(id,index)
})
$public.Validform({
    obj:$("#company-avatar"),
    erro_obj:1,
    fn:function(curform){
        var avatarIds=model.companyAvatars.img_group.map(function(e){
            return e.id;
        })
        $public.postJson({
            url:"/companies/avatar/add",
            data:{
                summary:model.companyAvatarsEidit.avatar_summary,
                avatar_ids:avatarIds
            },
            successFn:function(){
                model.companyAvatars.avatar_summary=model.companyAvatarsEidit.avatar_summary;
                closeEiting($("#company-avatar").parents(".editing"));
            },
            alwaysFn:function(curform){
                $("button[type='submit']",curform).prop("disabled",false);
            }
        })
    }
})
