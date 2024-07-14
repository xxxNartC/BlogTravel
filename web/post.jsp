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
        <header class="masthead" style="background-image: url('assets/img/home-bg.jpg')">
            <div class="container position-relative px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <div class="post-heading">
                            <h1>${post.title}</h1>
                            <span class="meta">
                                Posted by
                                <a href="#!">${post.user.username}</a>
                                on ${post.publishedDate}
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <style>
            .container img {
                width: 100%;
            }
        </style>

        <!-- Main Content-->
        <article class="mb-4">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    ${post.content}
                </div>
            </div>
        </article>


        <!-- Comments Section -->
        <section class="mb-4">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <h2 class="text-center mb-4">Comments</h2>
                        <!-- Display existing comments -->
                        <ul class="list-unstyled mb-5">
                            <c:forEach var="comment" items="${comments}">
                                <li class="media mb-4">
                                    <img class="d-flex mr-3 rounded-circle" src="..." alt="">
                                    <div class="media-body">
                                        <h5 class="mt-0 mb-1">${comment.user.username}</h5>
                                        ${comment.status ? comment.commentText : 'REMOVED'}
                                        <div class="text-muted">${comment.commentDate}</div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        <!-- Comment Form -->
                        <form class="mb-5" action="add-comment" method="post">
                            <input type="hidden" name="postId" value="${post.postID}">
                            <div></div>
                            <div class="mb-3">
                                <label for="commentText" class="form-label">Add a comment:</label>
                                <textarea class="form-control" id="commentText" name="commentText" rows="3" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>

    </body>
</html>
