package org.ts.teamstack.user.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.user.model.dto.Users;

import java.util.Map;

public interface UserDao {
    Users searchById (String userId, SqlSession session);
    int insertUser(Users user, SqlSession session);
    int updateUsers(SqlSession session, Users loginUser);

    int updatePassword(SqlSession session, Map<String, Object> user);
}
