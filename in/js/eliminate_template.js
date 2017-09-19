window.model = avalon.define("interviewInfo", function(vm) {
    vm.TempBase={
        eidtTemp:function($index){
            var item=model.TempBase.list[$index];
            model.TempBase.list.forEach(function(el,index){
                if(index==$index){
                    model.TempBase.editList=JSON.parse(JSON.stringify(item));
                    model.TempBase.list[$index].show=!model.TempBase.list[$index].show;
                }else{
                    model.TempBase.list[index].show=false;
                }
            })
            SuccessFn()
            InitWord()
        },
        list:templateJson,
        editList:{}
    }
})
function SuccessFn(){
    $public.Validform({
        obj:$("#list-Tempview form"),
        fn:function(curform){
            $public.postJson({
                url:"/companies/template/eliminate/create",
                data:$public.getFormData(curform),
                successFn:function(data){
                    var index=curform.parents("li").index()
                    var item=model.TempBase.list[index];
                    var itemEdit=model.TempBase.editList;
                    item.show=false;
                    item.description=itemEdit.description;
                    item.title=itemEdit.title;
                },
                alwaysFn:function(curform){
                    $("button[type='submit']",curform).prop("disabled",false);
                }
            })
        }
    }) 
}