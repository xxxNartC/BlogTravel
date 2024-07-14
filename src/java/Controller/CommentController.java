package Controller;

import DAL.CommentDAO;
import Model.Comment;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;

@WebServlet("/comments")
public class CommentController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CommentDAO commentDAO;

    public void init() {
        commentDAO = new CommentDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Comment> comments = commentDAO.getAllComments();
        request.setAttribute("comments", comments);
        request.getRequestDispatcher("/comment-list.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "delete":
                    deleteComment(request, response);
                    break;
                case "add":
                    addComment(request, response);
                    break;
                case "update":
                    updateComment(request, response);
                    break;
                default:
                    // Invalid action
                    response.sendRedirect(request.getContextPath() + "/comments");
                    break;
            }
        } else {
            // No action specified
            response.sendRedirect(request.getContextPath() + "/comments");
        }
    }

    private void deleteComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int commentID = Integer.parseInt(request.getParameter("commentID"));
        boolean deleted = commentDAO.deleteComment(commentID);
        if (deleted) {
            response.sendRedirect(request.getContextPath() + "/comments?success=delete");
        } else {
            response.sendRedirect(request.getContextPath() + "/comments?fail=delete");
        }
    }

    private void addComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve comment details from the form
        int postID = Integer.parseInt(request.getParameter("postID"));
        int userID = Integer.parseInt(request.getParameter("userID"));
        String commentText = request.getParameter("commentText");
        Date commentDate = new Date(); // Assuming current date/time
        boolean status = true; // Assuming new comments are active by default

        // Create a new Comment object
        Comment newComment = new Comment();
        newComment.setPostID(postID);
        newComment.setUserID(userID);
        newComment.setCommentText(commentText);
        newComment.setCommentDate(commentDate);
        newComment.setStatus(status);

        // Add the new comment to the database
        boolean added = commentDAO.addComment(newComment);
        if (added) {
            response.sendRedirect(request.getContextPath() + "/comments?success=add");
        } else {
            response.sendRedirect(request.getContextPath() + "/comments?fail=add");
        }
    }

    private void updateComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve comment details from the form
        int commentID = Integer.parseInt(request.getParameter("commentID"));
        int postID = Integer.parseInt(request.getParameter("postID"));
        int userID = Integer.parseInt(request.getParameter("userID"));
        String commentText = request.getParameter("commentText");
        boolean status = Boolean.parseBoolean(request.getParameter("status")); // Assuming status can be updated

        // Create a Comment object with updated details
        Comment updatedComment = new Comment();
        updatedComment.setCommentID(commentID);
        updatedComment.setPostID(postID);
        updatedComment.setUserID(userID);
        updatedComment.setCommentText(commentText);
        updatedComment.setStatus(status);

        // Update the comment in the database
        boolean updated = commentDAO.updateComment(updatedComment);
        if (updated) {
            response.sendRedirect(request.getContextPath() + "/comments?success=update");
        } else {
            response.sendRedirect(request.getContextPath() + "/comments?fail=update");
        }
    }

}
