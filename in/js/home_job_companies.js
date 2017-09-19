$("#keywords").submit(function(){
    var keywords=$(this).find("[name='keywords']").val();
    if(keywords!=""){
        location.href=location.pathname+LocationSearch("keywords")+"keywords="+encodeURI(keywords)
    }else{
        location.href=location.pathname+LocationSearch("keywords,type")+"type=1"
    }
    return false;
})
$("#job-link").attr("href","/jobs/"+LocationSearch("type")+"type=1")
$("#company-link").attr("href","/jobs/"+LocationSearch("type")+"type=2")