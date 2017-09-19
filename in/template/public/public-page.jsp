<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${url.cdn}/static/plugins/simplePagination/jquery.simplePagination.js?v=20170904"></script>
<link rel="stylesheet" href="${url.cdn}/static/plugins/simplePagination/simplePagination.css" />
<c:if test="${param.total-0>param.size-0}">
<script>
$(function(){
    $("#pagination").pagination({
        items:${param.total},
        itemsOnPage:${param.size},
        cssStyle: 'light-theme',
        prevText: '<i class="icon icon-arow-l"></i>',
        nextText: '<i class="icon icon-arow-r"></i>',
        hrefTextPrefix:location.pathname+LocationSearch("page")+'page=',
        currentPage:getQueryString("page"),
        onPageClick:function(e){
            e.preventDefault;
        }
    });
});
</script>
</c:if>