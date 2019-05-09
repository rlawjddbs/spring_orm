<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://localhost:8080/spring_orm/common/css/main_v190130.css" />
<style type="text/css">
	#wrap{ margin: 0px auto; width:800px; height:860px;  }
	#header{ mwidth:800px; height:140px; background:#FFF url('http://localhost:8080/spring_orm/common/images/header_bg.png'); position:relative; }
	#headerTitle{ font-family: HY견고딕, 고딕; font-size: 35px; font-weight:bold; text-align:center; position:absolute; left:300px; top:30px; }
	#container{ width:800px; }
	#footer{ width:800px; height:120px; }
	#footerTitle{ float:right; font-size:15px; padding-top:20px; padding-right: 20px;}
	/* td{ padding:10px; } */
	#subject { padding-top:10px; }
	#subject > a { padding-left:10px; padding-right:10px; color:blue; font-weight:bold; transition-duration:0.3s; }
	#subject > a:hover { text-decoration:none; color:#A3CB38; }
	
	#detailView{ padding:20px; position:fixed; display:none; width:500px; height:auto; box-shadow:0 0 5px rgba(0, 0, 0, 0.52); background-color:rgba(255, 255, 255, 0.78); }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		var img = "";
		$(".detailView").mouseover(function(e) {
			// $("#detailView").css({left:e.clientX+30, top:e.clientY+30});
			// $("#detailView").show();
			// alert($(this).children("input").val());
			$.ajax({
				url:"lunch_detail.do",
				data:"lunch_code="+$(this).children("input").val(),
				dataType:"json",
				type:"get",
				error:function(xhr){
					alert("잠시 후 다시 시도해주세요.");
					console.log( xhr.status );
				},
				success:function(json_obj){
					// alert( json_obj.img + " / "+json_obj.spec);
					$("#detailView").html("<img src='http://localhost:8080/spring_orm/day0430/images/"+json_obj.img+"' /><br />"+json_obj.spec);
					$("#detailView").css({left:e.clientX+30, top:e.clientY+30});
					$("#detailView").show();
				}
			});
		});
		$(".detailView").mouseout(function() {
			$("#detailView").hide();
		});
	}); // ready
</script>
</head>
<body>
	<div id="wrap">
		<div id="header">
			<div id="headerTitle">SIST Class4</div>
			<div style="padding-top:100px;">
				<c:import url="/common/jsp/main_menu.jsp" />
			</div>
		</div>
		<div id="container">
			<table>
				<tr>
					<th style="width:80px">번호</th>
					<th style="width:123px">이미지</th>
					<th style="width:250px">도시락 명</th>
					<th style="width:180px">가격</th>
					<th style="width:180px">입력일</th>
				</tr>
				<c:if test="${ empty lunchList }">
					<tr>
						<td colspan="5" style="text-align:center;">입력된 도시락이 존재하지 않습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="lunch" items="${ lunchList }">
					<c:set var="i" value="${ i+1 }" />
					<tr>
						<td style="text-align:center;"><c:out value="${ i }" /></td>
						<td style="text-align:center;" class="detailView">
							<img src="http://localhost:8080/spring_orm/day0430/images/${ lunch.img }" />
							<input type="hidden" name="lunch_code" value="${ lunch.lunch_code }" />
						</td>
						<td style="text-align:center;"><c:out value="${ lunch.lunch_name }" /></td>
						<td style="text-align:center;"><c:out value="${ lunch.price }" /></td>
						<td style="text-align:center;"><c:out value="${ lunch.input_date }" /></td>
					</tr>
				</c:forEach>
			</table>
			<div id="detailView"></div>
		</div>
		<div id="footer">
			<div id="footerTitle">copyright&copy; all right reserve class 4</div>
		</div>
	</div>
</body>
</html>