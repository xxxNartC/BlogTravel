/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.Comment;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO extends DBContext {

    public CommentDAO() {
        super();
    }

    public List<Comment> getAllComments() {
        List<Comment> comments = new ArrayList<>();
        String query = "SELECT * FROM Comments";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Comment comment = mapResultSetToComment(rs);
                comments.add(comment);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return comments;
    }

    public Comment getCommentByID(int commentID) {
        Comment comment = null;
        String query = "SELECT * FROM Comments WHERE CommentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, commentID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    comment = mapResultSetToComment(rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return comment;
    }

    public boolean addComment(Comment comment) {
        String query = "INSERT INTO Comments (PostID, UserID, CommentText, CommentDate, Status) VALUES (?, ?, ?, GETDATE(), ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, comment.getPostID());
            ps.setInt(2, comment.getUserID());
            ps.setString(3, comment.getCommentText());
            ps.setBoolean(4, comment.isStatus());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean updateComment(Comment comment) {
        String query = "UPDATE Comments SET PostID = ?, UserID = ?, CommentText = ?, CommentDate = ?, Status = ? WHERE CommentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, comment.getPostID());
            ps.setInt(2, comment.getUserID());
            ps.setString(3, comment.getCommentText());
            ps.setDate(4, new java.sql.Date(comment.getCommentDate().getTime()));
            ps.setBoolean(5, comment.isStatus());
            ps.setInt(6, comment.getCommentID());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean deleteComment(int commentID) {
        String query = "DELETE FROM Comments WHERE CommentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, commentID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public List<Comment> getCommentsByPostID(int postID) {
        List<Comment> comments = new ArrayList<>();
        String query = "SELECT * FROM Comments WHERE PostID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, postID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Comment comment = mapResultSetToComment(rs);
                    comments.add(comment);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return comments;
    }

    private Comment mapResultSetToComment(ResultSet rs) throws SQLException {
        Comment comment = new Comment();
        comment.setCommentID(rs.getInt("CommentID"));
        comment.setPostID(rs.getInt("PostID"));
        comment.setUserID(rs.getInt("UserID"));
        comment.setCommentText(rs.getString("CommentText"));
        comment.setCommentDate(rs.getDate("CommentDate"));
        comment.setStatus(rs.getBoolean("Status"));
        return comment;
    }
}
