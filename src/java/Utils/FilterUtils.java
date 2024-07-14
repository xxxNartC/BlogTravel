package Utils;

import Model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "Filter", urlPatterns = {"/*"})
public class FilterUtils implements Filter {

    private FilterConfig filterConfig = null;

    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            log("Filter: Initializing filter");
        }
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String requestURI = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // Retrieve the user object from the session
        User user = (User) httpRequest.getSession().getAttribute("user");
        
        httpRequest.getContextPath();
        if (requestURI.equals("/users") || requestURI.equals("/categories") || requestURI.equals("/comments")) {
            if (user == null || user.getUserRole().toLowerCase().equals("user")) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
                return;
            }
        }

        // Continue the filter chain
        chain.doFilter(request, response);
    }

    public void destroy() {
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }
}
