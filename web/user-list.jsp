<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Blog</title>

        <!-- DataTables CSS -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">

        <!-- Custom CSS -->

    </head>
    <body>

        <!-- Navigation-->
        <%@include file="header.jsp" %>

        <!-- Page Header-->
        <header class="masthead" style="background-image: url('assets/img/home-bg.jpg')"></header>

        <!-- Main Content-->
        <div class="container px-4 px-lg-5 mb-5">

            <!-- Button to trigger Add User modal -->
            <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addModal">
                Add User
            </button>
            
            <form action="" method="get">
                <input type="text" name="search" placeholder="Search...">
            </form>

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
                <table id="userTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>User Role</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.userID}</td>
                                <td>${user.username}</td>
                                <td>${user.email}</td>
                                <td>${user.userRole}</td>
                                <td>${user.status ? 'Active' : 'Inactive'}</td>
                                <td>
                                    <c:if test="${sessionScope.user.userID ne user.userID}">
                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                                data-bs-target="#editModal${user.userID}">
                                            Edit
                                        </button>
<!--                                            delete-->                                    
                                    </c:if>


                                </td>
                            </tr>

                            <!-- Modal for editing user -->
                        <div class="modal fade" id="editModal${user.userID}" tabindex="-1"
                             aria-labelledby="editModalLabel${user.userID}" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <!-- Added modal-lg class for large modal -->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editModalLabel${user.userID}">Edit User: ${user.username}</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Form fields for editing user -->
                                        <form action="users" method="post">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="userID" value="${user.userID}">
                                            <div class="mb-3">
                                                <!-- Added Bootstrap margin class -->
                                                <label for="editUsername${user.userID}" class="form-label">Username:</label>
                                                <input type="text" class="form-control" id="editUsername${user.userID}" name="username" value="${user.username}" required>
                                            </div>
                                            <!-- Hidden password field (if needed) -->
                                            <input type="hidden" id="editPassword${user.userID}" name="password" value="${user.password}">
                                            <div class="mb-3">
                                                <!-- Added Bootstrap margin class -->
                                                <label for="editEmail${user.userID}" class="form-label">Email:</label>
                                                <input type="email" class="form-control" id="editEmail${user.userID}" name="email" value="${user.email}" required>
                                            </div>
                                            <div class="mb-3">
                                                <!-- Added Bootstrap margin class -->
                                                <label for="editRole${user.userID}" class="form-label">Role:</label>
                                                <select class="form-select" id="editRole${user.userID}" name="role" required>
                                                    <option value="Admin" ${user.userRole == 'Admin' ? 'selected' : ''}>Admin</option>
                                                    <option value="User" ${user.userRole == 'User' ? 'selected' : ''}>User</option>
                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <!-- Added Bootstrap margin class -->
                                                <label for="editStatus${user.userID}" class="form-label">Status:</label>
                                                <select class="form-select" id="editStatus${user.userID}" name="status" required>
                                                    <option value="true" ${user.status ? 'selected' : ''}>Active</option>
                                                    <option value="false" ${!user.status ? 'selected' : ''}>Inactive</option>
                                                </select>
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
                        <!--delete-->

                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Modal for adding user -->
        <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg"> <!-- Added modal-lg class for large modal -->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addModalLabel">Add User</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Form fields for adding user -->
                        <form action="users" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="mb-3"> <!-- Added Bootstrap margin class -->
                                <label for="addUsername" class="form-label">Username:</label>
                                <input type="text" class="form-control" id="addUsername" name="username" required>
                            </div>
                            <label for="addPassword" class="form-label">Password:</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="addPassword" name="password" required>
                            </div>
                            <div class="mb-3"> <!-- Added Bootstrap margin class -->
                                <label for="addEmail" class="form-label">Email:</label>
                                <input type="email" class="form-control" id="addEmail" name="email" required>
                            </div>
                            <div class="mb-3"> <!-- Added Bootstrap margin class -->
                                <label for="addRole" class="form-label">Role:</label>
                                <select class="form-select" id="addRole" name="role" required>
                                    <option value="Admin">Admin</option>
                                    <option value="User">User</option>
                                </select>
                            </div>
                            <div class="mb-3"> <!-- Added Bootstrap margin class -->
                                <label for="addStatus" class="form-label">Status:</label>
                                <select class="form-select" id="addStatus" name="status" required>
                                    <option value="true">Active</option>
                                    <option value="false">Inactive</option>
                                </select>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add User</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!-- jQuery from CDN -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- DataTables JS -->
        <script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>

        <script>
            $(document).ready(function () {
                $('#userTable').DataTable({
                    "lengthChange": false,
                    "pageLength": 5,
                    "searching": false,
                });
            });
        </script>

    </body>
</html>



 <!--                                        <button type="button" class="btn btn-danger" data-bs-toggle="modal"
                                                                                        data-bs-target="#deleteModal${user.userID}">
                                                                                    Delete
                                                                                </button>-->





<!--                        <div class="modal fade" id="deleteModal${user.userID}" tabindex="-1"
                             aria-labelledby="deleteModalLabel${user.userID}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="deleteModalLabel${user.userID}">Confirm Delete</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        Are you sure you want to delete user? "${user.userID}"?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <form action="users" method="post">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="userID" value="${user.userID}">
                                            <button type="submit" class="btn btn-danger">Delete</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>-->