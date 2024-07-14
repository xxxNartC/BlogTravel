<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Blog</title>

    </head>
    <body>

        <!-- Navigation-->
        <%@include file="header.jsp" %>

        <!-- Page Header-->
        <header class="masthead" style="background-image: url('assets/img/home-bg.jpg')"></header>

        <!-- Main Content-->
        <div class="container px-4 px-lg-5">
            <div class="row gx-4 gx-lg-5 justify-content-center">
                <div class="col-md-10 col-lg-8 col-xl-7">
                    <!-- Post previews -->
                    <c:forEach var="post" items="${listPost}">
                        <div class="post-preview">
                            <a href="post-detail?id=${post.postID}">
                                <h2 class="post-title">${post.title}</h2>
                                <h5 class="post-subtitle">${fn:substring(post.content, 0, 200)}</h5>
                            </a>
                            <p class="post-meta">
                                Posted by <a href="#">${post.user.username}</a> on ${post.publishedDate}
                            </p>
                        </div>
                        <!-- Divider-->
                        <hr class="my-4" />
                    </c:forEach>

                    <!-- Pager-->
                    <div class="d-flex justify-content-end mb-4"><a class="btn btn-primary text-uppercase" href="home?count=${count + countStep}">More Posts</a></div>
                </div>
            </div>
        </div>

        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>

    </body>
</html>
