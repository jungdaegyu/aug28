<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin || 공지사항</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../css/admin.css">
<style type="text/css">
.notice-write-form{
	width: 95%;
	height: auto;
	margin : 10px;
	padding: 20px;
	box-sizing: border-box;
}
.notice-write-form input{
	height: 30px;
	width: 100%;	
}
.notice-write-form textarea {
	width: 100%;
	height: 300px;
	margin: 5px 0px;
}
.notice-write-form button {
	width: 100px;
	height: 50px;
}
table{
	width: 820px;
	text-align: center;
	border-collapse: collapse;
	float: left;
}
tr{
	border-bottom: 1px solid silver;
}
tr:hover{
	background-color: silver;
}
.title{
	text-align: left;
	width: 40%;
}

.content-view{
	width: calc(100% - 820px);
	height: 400px;
	background-color: white;
	float: right;
}

</style>
<script type="text/javascript">
$(function(){
	 $(".title").click(function(){
		//alert($(this).text());
		//alert($(this).siblings(".nno").text());
		let nno = $(this).siblings(".nno").text();		
		
		$.ajax({
			url:"./noticeDetail",
			type: "post",
			data: {nno: nno}, //어드민 컨트롤러에서 값을 가져오는건데 잡아오는 파람이 앞에 있는거
			dataType: "json",
			success:function(data){
				// alert(data.name);
				$(".content-view").html("< 미리 보기 > <br>"  + data.content);
			},
			error:function(data){
				alert("오류가 발생했습니다. : " + data);
			}	
		}); 
	 }); 
	
	 $(document).on("click", ".xi-toggle-on, .xi-toggle-off", function(){
			let nno = $(this).parent().siblings(".nno").text();
			let nnoTD = $(this).parent(); //
			$.ajax({
				url: "./noticeHide",
				type: "post",
				dataType: "json",
				data: {nno : nno},
				success: function(data){
					/* 변경 되었다면 모양 바꾸기 */
					//alert(data.result);
					if(nnoTD.html().indexOf("-off") != -1){
						nnoTD.html('<i class="xi-toggle-on"></i>');
					} else{
						nnoTD.html('<i class="xi-toggle-off"></i>');z
					}
				},
				error: function(data){
					alert("오류가 발생했습니다. 다시 시도하지 마세요." + data);					
				}
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
				<h1>공지사항</h1>
				<!-- 리스트가 없다면 해더도 안 나오게 해주세요  choose문 -->
				<table>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>게시일</td>
						<td>글쓴이</td>
						<td>삭제여부</td>
						<td>파일유무</td>
					</tr>
					<c:forEach items="${list}" var="row">
					<tr>
						<td class="nno">${row.nno }</td>
						<td class="title">${row.ntitle }</td>
						<td>${row.ndate }</td>
						<td>${row.m_no }</td>
						<td>
						<c:choose>
							<c:when test="${row.ndel eq 1}"><i class="xi-toggle-on"></i></c:when>
							<c:otherwise><i class=".xi-toggle-off"></i></c:otherwise>
						</c:choose>
						</td>
						<td><c:if test="${row.norifile ne null}"><i class="xi-file-add"></i></c:if></td>
					</tr>						
					</c:forEach>
				</table>
				<!--제목을 클릭하면 옆에 미리보기 느낌으로 보여주려고 하는거임-->
				<div class="content-view">
			
				</div>
				
				<div class="notice-write-form">
					<form action="./noticeWrite" method="post" enctype="multipart/form-data">
						<input type="text" name="title">
						<textarea name="content"></textarea>
						<input type="file" name="upFile">
						<button type="submit">글쓰기</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>