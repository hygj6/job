<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    final int nextYear = Calendar.getInstance().get(Calendar.YEAR) + 1;
    final List<Integer> years = new ArrayList<Integer>();
    for (int i = nextYear; i > 1990; i--) {
        years.add(i);
    }
%>
<c:set var="years" value="<%=years%>"/>
