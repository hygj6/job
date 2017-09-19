$(".left-menu .item").hover(function(){
    $(this).addClass("on");
},function(){
    $(this).removeClass("on");
})
$("#change-city").hover(function(){
    $(this).addClass("on")
},function(){
    $(this).removeClass("on")
})
$("#change-industry").hover(function(){
    $(this).addClass("on")
},function(){
    $(this).removeClass("on")
})
if($("#img-box .swiper-slide").length>1){
    var mySwiper = new Swiper('#img-box',{
        loop : true,
        pagination : '.swiper-pagination',
        paginationClickable: true,
        autoplay : 5000,
        speed:500
    });
    $('#img-box .direction-icon.prev').on('click', function(e){
        e.preventDefault()
        mySwiper.swipePrev()
    })
    $('#img-box .direction-icon.next').on('click', function(e){
        e.preventDefault()
        mySwiper.swipeNext()
    })
}else{
    $('#img-box .direction-icon').remove()
}
$("#type-tab dd").click(function(){
    $(this).addClass("on").siblings(".on").removeClass("on")
    $(".job-list-item ul").eq($(this).index()).fadeIn(200).siblings("ul").hide()
})
$("#search-job").submit(function(){
    var keywords=$("[name='keywords']",this).val()
    location.href=`/jobs/?type=1&keywords=${encodeURI(keywords)}`
    return false
})
$("#industry-list .item:not(.more)").click(function(){
    $("#change-industry").removeClass("on")
    var industry_id=$(this).attr("data-id");
    $("#industry_name").text($(this).text())
    $(this).siblings(".item").removeClass("on");
    $(this).addClass("on")
    queryIndustry(industry_id)
})
window.IndustryCallback=function({id=0,nameLv2="",nameLv3=""}){
    queryIndustry(id);
    if(nameLv3!=""){
        $("#industry_name").text(nameLv3)
    }else{
        $("#industry_name").text(nameLv2)
    }
}
$("#industry-list .more").click(function(){
    $public.IndustryFrame();
})
$("#city-list .item").click(function(){
    var id=$(this).attr("data-id")
    var city_name=$(this).text()
    set_cookie("city_id",id);
    location.reload()
})
function BackHtml(jobs){
    var Html="";
    if(jobs.length>0){
        for(let i=0;i<jobs.length;i++){
            var job=jobs[i];
            var tag_list=""
            for(let k=0;k<job.tag_list.length;k++){
                tag_list+=`<dd>${job.tag_list[k]}</dd>`   
            }
            var companyName=job.company.abbreviation;
            if(companyName==""){
                companyName=job.company.name;
            }
            Html+=`<li>
                <div class="job-info">
                    <h3><a target="_blank" href="/jobs/${job.id}.html">${job.name} [${job.city}]</a></h3>
                    <p><span class="pay">${job.salary_min}k~${job.salary_max}k</span>经验${job.experience.experience}/${job.education.education}</p>
                </div>
                <div class="company-info">
                    <div class="pic">
                        <a target="_blank" href="/companies/${job.company.id}.html">
                            <img src="${job.company.logo_url}" width="55" height="55">
                        </a>
                    </div>
                    <div class="text">
                        <p class="name"><a target="_blank" href="/companies/${job.company.id}.html">${companyName}</a></p>
                        <p class="special">${job.company.industry}</p>
                    </div>
                </div>
                <div class="bottom-bar clear">
                    <dl>${tag_list}</dl>
                    <div title="${job.company.brief}" class="slogan">${job.company.brief}</div>
                </div>
            </li>`
        }
    }
    return Html.trim();
}
function queryIndustry(industry_id){
    var city_id=get_cookie("city_id")
    if(!city_id||city_id==""){
        city_id=0;
    }
    $public.post({
        url:"",
        data:{
            industry_id:industry_id,
            city_id:city_id
        },
        successFn:function(data){
            if(BackHtml(data.popularJob)!=""){    
                $("#popularJob").html(BackHtml(data.popularJob))
            }else{
                $("#popularJob").html(`<li style="border: none; box-shadow: 0px 0px 0px rgba(0, 0, 0, 0);"></li>`)
                UnusualState({
                    obj:"#popularJob li",
                    top:"100px",
                    msg:"没有查询到相关职位",
                    btnUrl:"",
                    btnLabel:""
                })
            }
            if(BackHtml(data.newJob)!=""){    
                $("#newJob").html(BackHtml(data.newJob))
            }else{
                $("#newJob").html(`<li style="border: none; box-shadow: 0px 0px 0px rgba(0, 0, 0, 0);"></li>`)
                UnusualState({
                    obj:"#newJob li",
                    top:"100px",
                    msg:"没有查询到相关职位",
                    btnUrl:"",
                    btnLabel:""
                })
            }
        }
    })
}
var CurrentCityId=$("#change-city").attr("data-id")
$("#change-city a[data-id='"+CurrentCityId+"']").addClass("on")
$(".left-menu .item-list a").each(function(){
    var url=encodeURI($(this).attr("href"))
    $(this).attr("href",url)
})
