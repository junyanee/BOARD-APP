package com.board.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
		public Connection makeConnection(String url, String dbId, String dbPw, String driverNm) throws Exception {

			Connection connection = null;

			try {
				// 1. JDBC 드라이버 로드
				Class.forName(driverNm);
				// 2. Connection 인스턴스 생성
				connection = DriverManager.getConnection(url, dbId, dbPw);

			} catch (ClassNotFoundException e) {

			} catch (SQLException se) {

			}

			return connection;
		}

		public String getMsSqlJDBCUrl(String host, String dbName) throws Exception {

			StringBuilder urlBul = new StringBuilder();

			urlBul.append("jdbc:sqlserver://");
			urlBul.append(host); // 접속호스트
			urlBul.append("");
			urlBul.append(""); // 포트번호
			urlBul.append(";");
			urlBul.append("databaseName=");
			urlBul.append(dbName); // DB명
			urlBul.append(";");
			urlBul.append("selectMethod=");
			urlBul.append("cursor");
			urlBul.append(";");

			return urlBul.toString();
		}
}
