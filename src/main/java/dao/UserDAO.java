package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.User;

public class UserDAO {
	private String jdbcURL = "jdbc:mysql://localhost:3306/demo?useSSL=false";
	private String jdbcUsername = "user001";
	private String jdbcPassword = "password_001";

	private static final String INSERT_USERS_SQL = "INSERT INTO users" + "  (name, last_name, email, age, country, city) VALUES "
			+ " (?, ?, ?, ?, ?, ?);";

	private static final String SELECT_ALL_USERS = "select * from users";
	private static final String DELETE_USERS_SQL = "delete from users where id = ?;";
	private static final String UPDATE_USERS_SQL = "update users set name = ?, last_name = ?, email= ?, age = ?, country = ?, city = ? where id = ?;";

	public UserDAO() {
	}

	protected Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return connection;
	}
	
	public List<User> selectAllUsers() {
		// Declaración y inicialización de un ArrayList
		List<User> users = new ArrayList<>();
		// Crear conexión
		try (Connection connection = getConnection();

			// Preparar la consulta SQL
			PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS);) {
			
			// Ejecutar consulta SQL
			ResultSet rs = preparedStatement.executeQuery();

			// Procesar el resultado SQL
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String last_name = rs.getString("last_name");
				String email = rs.getString("email");
				int age = rs.getInt("age");
				String country = rs.getString("country");
				String city = rs.getString("city");
				users.add(new User(id, name, last_name, email, age, country, city));
			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return users;
	}
	
	public String createUser(User user) throws SQLException {
		System.out.println(INSERT_USERS_SQL);

		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {
			preparedStatement.setString(1, user.getName());
			preparedStatement.setString(2, user.getLast_name());
			preparedStatement.setString(3, user.getEmail());
			preparedStatement.setInt(4, user.getAge());
			preparedStatement.setString(5, user.getCountry());
			preparedStatement.setString(6, user.getCity());
			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();
			
			return "OK";
		} catch (SQLException e) {
			printSQLException(e);
			return "Error";
		}
	}
	
	public String editUser(User user) throws SQLException {
		
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(UPDATE_USERS_SQL);) {
			statement.setString(1, user.getName());
			statement.setString(2, user.getLast_name());
			statement.setString(3, user.getEmail());
			statement.setInt(4, user.getAge());
			statement.setString(5, user.getCountry());
			statement.setString(6, user.getCity());
			statement.setInt(7, user.getId());

			if (statement.executeUpdate() > 0) {
				return "OK";
			} else {
				return "Error";
			}
		} catch (SQLException e) {
			printSQLException(e);
			return "Error";
		}
		
	}
	
	public String deleteUser(int id) throws SQLException {
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(DELETE_USERS_SQL);) {
			statement.setInt(1, id);
			if (statement.executeUpdate() > 0) {
				return "OK";
			} else {
				return "Error";
			}
			
			
		} catch (SQLException e) {
			printSQLException(e);
			return "Error";
		}
	}

	private void printSQLException(SQLException ex) {
		for (Throwable e : ex) {
			if (e instanceof SQLException) {
				e.printStackTrace(System.err);
				System.err.println("SQLState: " + ((SQLException) e).getSQLState());
				System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
				System.err.println("Message: " + e.getMessage());
				Throwable t = ex.getCause();
				while (t != null) {
					System.out.println("Cause: " + t);
					t = t.getCause();
				}
			}
		}
	}

}
