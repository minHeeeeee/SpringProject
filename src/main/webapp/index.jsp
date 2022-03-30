<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미니프로젝트</title>
<style>


@import url('https://fonts.googleapis.com/css2?family=Sunflower:wght@300;500&display=swap');


body{
margin : 0;
padding : 0;
height : 100%;
width : auto;
font-family: 'Sunflower', sans-serif;

}

#header{
margin:auto;
width : 1300px;
height : 10%;
text-align : center;

font-family: 'Sunflower', sans-serif;


}

#container{
margin:auto;
width: 1300px;
height:500px;

font-family: 'Sunflower', sans-serif;


}

#container:after{
content:'';
display:block;
clear:both;
float:none;
font-family: 'Sunflower', sans-serif;


}

#nav{

margin-left:10px;
width : 25%;
height : 100%;
float : left;
font-family: 'Sunflower', sans-serif;

}

#section{
width : 70%;
height : 100%;
float : left;
font-family: 'Sunflower', sans-serif;


}

#footer{
margin: auto;
width:1300px;
height:10%;

font-family: 'Sunflower', sans-serif;



}




</style>
</head>
<body style="background: linear-gradient(to right, #ffffff, #ffffff); color:black;">
<div id ="header">

<h1>
<img alt="애옹이" src="/SpringProject/image/1.jpeg" width="100" height="100" 
onclick="location.href='/SpringProject/index.jsp'" style="cursor:pointer;">⎛⎝.⎛° ͜ʖ°⎞.⎠⎞
</h1>
<br>
<jsp:include page ="/main/menu.jsp"/>



</div>
<div id ="container">

<div id = "nav" >

<jsp:include page ="/main/nav.jsp"/>
</div>


<div id="section" >
<h1>
<c:if test="${empty display }">
You are valued.<br>
<img src ="/SpringProject/image/3.jpg"width="400" height="400" alt="안녕">

</c:if>
<c:if test="${not empty display}">
<jsp:include page ="${display}"/>
</c:if>

</h1>
</div>
</div>

<div id ="footer" >
<p><b>( •˓◞•̀ )☝</b></p>
</div>

</body>
</html>