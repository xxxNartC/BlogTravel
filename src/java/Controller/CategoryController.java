package Controller;

import DAL.CategoryDAO;
import Model.Category;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/categories")
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CategoryDAO categoryDAO;

    public void init() {
        categoryDAO = new CategoryDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/category-list.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "delete":
                    deleteCategory(request, response);
                    break;
                case "add":
                    addCategory(request, response);
                    break;
                case "update":
                    updateCategory(request, response);
                    break;
                default:
                    // Invalid action
                    response.sendRedirect(request.getContextPath() + "/categories");
                    break;
            }
        } else {
            // No action specified
            response.sendRedirect(request.getContextPath() + "/categories");
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int categoryID = Integer.parseInt(request.getParameter("categoryID"));
        boolean deleted = categoryDAO.deleteCategory(categoryID);
        if (deleted) {
            response.sendRedirect(request.getContextPath() + "/categories?success=delete");
        } else {
            response.sendRedirect(request.getContextPath() + "/categories?fail=delete");
        }
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve category details from the form
        String categoryName = request.getParameter("categoryName");

        // Create a new Category object
        Category newCategory = new Category();
        newCategory.setCategoryName(categoryName);

        // Add the new category to the database
        boolean added = categoryDAO.addCategory(newCategory);
        if (added) {
            response.sendRedirect(request.getContextPath() + "/categories?success=add");
        } else {
            response.sendRedirect(request.getContextPath() + "/categories?fail=add");
        }
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve category details from the form
        int categoryID = Integer.parseInt(request.getParameter("categoryID"));
        String categoryName = request.getParameter("categoryName");

        // Create a Category object with updated details
        Category updatedCategory = new Category();
        updatedCategory.setCategoryID(categoryID);
        updatedCategory.setCategoryName(categoryName);

        // Update the category in the database
        boolean updated = categoryDAO.updateCategory(updatedCategory);
        if (updated) {
            response.sendRedirect(request.getContextPath() + "/categories?success=update");
        } else {
            response.sendRedirect(request.getContextPath() + "/categories?fail=update");
        }
    }

}
