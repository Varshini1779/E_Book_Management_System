<%@page import="com.entity.BookDtls"%>
<%@page import="com.entity.User"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="java.util.List"%>
<%@page import="com.DAO.BookDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>search</title>
<%@include file="all_component/allCss.jsp"%>

<style type="text/css">
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

<%
User u = (User) session.getAttribute("userobj");
%>

<div class="container-fluid">
	<div class="row">

		<%
		String ch=request.getParameter("ch");
		BookDAOImpl dao2 = new BookDAOImpl(DBConnect.getConn());
		List<BookDtls> list2 = dao2.getBookBySearch(ch);

		for (BookDtls b : list2) {
		%>

		<div class="col-sm-6 col-md-3 mb-4">
			<div class="card crd-ho h-100 mt-2">
				<div class="card-body text-center">

					<img src="book/<%=b.getPhotoName()%>"
						 class="img-thumbnail mb-2"
						 style="width: 150px; height: 200px;">

					<p class="mb-1"><b><%=b.getBookName()%></b></p>
					<p class="mb-1"><%=b.getAuthor()%></p>
					<p class="mb-2">
						Category: <%=b.getBookCategory()%>
					</p>

					<div class="btn-group-custom">

						<%
						if (u == null) {
						%>
							<a href="login.jsp" class="btn btn-danger btn-sm">
								<i class="fa-solid fa-cart-arrow-down"></i> Add Cart
							</a>
						<%
						} else {
						%>
							<a href="<%=request.getContextPath()%>/cart?bid=<%=b.getBookId()%>"
							   class="btn btn-danger btn-sm">
							   <i class="fa-solid fa-cart-arrow-down"></i> Add Cart
							</a>
						<%
						}
						%>

						<a href="view_books.jsp?bid=<%=b.getBookId()%>"
						   class="btn btn-success btn-sm">
						   View Details
						</a>

						<a href="#" class="btn btn-sm price-btn">
							<i class="fa-solid fa-indian-rupee-sign"></i>
							<%=b.getPrice()%>
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

</body>
</html>
