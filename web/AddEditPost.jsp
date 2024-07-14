<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Blog</title>
        <!-- Include Quill.js CSS -->
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    </head>
    <body>

        <!-- Navigation-->
        <%@include file="header.jsp" %>

        <!-- Page Header-->
        <header class="masthead" style="background-image: url('assets/img/home-bg.jpg')"></header>

        <!-- Main Content-->
        <div class="container px-4 px-lg-5 mb-5">
            <form action="posts" method="post">
                <input type="hidden" name="action" value="${action}">
                <input type="hidden" name="postID" value="${post.postID}">

                <div class="mb-3">
                    <label for="editTitle${post.postID}" class="form-label">Title:</label>
                    <input type="text" class="form-control" id="editTitle${post.postID}" name="title" value="${post.title}" required>
                </div>

                <!-- Replace textarea with Quill.js editor -->
                <div class="mb-3">
                    <label for="editContent${post.postID}" class="form-label">Content:</label>
                    <div id="editor-container${post.postID}" style="height: 900px;">${post.content}</div>
                    <input type="hidden" id="editContent${post.postID}" name="content">
                </div>

                <input type="hidden" class="form-control" id="editAuthorID${post.postID}" name="authorID" value="${post ne null ? post.authorID : sessionScope.user.userID}">

                <div class="mb-3">
                    <label for="editCategoryID${post.postID}" class="form-label">Category:</label>
                    <select class="form-select" id="editCategoryID${post.postID}" name="categoryID" required>
                        <c:forEach var="category" items="${listCategory}">
                            <option value="${category.categoryID}" ${category.categoryID == post.categoryID ? 'selected' : ''}>${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>


                <c:if test="${sessionScope.user.userRole eq 'Admin'}">
                    <div class="mb-3">
                        <label for="editStatus${post.postID}" class="form-label">Status:</label>
                        <select class="form-select" id="editStatus${post.postID}" name="status" required>
                            <option value="false" ${!post.status ? 'selected' : ''}>Inactive</option>
                            <option value="true" ${post.status|| post==null ? 'selected' : ''}>Active</option>
                        </select>
                    </div>
                </c:if>
                <c:if test="${sessionScope.user.userRole eq 'User'}">
                    <input type="hidden" name="status" value="${post.status}">
                </c:if>

                <!-- Add more fields as needed -->

                <button type="submit" class="btn btn-primary">Save changes</button>
            </form>

        </div>

        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- Quill.js library -->
        <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
        <!-- Initialize Quill.js editor -->
        <script>
            var quill = new Quill('#editor-container${post.postID}', {
                theme: 'snow',
                modules: {
                    toolbar: [
                        [{'header': [1, 2, 3, false]}],
                        ['bold', 'italic', 'underline', 'strike'],
                        [{'align': []}],
                        [{'list': 'ordered'}, {'list': 'bullet'}],
                        ['link', 'image'],
                        ['clean']
                    ]
                }
            });

            // Save Quill content to hidden input on form submit
            document.querySelector('form').onsubmit = function () {
                var html = document.querySelector('.ql-editor').innerHTML;
                document.querySelector('#editContent${post.postID}').value = html;
            };
        </script>

    </body>
</html>
