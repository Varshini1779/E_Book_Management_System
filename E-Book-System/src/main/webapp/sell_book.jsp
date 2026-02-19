<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sell book</title>
<%@include file="all_component/allCss.jsp"%>

</head>
<body style="background-color: #f7f7f7;">
	<c:if test="${empty userobj }">
		<c:redirect url="login.jsp" />
	</c:if>
	<%@include file="all_component/navbar.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="text-center text-primary p-1">Sell Old book</h5>
						<c:if test="${not empty succMsg }">
							<p class="text-center text-success">${succMsg }</p>
							<c:remove var="succMsg" scope="session" />
						</c:if>

						<c:if test="${not empty failedMsg }">
							<p class="text-center text-danger">${failedMsg }</p>
							<c:remove var="failedMsg" scope="session" />
						</c:if>
						<form action="${pageContext.request.contextPath}/add_old_book"
							method="post" enctype="multipart/form-data">



							<input type="hidden" value="${userobj.email }" name="user">
							<div class="form-group">
								<label for="exampleInputEmail1">Book Name*</label> <input
									type="text" class="form-control" id="exampleInputEmail1"
									name="bname">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Author's Name*</label> <input
									type="text" class="form-control" id="exampleInputEmail1"
									name="author">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Price*</label> <input
									type="number" class="form-control" id="exampleInputPassword1"
									name="price">
							</div>

							<div class="form-group">
								<label for="exampleFormControlFile1">Upload Photo</label> <input
									name="bimg" type="file" class="form-control-file"
									id="exampleFormControlFile1" />
							</div>
							<button type="submit" class="btn btn-primary">Sell</button>
						</form>
					</div>
				</div>
			</div>
		</div>




	</div>
</body>
</html>