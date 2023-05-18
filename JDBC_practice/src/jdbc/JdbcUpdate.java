package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class JdbcUpdate {

	public static void main(String[] args) {

		//ID를 입력받기
		//수정할 이름과 이메일도 입력받기
		//지목한 ID의 이름과 나이를 새로운 값으로 수정하기
		//(ID는 존재하는 ID를 넣어줘야 수정이 가능하다)


		Scanner sc = new Scanner(System.in);

		System.out.println("ID를 입력하세요");
		System.out.print("> ");
		String id = sc.next();

		System.out.println("수정할 이름을 입력하세요");
		System.out.print("> ");
		String name = sc.next();

		System.out.println("수정할 나이를 입력하세요");
		System.out.print("> ");
		int age = sc.nextInt();


		String sql = "UPDATE members "
				+ "SET mem_name = ?, mem_age = ? "
                + "WHERE mem_id = ?";


		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String uid = "hr";
		String upw = "hr";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName("oracle.jdbc.driver.OracleDriver");

			conn = DriverManager.getConnection(url, uid, upw);
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, name);
			pstmt.setInt(2, age);
			pstmt.setString(3, id);


			int rn = pstmt.executeUpdate();

			if(rn == 1) {
				System.out.println("DB에 회원정보 수정 성공");
			} else {
				System.out.println("DB에 회원정보 수정 실패");
			}


		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}

		try {
			pstmt.close();
			conn.close();
			sc.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}


	}

}
