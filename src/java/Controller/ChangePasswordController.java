package Controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model.User;
import DAL.UserDAO;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get user inputs from the form
        String username = request.getParameter("username");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check if new password and confirmation password match
        if (!newPassword.equals(confirmPassword)) {
            // Passwords do not match
            request.setAttribute("error", "New password and confirmation password do not match.");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        // Retrieve the user from the database
        UserDAO userDao = new UserDAO();
        User user = userDao.getUserByUsername(username);

        if (user != null && user.getPassword().equals(currentPassword)) {
            // Update the user's password
            user.setPassword(newPassword);
            boolean success = userDao.updateUser(user);

            if (success) {
                // Password updated successfully
                request.setAttribute("message", "Password updated successfully!");
            } else {
                // Failed to update password
                request.setAttribute("error", "Failed to update password. Please try again later.");
            }
        } else {
            // Invalid username or password
            request.setAttribute("error", "Wrong password.");
        }

        // Forward back to the change password page
        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
    }
}
