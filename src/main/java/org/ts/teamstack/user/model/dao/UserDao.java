package org.ts.teamstack.user.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.user.model.dto.Users;

public interface UserDao {
    Users searchById (String userId, SqlSession session);
    int insertUser(Users user, SqlSession session);
}
