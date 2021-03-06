package com.board.common.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.Hashtable;
import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attributes;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.board.admin.model.AdminMaster;
import com.board.admin.service.AdminService;
import com.board.common.model.UserMaster;
import com.board.utility.DatabaseConnection;

@Service
public class LoginService {
	@Value("${login.ldap.host}")
	private String host;

	@Value("${login.ldap.dn}")
	private String dn;

	@Value("${login.ldap.domain}")
	private String domain;

	@Value("${login.sso.dbip}")
	private String dbip;

	@Value("${login.sso.dbid}")
	private String dbid;

	@Value("${login.sso.dbpw}")
	private String dbpw;

	@Value("${login.sso.dbname}")
	private String dbname;

	@Value("${login.sso.dbdriver}")
	private String dbdriver;

	public static String _UserId;
	@Resource
	UserMasterService userMasterService;
	@Resource
	CodeMasterService codeMasterService;
	@Resource
	AdminService adminService;

	static class LDAP {
		static String ATTRIBUTE_FOR_USER = "sAMAccountName";

		public Attributes authenticateUser(String username, String password, String _domain, String host, String dn) {

			String returnedAtts[] = { "sAMAccountName", "displayName", "mail" };
			String searchFilter = "(&(objectClass=user)(" + ATTRIBUTE_FOR_USER + "=" + username + "))";

			SearchControls searchCtls = new SearchControls();
			searchCtls.setReturningAttributes(returnedAtts);

			searchCtls.setSearchScope(SearchControls.SUBTREE_SCOPE);
			String searchBase = dn;
			Hashtable environment = new Hashtable();
			environment.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");

			environment.put(Context.PROVIDER_URL, "ldap://" + host + ":389");
			environment.put(Context.SECURITY_AUTHENTICATION, "simple");
			environment.put(Context.SECURITY_PRINCIPAL, username + "@" + _domain);
			environment.put(Context.SECURITY_CREDENTIALS, password);

			LdapContext ctxGC = null;
			try {
				ctxGC = new InitialLdapContext(environment, null);
				// Search for objects in the GC using the filter

				NamingEnumeration answer = ctxGC.search(searchBase, searchFilter, searchCtls);
				while (answer.hasMoreElements()) {
					SearchResult sr = (SearchResult) answer.next();
					Attributes attrs = sr.getAttributes();
					if (attrs != null) {
						return attrs;
					}
				}

			} catch (NamingException e) {

			}
			return null;
		}
	}
	public boolean SYADLoginCheck(String userId, String password) {
		LDAP ldap = new LDAP();
		Attributes att = ldap.authenticateUser(userId, password, domain, host, dn);

		return (att == null) ? false : true;
	}
	public String ssoLegasy() throws Exception {

		CallableStatement cs = null;
		ResultSet rs = null;
		Connection connection = null;

		String ticket = "";
		try {
			DatabaseConnection dc = new DatabaseConnection();
			// url ??????
			String url = dc.getMsSqlJDBCUrl(this.dbip, this.dbname);
			// mssql connection ??????
			connection = dc.makeConnection(url, this.dbid, this.dbpw, this.dbdriver);
			// ????????????
			cs = connection.prepareCall("{call up_Ticket_Select()}");
			rs = cs.executeQuery();
			while (rs.next()) {
				ticket = rs.getString("TicketID");
			}

		} catch (Exception e) {

		} finally {
			cs.close();
			connection.close();
		}

		return ticket;
	}
	public String ssoGetUserId(HttpServletRequest request) throws Exception{
		CallableStatement cs = null;
		ResultSet rs = null;
		Connection connection = null;
		HttpSession session = request.getSession(true);
		String userId = "";
		String ticket = "";
		if(session.getAttribute("ticket") != null) {
			ticket = session.getAttribute("ticket").toString();
		}
		try {
			DatabaseConnection dc = new DatabaseConnection();
			// url ??????
			String url = dc.getMsSqlJDBCUrl(this.dbip, this.dbname);
			// mssql connection ??????
			connection = dc.makeConnection(url, this.dbid, this.dbpw, this.dbdriver);

			cs = connection.prepareCall("{call up_LoginInfo_Select(?)}");
			cs.setString(1, ticket);

			for (int i = 0; i < 2; i++) { // Insert ??? ?????? ????????? ?????? 2??? ?????? (1??? ??????)
				TimeUnit.SECONDS.sleep(1);
				rs = cs.executeQuery();

				while (rs.next()) {
					userId = rs.getString("EmpCode");
				}

				if (!StringUtils.isEmpty(userId)) {
					break;
				}
			}
		} finally {
			cs.close();
			connection.close();
		}
		if(!userId.equals("")) {
			setSessionUserInfo(request, userId);
		}


		return userId;
	}
	public void setSessionUserInfo(HttpServletRequest request, String userId) throws Exception {
		HttpSession session = request.getSession(true);
		UserMaster userMaster = userMasterService.getUserInfo(userId);
		AdminMaster adminMaster = adminService.getAdminInfo(userId);
		session.setAttribute("userInfo", userMaster);
		session.setAttribute("adminInfo", adminMaster);
	}

}
