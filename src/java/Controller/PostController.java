package Controller;

import DAL.PostDAO;
import Model.Post;
import Model.User;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/posts")
public class PostController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PostDAO postDAO;

    public void init() {
        postDAO = new PostDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        List<Post> posts = postDAO.getAllPosts();
        if (user != null && user.getUserRole().equals("User")) {
            posts = postDAO.getPostsByAuthorID(user.getUserID());
        }

        request.setAttribute("posts", posts);
        request.getRequestDispatcher("/post-list.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "delete":
                    deletePost(request, response);
                    break;
                case "add":
                    addPost(request, response);
                    break;
                case "update":
                    updatePost(request, response);
                    break;
                default:
                    // Invalid action
                    response.sendRedirect(request.getContextPath() + "/posts");
                    break;
            }
        } else {
            // No action specified
            response.sendRedirect(request.getContextPath() + "/posts");
        }
    }

    private void deletePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postID = Integer.parseInt(request.getParameter("postID"));
        boolean deleted = postDAO.deletePost(postID);
        if (deleted) {
            response.sendRedirect(request.getContextPath() + "/posts?success=delete");
        } else {
            response.sendRedirect(request.getContextPath() + "/posts?fail=delete");
        }
    }

    private void addPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve post details from the form
        PostDAO p = new PostDAO();
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int authorID = Integer.parseInt(request.getParameter("authorID"));
        int categoryID = Integer.parseInt(request.getParameter("categoryID"));
        boolean status = Boolean.parseBoolean(request.getParameter("status"));

        List<Post> u = p.getAllPosts();
        boolean usernameExists = false;
        for (Post post : u) {
            if (post.getTitle().equalsIgnoreCase(title)) {
                usernameExists = true;
                break;
            }
        }
        Post newPost = new Post();
        // Create a User object with updated details
        if (!title.isBlank()) {
            newPost.setTitle(title);
        }

        // Create a new Post object
        newPost.setContent(content);
        newPost.setAuthorID(authorID);
        newPost.setCategoryID(categoryID);
        newPost.setStatus(status);
        // Set other properties as needed

        // Add the new post to the database
        boolean added = postDAO.addPost(newPost);
        if (added) {
            response.sendRedirect(request.getContextPath() + "/posts?success=add");
        } else {
            response.sendRedirect(request.getContextPath() + "/posts?fail=add");
        }
    }

    private void updatePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve post details from the form
        int postID = Integer.parseInt(request.getParameter("postID"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int authorID = Integer.parseInt(request.getParameter("authorID"));
        int categoryID = Integer.parseInt(request.getParameter("categoryID"));
        boolean status = Boolean.parseBoolean(request.getParameter("status")); // Retrieve status from request parameter

        // Create a Post object with updated details
        Post updatedPost = new Post();
        updatedPost.setPostID(postID);
        updatedPost.setTitle(title);
        updatedPost.setContent(content);
        updatedPost.setAuthorID(authorID);
        updatedPost.setCategoryID(categoryID);
        updatedPost.setStatus(status);
        // Set other properties as needed

        // Update the post in the database
        boolean updated = postDAO.updatePost(updatedPost);
        if (updated) {
            response.sendRedirect(request.getContextPath() + "/posts?success=update");
        } else {
            response.sendRedirect(request.getContextPath() + "/posts?fail=update");
        }
    }
}

//        List<User> u = d.getAllUsers();
//        boolean usernameExists = false;
//        for (User user : u) {
//            if (user.getUsername().equalsIgnoreCase(username)) {
//                usernameExists = true;
//                break;
//            }
//        }
//
//        // Create a User object with updated details
//             
//        if (!username.isBlank() && !usernameExists) {
//            updatedUser.setUsername(username);
//        }
