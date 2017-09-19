$("#educations").on("input",".bind",function(){ 
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
    if(isPass){
        if(id!=""){//更新
            $public.postJson({
                url:"/resume/guide/educations/update",
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
$("#educations").on("click",".delete",function(){
    var $form=$(this).parents("form:eq(0)");
    var id=$form.find("input[name='id']").val();
    $public.post({
        url:"/resume/guide/educations/delete.json",
        data:{"id":id},
        successFn:function(data){
            $form.remove();
        }
    })
})
$("#addItem").click(function(){
    $public.post({
        url:"/resume/guide/educations/create.json",
        successFn:function(data){
            var html=$("#temp").html();
            $("#temp").before(html);
            $("#temp").prev("form").find("input[name='id']").val(data.id)
        }
    })
})
$("#nextPage").click(function(){
    var isPass=true;
    $("#educations .bind").map(function(){
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
$("#educations").on("input","select[name='type_id'],select[name='graduation_year']",function(){
    var item=$(this).parents(".group-input:eq(0)");
    var graduation_year=$("select[name='graduation_year']",item).val();
    var type_id=$("select[name='type_id']",item).val();
    if(graduation_year!=""&&type_id!=""){
        item.find(".hide-val").val(graduation_year+"_"+type_id)
    }else{
        item.find(".hide-val").val("")
    }
})
