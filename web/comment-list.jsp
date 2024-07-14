<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Comment List</title>
        <!-- DataTables CSS -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    </head>
    <body>

        <!-- Navigation-->
        <%@include file="header.jsp" %>

        <!-- Page Header-->
        <header class="masthead" style="background-image: url('assets/img/home-bg.jpg')"></header>

        <!-- Main Content-->
        <div class="container px-4 px-lg-5 mb-5">
            <h2>Comment List</h2>

            <c:if test="${param.success ne null}">
                <div class="alert alert-success" role="alert">
                    Success!
                </div>
            </c:if>
            <c:if test="${param.fail ne null}">
                <div class="alert alert-danger" role="alert">
                    Failed!
                </div>
            </c:if>

            <div class="table-responsive">
                <table id="commentTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                        <tr>
                            <th>Comment Text</th>
                            <th>User</th>
                            <th>Post</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="comment" items="${comments}">
                            <tr>
                                <td>${comment.commentText}</td>
                                <td>${comment.userID}</td>
                                <td>${comment.postID}</td>
                                <td>${comment.status ? 'Active' : 'Inactive'}</td>
                                <td>
<!--                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                            data-bs-target="#editModal${comment.commentID}">
                                        Edit
                                    </button>-->
                                    <!-- Delete Button -->
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal"
                                            data-bs-target="#deleteModal${comment.commentID}">
                                        Delete
                                    </button>
                                </td>
                            </tr>

                            <!-- Modal for confirming deletion -->
                        <div class="modal fade" id="deleteModal${comment.commentID}" tabindex="-1"
                             aria-labelledby="deleteModalLabel${comment.commentID}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="deleteModalLabel${comment.commentID}">Confirm Delete</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        Are you sure you want to delete the comment "${comment.commentText}"?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <form action="comments" method="post">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="commentID" value="${comment.commentID}">
                                            <button type="submit" class="btn btn-danger">Delete</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- jQuery from CDN -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- DataTables JS -->
        <script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>

        <script>
            $(document).ready(function () {
                $('#commentTable').DataTable({
                    "lengthChange": false,
                    "pageLength": 5
                });
            });
        </script>

    </body>
</html>
