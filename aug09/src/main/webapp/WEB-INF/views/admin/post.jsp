<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin || post</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/admin.css">
<link rel="stylesheet" href="../css/multiboard.css">
<style type="text/css">
.gray{
   background-color: #c0c0c0;
}
.title{
	text-align: left;
}
</style>
<script src="../js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">

$(function(){
	$(".title").click(function(){
	 let mbno = $(this).siblings(".mbno").text();	
	 let parent = $(this).parent();
	 
	 alert(mbno);
	 let div = "<div class='row'><div class='div cell _content'>본문내용 찍을 자리</div></div>";
	 parent.after(div);
	
	 $.ajax({
			url: "./content",	 
		 	type: "post",
		 	data: {mbno: mbno},
		 	dataType: "json",
		 	success:function(data){
		 		alert(data.mbno + "굿");
		 		$("row").html
		 	},
		 	
		 	error:function(error){alert("에러가 발생했습니다. 다시 시도하셈");}
		 });
		 
		 
		 
		 });
	 
	 
	 
	 });






</script>








</head>
<body>
   <div class="container">
      <%@ include file="menu.jsp" %>
      <div class="main">
         <div class="article">         
            <h1>게시글 관리 ${list[0].count}개 글이 있음</h1>
            <div class="boardlist">
               <button onclick="location.href='./post?cate=0'">전체 보기</button>
               <c:forEach items="${boardlist }" var="b">
                  <button onclick="location.href='./post?cate=${b.mb_cate}'">${b.b_catename }</button>
               </c:forEach>
               <form action="./post" method="get">
                  <select name="searchN">
                     <option value="title">제목</option>
                     <option value="content">내용</option>
                     <option value="nick">글쓴이</option>
                     <option value="id">ID</option>
                  </select>
                  <input type="text" name="searchV" required="required">
                  <input type="hidden" name="cate" value="${param.cate }">
                  <button type="submit">검색</button>
               </form>
            </div>
            
            <div class="div-table">
                  <div class="div-row table-head">
                     <div class="div-cell table-head">번호</div>
                     <div class="div-cell table-head">카테고리</div>
                     <div class="div-cell table-head">제목</div>
                     <div class="div-cell table-head">글쓴이</div>
                     <div class="div-cell table-head">날짜</div>
                     <div class="div-cell table-head">읽음수</div>
                     <div class="div-cell table-head">삭제</div>
                  </div>
                  <c:forEach items="${list }" var="row">
                  <div class="div-row <c:if test="${row.mb_del eq 0 }"> gray</c:if>">
                     <div class="div-cell mbno">${row.mb_no }</div>
                     <div class="div-cell">${row.b_catename }</div>
                     <div class="div-cell title">${row.mb_title }</div>
                     <div class="div-cell">${row.m_name }(${row.m_id })</div>
                     <div class="div-cell">${row.mb_date }</div>
                     <div class="div-cell">${row.mb_read }</div>
                     <div class="div-cell">${row.mb_del }</div>
                  </div>
                  </c:forEach>
               </div>
            
         </div>
         
         

      </div>
   </div>
</body>
</html>