package com.app.security;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
	
	public static String hashPwd(String password) {
		String salt = BCrypt.gensalt(12);
		return BCrypt.hashpw(password, salt);
		
	}
	
	public static boolean verifyPassword(String loginPwd, String storedPwd) {
        return BCrypt.checkpw(loginPwd, storedPwd);
    }

}
