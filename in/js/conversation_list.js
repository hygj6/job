var currentConversationId;
var conversationsBase;
var candidateAvatar;
var companyAvatar;
CreateResumeDelivery.Init()
window.Chat=function({
    ChatType="personal"
}){
    function InitConversation(){
        $("#conversation-list .item").each(function(){
            var id=$(this).attr("data-id");
            connect(id);
        })
    }
    InitConversation();
    function createMsg({
        msg="",
        type="GENERAL",
        jobName="",
        fn=function(){},
        timeStamp=0,
        sendDateTime=0
    }){
        msg=htmlEncode(msg)
        var avatar=candidateAvatar
        if(ChatType=="company"){
            avatar=companyAvatar
        }
        var html="";
        switch (type){
        	case "GENERAL":
        	    html=`<dd class="r">
                    <div class="chat-item"><i class="arow"></i>${msg}</div>
                        <div class="avatar">
                            <img width="50" height="50" src="${avatar}">
                        </div>
                </dd>`
        		break;
        	case "DELIVERED":
                html=`<dd class="min-tip">
                        <span class="tag">简历投递已发送<a style="color: #fff;" href="javascript:void(0)" data-id="${msg}" class="cancel-resume">是否撤回(10s)</a></span>
                    </dd>`                        
                break;
            case "INVITED":
                html=`<dd class="min-tip">
                        <span class="tag">简历投递邀请已发送</span>
                    </dd>`
                break;
            case "JOB_CHANGED":
                html=`<dd class="min-tip">
                        <span class="tag">正在沟通的职位已变更为：${jobName}</span>
                    </dd>`
                break;
        }
        $("#chat-box").append(html)
        $("#chat-box").scrollTop(10000)
        if(type=="DELIVERED"){
            var diff=timeStamp/1000-sendDateTime/1000
            var lastObj=$("#chat-box dd:last .cancel-resume");
            if(diff>10){
                lastObj.remove();
                return;
            }
            
            var i=parseInt(10-diff);
            lastObj.text(`是否撤回(${i}s)`);
            var $timer=setInterval(function(){
                i--
                if(i<=0){
                    clearInterval($timer)
                    lastObj.remove();
                    IsDelivered(true)
                }
                lastObj.text(`是否撤回(${i}s)`);
            },1000)
        }    
    }
    //Html编码获取Html转义实体  
    function htmlEncode(value){  
      return $('<div/>').text(value).html();  
    }  
    //Html解码获取Html实体  
    function htmlDecode(value){  
      return $('<div/>').html(value).text();  
    }  
    function IsDelivered(delivered){
        if(delivered){
            $("#inviting-btn").hide();
            $("#delivered").text("(已投递)");
        }else{
            $("#inviting-btn").show();
            $("#delivered").text("(未投递)");
        }
    }
    function acceptMsg({
        msg="",
        type="GENERAL",
        jobName="",
        fn=function(){}
    }){
        var avatar=companyAvatar
        if(ChatType=="company"){
            avatar=candidateAvatar
        }
        msg=htmlEncode(msg)
        var html="";
        switch (type){
            case "GENERAL":
                html=`<dd class="l">
                    <div class="avatar">
                        <img width="50" height="50" src="${avatar}">
                    </div>
                    <div class="chat-item"><i class="arow"></i>${msg}</div>
                </dd>`
                break;
            case "DELIVERED":
                html=`<dd class="l">
                        <div class="avatar">
                            <img width="50" height="50" src="${avatar}">
                        </div>
                        <div class="chat-item"><i class="arow"></i>收到一份简历<a target="_blank" href="${msg}">查看</a></div>
                    </dd>`
                break;
            case "INVITED":
                html=`<dd class="l">
                    <div class="avatar">
                        <img width="50" height="50" src="${avatar}">
                    </div>
                    <div class="chat-item"><i class="arow"></i>我觉得你很适合我的${jobName}岗位，可以发我一份简历吗？<a class="delivery-resume" href="javascript:void(0)">投递简历</a></div>
                </dd>`
                break;
            case "JOB_CHANGED":
                html=`<dd class="min-tip">
                        <span class="tag">正在沟通的职位已变更为：${jobName}</span>
                    </dd>`
                break;
        }
        $("#chat-box").append(html)
        $("#chat-box").scrollTop(10000)
    }
    window.console.log=function(){}
    function connect(id) {
        var stompClient = null;
        var socket = new SockJS('/socket');
        socket.debug=null;
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function (frame) {
            var _url=""
            if(ChatType=="company"){
                _url='/user/' + userId + '/conversations/'+id
            }else{
                _url='/user/' + userId + '/conversations/'+id
            }
            stompClient.subscribe(_url, function (greeting) {
                if(currentConversationId==id){
                    acceptMsg({
                        msg:JSON.parse(greeting.body).content,
                        type:JSON.parse(greeting.body).type,
                        jobName:JSON.parse(greeting.body).job_name
                    });
                    if(JSON.parse(greeting.body).type=="DELIVERED"){
                        IsDelivered(true)
                    }
                }else{
                    $("#conversation-list .item[data-id='"+id+"']").prependTo("#conversation-list");
                }
            });
        }); 
    }
    $("#send-msg").submit(function(){
        var content= $('[name="content"]').val();
        if(content!=""){
            var _url=""
            if(ChatType=="company"){
                _url="/companies/conversations/"+currentConversationId+"/message.json"
            }else{
                _url="/conversations/"+currentConversationId+"/message.json"
            }
            $.post(_url, {
                "content":content
            }, function (data) {
                $("#send-msg")[0].reset()
                createMsg({
                    msg:content
                })
            });
        }
        return false;
    })
    $("#send-msg").keydown(function(e){
        var curKey = e.which; 
        if(curKey == 13){ 
            $("#send-msg").trigger("submit"); 
            return false; 
        }
    })
    function ChangeJob(){
        $("#currentJob").bind("change",function(){        
            var jobId=$(this).val()
            var jobName=$("option:selected",this).text()
            if(jobId!=""){
                $public.post({
                    url:"/companies/conversations/"+currentConversationId+"/change-job.json",
                    data:{job:jobId},
                    successFn:function(data){
                        createMsg({
                            type:"JOB_CHANGED",
                            jobName:jobName
                        })
                    }
                })
            }
        })
    }    
    $("#conversation-list .item").click(function(){
        $(this).addClass("on").siblings(".on").removeClass("on");
        currentConversationId=$(this).attr("data-id");
        var id=$(this).attr("data-id");
        var last_time=$(this).attr("data-time")
        $("#last_time").text(last_time)
        var _url=""
        if(ChatType=="company"){
            _url="/companies/conversations/"+id+"/messages.json"
        }else{
            _url="/conversations/"+id+"/messages.json"
        }
        $public.get({
            url:_url,
            data:"",
            successFn:function(data){
                if(ChatType=="company"){
                    $("#personnel-info").attr("href","/companies/resume/"+data.candidate_id)
                }else{
                    $("#company-info").attr("href","/companies/"+data.company_id+".html")
                }
                
                candidateAvatar=data.candidate_avatar;
                companyAvatar=data.company_avatar;
                var list=data.messages
                $("#chat-box dd").remove()
                $("#currentJob").unbind("change")
                $("#currentJob").val(data.job_id).trigger("change")
                ChangeJob();
                if(ChatType=="company"){
                    $("#candidate_name").text(data.candidate_name)
                }else{
                    $("#current-job").text(data.job_name)
                    $("#candidate_name").text(data.company_name)
                }
                IsDelivered(data.delivered)
                for(let i=0;i<list.length;i++){
                    var item=list[i];
                    CreateResumeDelivery.BaseSet({
                        job_id:data.job_id
                    })
                    if(item.creator_id!=userId){
                        acceptMsg({
                            msg:item.content,
                            type:item.type,
                            jobName:item.job_name
                        })
                    }else{
                        createMsg({
                            msg:item.content,
                            type:item.type,
                            jobName:item.job_name,
                            timeStamp:data.timestamp,
                            sendDateTime:item.send_date_time
                        })
                    }
                }
                
            }
        })
    })    
    if(ChatType=="company"){
        if(currentId!=0){
            $("#conversation-list .item[data-id='"+currentId+"']").click();
        }else{
            $("#conversation-list .item:eq(0)").click();
        }
        $("#inviting-btn").click(function(){
            $public.confirm({
                title:"简历投递",
                msg:"你将向对方发起简历投递邀请",
                fn:function(){
                    $public.post({
                        url:"/companies/conversations/"+currentConversationId+"/inviting.json",
                        data:""
                    })
                }
            }) 
        })
    }else{
        $("#conversation-list .item:eq(0)").click();
        $("#chat-box").on("click",".delivery-resume",function(){
            CreateResumeDelivery.BaseSet({
                url:"/conversations/"+currentConversationId+"/delivery.json",
                SuccessDelivery:function(data){
                    $public.offDialog();
                    createMsg({
                        msg:data.id,
                        type:"DELIVERED"
                    })
                }
            })
            CreateResumeDelivery.SubmitResume({
                data:{delivery:""}
            })
        })
        $("#chat-box").on("click",".cancel-resume",function(){
            var id=$(this).attr("data-id")
            var wrap=$(this).parents("dd");
            $public.post({
                url:"/conversations/"+currentConversationId+"/withdraw.json",
                data:{deliver_id:id},
                successFn:function(){
                    wrap.remove()
                }
            })
        })
    }
}














