<%@page import="com.himanshu.MyBigBasket.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MYBigBasket-Home</title>
        <%@include file="component/common_css_js.jsp" %>   


    </head>
    <body>
        <%@include file="component/navbar.jsp" %>

        <h1>Hello World!</h1>
        <h1>Creating session factory object</h1> 
        <%
            out.println(FactoryProvider.getFactory());

        %>
    </body>
</html>
