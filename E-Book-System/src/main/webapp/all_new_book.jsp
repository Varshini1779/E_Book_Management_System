<%@page import="com.entity.User"%>
<%@page import="com.entity.BookDtls"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="java.util.List"%>
<%@page import="com.DAO.BookDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All new Book</title>
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
/* toast */
#toast {
	min-width: 300px;
	position: fixed;
	bottom: 30px;
	left: 50%;
	margin-left: -125px;
	background: #333;
	padding: 10px;
	color: white;
	text-align: center;
	z-index: 1;
	font-size: 18px;
	visibility: hidden;
	box-shadow: 0px 0px 100px #000;
}

#toast.display {
	visibility: visible;
	animation: fadeIn 0.5, fadeOut 0.5s 2.5s;
}

@
keyframes fadeIn {from { bottom:0;
	opacity: 0;
}

to {
	bottom: 30px;
	opacity: 1;
}

}
@
keyframes fadeOut {form { bottom:30px;
	opacity: 1;
}

to {
	bottom: 0;
	opacity: 0;
}
}

/* toast */
</style>
</head>
<body>
	<%
	User u = (User) session.getAttribute("userobj");
	%>
	<c:if test="${not empty addCart }">
		<div id="toast">${addCart }</div>
		<script type="text/javascript">
showToast();
function showToast(content){
$('#toast').addClass("display");
$('#toast').html(content);
setTimeout(()=>{
$("#toast").removeClass("display");
},2000)
}
</script>
		<c:remove var="addCart" scope="session" />
	</c:if>

	<%@include file="all_component/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row">

			<%
			BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
			List<BookDtls> list = dao.getAllNewBook();
			for (BookDtls b : list) {
			%>
			<div class="col-sm-6 col-md-3 mb-4">
				<div class="card crd-ho h-100 mt-2">
					<div class="card-body text-center">
						<img src="book/<%=b.getPhotoName()%>" alt=""
							class="img-thumbnail mb-2" style="width: 150px; height: 200px;">
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
							<a href="Login.jsp" class="btn btn-danger btn-sm"> <i
								class="fa-solid fa-cart-arrow-down"></i> Add Cart
							</a>
							<%
							} else {
							%>

							<a href="cart?bid=<%=b.getBookId()%>&&uid=<%=u.getId()%>"
								class="btn btn-danger btn-sm">Add Cart </a>


							<%
							}
							%>
							<a href="view_books.jsp?bid=<%=b.getBookId()%>"
								class="btn btn-success btn-sm">View Details</a> <a href="#"
								class="btn btn-sm price-btn"> <i
								class="fa-solid fa-indian-rupee-sign"></i> <%= b.getPrice()%>
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