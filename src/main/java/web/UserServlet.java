package web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.UserDAO;
import model.User;

@WebServlet("/")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;
	
	public void init() {
		userDAO = new UserDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getServletPath();

		try {
			switch (action) {
				case "/createUser":
					createUser(request, response);
					break;
				case "/editUser":
					editUser(request, response);
					break;
				case "/deleteUser":
					deleteUser(request, response);
					break;
				default:
					doGet(request, response);
					break;
			}
		} catch (SQLException ex) {
			throw new ServletException(ex);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getServletPath();

		try {
			switch (action) {
				case "/getUsers":
					getUsers(request, response);
					break;
				default:
					listUserCrud(request, response);
					break;
			}
		} catch (SQLException ex) {
			throw new ServletException(ex);
		}
	}
	
	// Propios
	private void listUserCrud(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("user-crud.jsp");
		dispatcher.forward(request, response);
	}
	
	private void getUsers(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		List<User> listUser = userDAO.selectAllUsers();
		String json = new Gson().toJson(listUser);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}
	
	private void createUser(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		System.out.println(request.getParameter("age"));
		
		String name = request.getParameter("name");
		String last_name = request.getParameter("last_name");
		String email = request.getParameter("email");
		int age = Integer.parseInt(request.getParameter("age"));
		String country = request.getParameter("country");
		String city = request.getParameter("city");
		User newUser = new User(name, last_name, email, age, country, city);
		String status = userDAO.createUser(newUser);
		
		if (status.equals("OK")) {
			response.setContentType("application/text");
			response.setCharacterEncoding("UTF-8");
			response.setStatus(HttpServletResponse.SC_OK);
			response.getWriter().write("OK");
		} else {
			response.setContentType("application/text");
			response.setCharacterEncoding("UTF-8");
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("Error");
		}
	}
	
	private void editUser(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		String last_name = request.getParameter("last_name");
		String email = request.getParameter("email");
		int age = Integer.parseInt(request.getParameter("age"));
		String country = request.getParameter("country");
		String city = request.getParameter("city");

		User user = new User(id, name, last_name, email, age, country, city);
		String status = userDAO.editUser(user);
		
		if (status.equals("OK")) {
			response.setContentType("application/text");
			response.setCharacterEncoding("UTF-8");
			response.setStatus(HttpServletResponse.SC_OK);
			response.getWriter().write("OK");
		} else {
			response.setContentType("application/text");
			response.setCharacterEncoding("UTF-8");
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("Error");
		}
		
	}
	
	private void deleteUser(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String status = userDAO.deleteUser(id);
		
		if (status.equals("OK")) {
			response.setContentType("application/text");
			response.setCharacterEncoding("UTF-8");
			response.setStatus(HttpServletResponse.SC_OK);
			response.getWriter().write("OK");
		} else {
			response.setContentType("application/text");
			response.setCharacterEncoding("UTF-8");
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("Error");
		}

	}
}
