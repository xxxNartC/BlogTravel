<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet"
      type="text/css" />
<link
    href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800"
    rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />

<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light" id="mainNav">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="home">Tourism Blog</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
                aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            Menu
            <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto py-4 py-lg-0">
                <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="home">Home</a></li>



                <c:if test="${sessionScope.user ne null}">

                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="my-post">My Post</a></li>
                    
                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="change-password">Change pass</a></li>
                    
                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="logout">Logout</a></li>
                    
                    <c:if test="${sessionScope.user.userRole ne 'User'}">

                        <li class="nav-link nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Management
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="users">User</a></li>
                                <li><a class="dropdown-item" href="categories">Category</a></li>
                                <li><a class="dropdown-item" href="posts">Post</a></li>
                                <li><a class="dropdown-item" href="comments">Comment</a></li>
                            </ul>
                        </li>
                        

                    </c:if>
                    
                </c:if>

                <c:if test="${sessionScope.user eq null}">
                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="login">Login</a></li>
                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="register">Register</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>