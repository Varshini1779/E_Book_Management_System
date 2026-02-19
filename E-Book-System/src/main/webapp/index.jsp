<%@page import="com.entity.User"%>
<%@page import="com.entity.BookDtls"%>
<%@page import="java.util.List"%>
<%@page import="com.DAO.BookDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ebook:Index</title>
<%@include file="all_component/allCss.jsp"%>

<style type="text/css">
.back-img {
	background: url("img/b.jpg");
	height: 50vh;
	width: 100%;
	background-repeat: no-repeat;
	background-size: cover;
}

.crd-ho:hover {
	background-color: #eeeeee;
}

/* Align buttons in a row */
.btn-group-custom {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 5px; /* very small space between buttons */
	flex-wrap: nowrap; /* keeps all buttons in one row */
}

/* Red price button with white text */
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
<body style="background-color: #fafafa">
	<%
	User u = (User) session.getAttribute("userobj");
	%>
	<%@include file="all_component/navbar.jsp"%>

	<div
		class="container-fluid back-img text-center text-white d-flex align-items-center justify-content-center">
		<h2>E-Book Management System</h2>
	</div>

	<!-- ========== RECENT BOOKS ========== -->
	<div class="container my-4">
		<h3 class="text-center mb-4">Recent Books</h3>
		<div class="row">
			<%
			BookDAOImpl dao2 = new BookDAOImpl(DBConnect.getConn());
			List<BookDtls> list2 = dao2.getRecentBooks();
			for (BookDtls b : list2) {
			%>


			<div class="col-sm-6 col-md-3 mb-4">
				<div class="card crd-ho h-100">
					<div class="card-body text-center">
						<img
							src="<%=request.getContextPath()%>/book/<%=java.net.URLEncoder.encode(b.getPhotoName(), "UTF-8")%>"
							style="width: 150px; height: 200px;" />

						<p class="mb-1">
							<b><%=b.getBookName()%></b>
						</p>
						<p class="mb-1"><%=b.getAuthor()%></p>
						<p class="mb-2">


							<%
							if (b.getBookCategory().equals("Old")) {
							%>
							Category:
							<%=b.getBookCategory()%></p>
						<div class="btn-group-custom">
							<a href="view_books.jsp?bid=<%=b.getBookId()%>"
								class="btn btn-success btn-sm ml-2">View Details</a> <a href="#"
								class="btn btn-sm price-btn"> <i
								class="fa-solid fa-indian-rupee-sign"></i><%=b.getPrice()%>
							</a>
						</div>
						<%
						} else {
						%>
						Category:
						<%=b.getBookCategory()%></p>
						<div class="btn-group-custom">
							<%
							if (u == null) {
							%>
							<a href="Login.jsp" class="btn btn-danger btn-sm"> Add Cart </a>
							<%
							} else {
							%>

							<a href="cart?bid=<%=b.getBookId()%>&&uid=<%=u.getId()%>"
								class="btn btn-danger btn-sm"> Add Cart </a>


							<%
							}
							%>
							<a href="view_books.jsp?bid=<%=b.getBookId()%>"
								class="btn btn-success btn-sm">View Details</a> <a href="#"
								class="btn btn-sm price-btn"> <%=b.getPrice()%><i
								class="fa-solid fa-indian-rupee-sign"></i>
							</a>
						</div>
						<%
						}
						%>

					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>

		<div class="text-center mt-3">
			<a href="all_recent_book.jsp"
				class="btn btn-danger btn-sm text-white">View All</a>
		</div>
	</div>

	<hr>

	<!-- ========== NEW BOOKS ========== -->
	<div class="container my-4">
		<h3 class="text-center mb-4">New Books</h3>
		<div class="row">
			<%
			BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
			List<BookDtls> list = dao.getNewBook();
			for (BookDtls b : list) {
			%>
			<div class="col-sm-6 col-md-3 mb-4">
				<div class="card crd-ho h-100">
					<div class="card-body text-center">
						<img
							src="<%=request.getContextPath()%>/book/<%=java.net.URLEncoder.encode(b.getPhotoName(), "UTF-8")%>"
							style="width: 150px; height: 200px;" />

						<p class="mb-1">
							<b><%=b.getBookName()%></b>
						</p>
						<p class="mb-1"><%=b.getAuthor()%></p>
						<p class="mb-2">
							Category:
							<%=b.getBookCategory()%></p>

						<div class="btn-group-custom">

							<%
							if (u == null) {
							%>
							<a href="Login.jsp" class="btn btn-danger btn-sm"> Add Cart </a>
							<%
							} else {
							%>

							<a href="cart?bid=<%=b.getBookId()%>&&uid=<%=u.getId()%>"
								class="btn btn-danger btn-sm"> Add Cart </a>


							<%
							}
							%>

							<a href=" view_books.jsp?bid=<%=b.getBookId()%>"
								class="btn btn-success btn-sm">View Details</a> <a href="#"
								class="btn btn-sm price-btn"> <i
								class="fa-solid fa-indian-rupee-sign"></i><%=b.getPrice()%>
							</a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>

		<div class="text-center mt-3">
			<a href="all_new_book.jsp" class="btn btn-danger btn-sm text-white">View
				All</a>
		</div>
	</div>

	<hr>



	<!-- ========== OLD BOOKS ========== -->
	<div class="container my-4">
		<h3 class="text-center mb-4">Old Books</h3>
		<div class="row">
			<%
			BookDAOImpl dao3 = new BookDAOImpl(DBConnect.getConn());
			List<BookDtls> list3 = dao3.getAllOldBook(); // fetch all old books
			for (BookDtls b : list3) {
			%>
			<div class="col-sm-6 col-md-3 mb-4">
				<div class="card crd-ho h-100">
					<div class="card-body text-center">
						<img
							src="<%=request.getContextPath()%>/book/<%=java.net.URLEncoder.encode(b.getPhotoName(), "UTF-8")%>"
							style="width: 150px; height: 200px;" class="img-thumbnail mb-2" />
						<p class="mb-1">
							<b><%=b.getBookName()%></b>
						</p>
						<p class="mb-1"><%=b.getAuthor()%></p>
						<p class="mb-2">
							Category:
							<%=b.getBookCategory()%></p>
						<div class="btn-group-custom">
							<a href="view_books.jsp?bid=<%=b.getBookId()%>"
								class="btn btn-success btn-sm">View Details</a> <a href="#"
								class="btn btn-sm price-btn">₹<%=b.getPrice()%></a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
		<div class="text-center mt-3">
			<a href="all_old_book.jsp" class="btn btn-danger btn-sm text-white">View
				All</a>
		</div>
	</div>

	<%@include file="all_component/footer.jsp"%>
</body>
</html>
