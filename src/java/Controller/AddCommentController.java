/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.CommentDAO;
import Model.Comment;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/add-comment")
public class AddCommentController extends HttpServlet {

    private CommentDAO commentDAO;

    public void init() {
        commentDAO = new CommentDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve comment details from the form
        String commentText = request.getParameter("commentText").trim();
        int postId = Integer.parseInt(request.getParameter("postId"));

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        if (commentText.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/post-detail?fail=update&id=" + postId);
        } else {
            Comment comment = new Comment();
            comment.setCommentText(commentText);
            comment.setPostID(postId);
            comment.setUserID(user.getUserID());
            comment.setStatus(true);

            // Add the comment using the service
            commentDAO.addComment(comment);
            response.sendRedirect(request.getContextPath() + "/post-detail?id=" + postId);
        }

    }

    // Other methods for handling comment editing, deletion, etc. can be added here
}

//if (commentText.isBlank() ) {
//            response.sendRedirect(request.getContextPath() + "/post-detail?fail=update&id=" + postId);
//        } else {
//            // Create a new comment object
//            Comment comment = new Comment();
//            comment.setCommentText(commentText);
//            comment.setPostID(postId);
//            comment.setUserID(user.getUserID());
//            comment.setStatus(true);
//
//            // Add the comment using the service
//            commentDAO.addComment(comment);
//
//            response.sendRedirect(request.getContextPath() + "/post-detail?id=" + postId);
//        }
