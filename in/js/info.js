$public.Validform({
    obj:$("#info"),
    fn:function(curform){
        var $data=$public.getFormData($("#info"))
        var $url=$data.website_url;
        if($url!=""&&$url.indexOf("http://")!=0&&$url.indexOf("https://")!=0){
            $data.website_url="http://"+$url
        }
        $public.post({
            url:"/companies/apply/information.json",
            data:$data,
            successFn:function(data){
                location.href=data.next
            },
            erroFn:function(code){
                var msg;
                if(code=="CompanyAlreadyExisted"){
                    msg="公司名称已经存在"
                }else{
                    msg=$public.AjaxErro(code)
                }
                $("#info").prepend(`<p class="total-erro"><i class="erro-icon"></i>${msg}</p>`);
            },
            alwaysFn:function(curform){
                $("#info button[type='submit']").prop("disabled",false);
            }
        });
    }
})

$("#back-edit").click(function(){
    $(this).hide()
    $("#progress-bar").hide();
    $(".edit-box").show();
    $(".preview-box").hide();
    $("#up-info-btn").prop("disabled",true)
})

$public.upLoadImg({
    url:"/companies/apply/license/upload.json",
    btn:"#filePicker",
    width:400,
    height:400,
    preview:"#preview",
    progressBar:".upload-img",
    beforeFn:function(){
        $("#up-info-btn").prop("disabled",true)
        $(".edit-box").hide();
        $(".preview-box").show();
    },
    successFn:function(data){
       $("#back-edit").show()
       $("#up-info-btn").prop("disabled",false)
    }
})