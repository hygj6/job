<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${url.cdn}/static/plugins/jquery/jquery.js"></script>
<script src="${url.cdn}/static/plugins/es5/es5-shim.js"></script>
<script src="${url.cdn}/static/plugins/es5/es5-sham.js"></script>
<script src="${url.cdn}/static/plugins/Validform/Validform_v5.3.2_min.js?v=20170911"></script>
<script src="${url.cdn}/static/plugins/moment/moment.js"></script>
<script src="${url.cdn}/static/plugins/moment/moment-with-locales.min.js"></script>
<script>
moment.locale(['zh-cn', 'zh-tw']);
var $regexp={
    e:/${regexp.email}/,
    m:/${regexp.phone}/,
    account:/${regexp.account}/,
    emailSuffix:/${regexp.emailSuffix}/,
}
</script>