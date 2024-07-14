/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import DAL.UserDAO;
import Model.User;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // Create a new user object
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setEmail(email);
        newUser.setUserRole("User");
        newUser.setStatus(true);

        // Add the new user to the database
        boolean userAdded = userDAO.addUser(newUser);

        if (userAdded) {
            // Registration successful
            response.sendRedirect("login");
        } else {
            // Registration failed
            request.setAttribute("errorMessage", "Registration failed. Please try again later.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}

// Check if username already exists
//        User existingUser = userDAO.getUserByUsername(username);
//        if (existingUser != null) {
//            request.setAttribute("errorMessage", "Username already exists");
//            request.getRequestDispatcher("register.jsp").forward(request, response);
//            return;
//        }
//        if (username != null && username.isBlank()) {
//            request.setAttribute("errorMessage", "Username can not empty!!");
//            request.getRequestDispatcher("register.jsp").forward(request, response);
//            return;
//        }
