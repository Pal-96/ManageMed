package com.app.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class JWTUtil {
    private static final String SECRET_KEY = "your_secret_key";
    private static final long EXPIRATION_TIME = 86400000; // 1 day in milliseconds

    public static String generateToken(String username) {
    	Map<String,Object> claims = new HashMap();
        return Jwts.builder()
        		.setClaims(claims)
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .compact();
    }

    public static Claims getClaims(String token) {
        return Jwts.parserBuilder()
                .build()
                .parseClaimsJwt(token)
                .getBody();
    }

//    public static boolean validateToken(String token) {
//        try {
//            Claims claims = getClaims(token);
//            return claims.getExpiration().after(new Date());
//        } catch (Exception e) {
//            return false;
//        }
//    }

    public static String getUsername(String token) {
        return getClaims(token).getSubject();
    }
}

