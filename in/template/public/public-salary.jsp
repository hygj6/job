<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${param.basic}">底薪</c:if>${param.max}k~${param.min}k<c:if test="${param.basic}">+提成</c:if>