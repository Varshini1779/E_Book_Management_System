<%@page import="com.entity.BookDtls"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="java.util.List"%>
<%@page import="com.DAO.BookDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Old Books</title>
<%@include file="all_component/allCss.jsp"%>
<style>
.crd-ho:hover {
	background-color: #eeeeee;
}

.btn-group-custom {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 5px;
	flex-wrap: nowrap;
}

.price-btn {
	background-color: #dc3545;
	color: white;
	border: none;
}

.price-btn:hover {
	background-color: #bb2d3b;
	color: white;
}
</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>

	<div class="container my-4">
		<h3 class="text-center mb-4">Old Books</h3>
		<div class="row">
			<%
			BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
			List<BookDtls> list = dao.getAllOldBook();
			for (BookDtls b : list) {
			%>
			<div class="col-sm-6 col-md-3 mb-4">
				<div class="card crd-ho h-100">
					<div class="card-body text-center">
						<img
							src="<%=request.getContextPath()%>/book/<%=b.getPhotoName()%>"
							style="width: 150px; height: 200px;" class="img-thumbnail mb-2" />
						<p class="mb-1">
							<b><%=b.getBookName()%></b>
						</p>
						<p class="mb-1"><%=b.getAuthor()%></p>
						<p class="mb-2">
							Category:
							<%=b.getBookCategory()%></p>
						<div class="row d-flex justify-content-center align-items-center gap-2 mt-2">
							<a href="view_books.jsp?bid=<%=b.getBookId()%>" class="btn btn-success btn-sm" ml-1>View Details</a> <a
								href="" class="btn btn-danger btn-sm ml-1"><i class="fa-solid fa-indian-rupee-sign"></i> <%=b.getPrice()%>
								</a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>

	<%@include file="all_component/footer.jsp"%>
</body>
</html>
