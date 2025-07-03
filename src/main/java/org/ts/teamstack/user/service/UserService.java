package org.ts.teamstack.user.service;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.user.model.dto.Users;

import java.util.Map;

public interface UserService {
    Users searchById(String id, String password);
    int insertUser(Users user);
    int updateUsers(Users loginUser);
    int updatePassword(Map<String, Object> user);
}
