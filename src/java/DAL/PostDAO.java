/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.Post;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PostDAO extends DBContext {

    public PostDAO() {
        super();
    }

    public List<Post> getAllPosts() {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT * FROM Posts";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Post post = mapResultSetToPost(rs);
                posts.add(post);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return posts;
    }

    public Post getPostByID(int postID) {
        Post post = null;
        String query = "SELECT * FROM Posts WHERE PostID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, postID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    post = mapResultSetToPost(rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return post;
    }

    public boolean addPost(Post post) {
        String query = "INSERT INTO Posts (Title, Content, AuthorID, CategoryID, Status, LikesCount) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setInt(3, post.getAuthorID());
            ps.setInt(4, post.getCategoryID());
            ps.setBoolean(5, post.isStatus());
            ps.setInt(6, post.getLikesCount());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean updatePost(Post post) {
        String query = "UPDATE Posts SET Title = ?, Content = ?, AuthorID = ?, CategoryID = ?, Status = ?, LikesCount = ? WHERE PostID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setInt(3, post.getAuthorID());
            ps.setInt(4, post.getCategoryID());
            ps.setBoolean(5, post.isStatus());
            ps.setInt(6, post.getLikesCount());
            ps.setInt(7, post.getPostID());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean deletePost(int postID) {
        String query = "DELETE FROM Posts WHERE PostID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, postID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public List<Post> getAllPostsByStatus(boolean status) {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT * FROM Posts WHERE Status = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setBoolean(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Post post = mapResultSetToPost(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return posts;
    }

    public List<Post> getPostsByAuthorID(int authorID) {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT * FROM Posts WHERE AuthorID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, authorID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Post post = mapResultSetToPost(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return posts;
    }

    public Post getRandomActivePost() {
        Post post = null;
        String query = "SELECT TOP 1 * FROM Posts WHERE Status = 1 ORDER BY NEWID()";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    post = mapResultSetToPost(rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return post;
    }

    private Post mapResultSetToPost(ResultSet rs) throws SQLException {
        Post post = new Post();
        post.setPostID(rs.getInt("PostID"));
        post.setTitle(rs.getString("Title"));
        post.setContent(rs.getString("Content"));
        post.setAuthorID(rs.getInt("AuthorID"));
        post.setCategoryID(rs.getInt("CategoryID"));
        post.setStatus(rs.getBoolean("Status"));
        post.setPublishedDate(rs.getDate("PublishedDate"));
        post.setLikesCount(rs.getInt("LikesCount"));
        return post;
    }
}
