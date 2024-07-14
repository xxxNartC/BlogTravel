/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {

    public UserDAO() {
        super();
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM Users";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User user = mapResultSetToUser(rs);
                users.add(user);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return users;
    }
    //search user by id 
    public List<User> searchUserByID(String search) {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM Users WHERE Username LIKE '" + search + "%'";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User user = mapResultSetToUser(rs);
                users.add(user);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return users;
    }
    //search user by username 
//    public List<User> searchUserByUsername(String search) {
//        List<User> users = new ArrayList<>();
//        String query = "SELECT * FROM Users WHERE Username LIKE '%" + search + "%'";
//        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
//            while (rs.next()) {
//                User user = mapResultSetToUser(rs);
//                users.add(user);
//            }
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
//        return users;
//    }

    public User getUserByID(int userID) {
        User user = null;
        String query = "SELECT * FROM Users WHERE UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = mapResultSetToUser(rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return user;
    }

    public User getUserByUsername(String username) {
        User user = null;
        String query = "SELECT * FROM Users WHERE Username = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = mapResultSetToUser(rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return user;
    }

    public boolean addUser(User user) {
        String query = "INSERT INTO Users (Username, Password, Email, UserRole, Status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getUserRole());
            ps.setBoolean(5, user.isStatus());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean updateUser(User user) {
        String query = "UPDATE Users SET Username = ?, Password = ?, Email = ?, UserRole = ?, Status = ? WHERE UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getUserRole());
            ps.setBoolean(5, user.isStatus());
            ps.setInt(6, user.getUserID());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean deleteUser(int userID) {
        String query = "DELETE FROM Users WHERE UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserID(rs.getInt("UserID"));
        user.setUsername(rs.getString("Username"));
        user.setPassword(rs.getString("Password"));
        user.setEmail(rs.getString("Email"));
        user.setUserRole(rs.getString("UserRole"));
        user.setStatus(rs.getBoolean("Status"));
        user.setRegistrationDate(rs.getDate("RegistrationDate"));
        return user;
    }

    public static void main(String[] args) {
        UserDAO u = new UserDAO();
        List<User> d = u.getAllUsers();
        boolean usernameExists = false;
        for (User user : d) {
            if (user.getUsername().equalsIgnoreCase("a")) {
                System.out.println("DAL.UserDAO.main()");
                usernameExists = true;
                break;
            }
        }
    }

}
