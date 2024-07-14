<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Category List</title>
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
            <h2>Category List</h2>

            <!-- Button to trigger Add Category modal -->
            <button type="button" class="btn btn-primary mb-3 mt-3" data-bs-toggle="modal" data-bs-target="#addModal">
                Add Category
            </button>

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
                <table id="categoryTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                        <tr>
                            <th>Category Name</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categories}">
                            <tr>
                                <td>${category.categoryName}</td>
                                <td>
                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                            data-bs-target="#editModal${category.categoryID}">
                                        Edit
                                    </button>
                                    <!-- Delete Button -->
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal"
                                            data-bs-target="#deleteModal${category.categoryID}">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                            
                            <!-- Modal for editing category -->
                        <div class="modal fade" id="editModal${category.categoryID}" tabindex="-1"
                             aria-labelledby="editModalLabel${category.categoryID}" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editModalLabel${category.categoryID}">Edit Category: ${category.categoryName}</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Form fields for editing category -->
                                        <form action="categories" method="post">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="categoryID" value="${category.categoryID}">
                                            <div class="mb-3">
                                                <label for="editCategoryName${category.categoryID}" class="form-label">Category Name:</label>
                                                <input type="text" class="form-control" id="editCategoryName${category.categoryID}" name="categoryName" value="${category.categoryName}" required>
                                            </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Modal for confirming deletion -->
                        <div class="modal fade" id="deleteModal${category.categoryID}" tabindex="-1"
                             aria-labelledby="deleteModalLabel${category.categoryID}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="deleteModalLabel${category.categoryID}">Confirm Delete</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        Are you sure you want to delete the category "${category.categoryName}"?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <form action="categories" method="post">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="categoryID" value="${category.categoryID}">
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

        <!-- Modal for adding category -->
        <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addModalLabel">Add Category</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Form fields for adding category -->
                        <form action="categories" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="mb-3">
                                <label for="addCategoryName" class="form-label">Category Name:</label>
                                <input type="text" class="form-control" id="addCategoryName" name="categoryName" required>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Category</button>
                        </form>
                    </div>
                </div>
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
                $('#categoryTable').DataTable({
                    "lengthChange": false,
                    "pageLength": 5,
                    "search": false,
                });
            });
        </script>

    </body>
</html>
