package org.ts.teamstack.user.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.user.model.dto.Users;

import java.util.Map;

@Repository
public class UserDaoImpl implements UserDao {
    @Override
    public Users searchById (String userId, SqlSession session)
            throws UsernameNotFoundException {
            return session.selectOne("users.searchById",userId);
    }
    @Override
    public int insertUser(Users user, SqlSession session) {
        return session.insert("users.insertUser",user);
    }

    @Override
    public int updateUsers(SqlSession session, Users loginUser) {
        return session.update("users.updateUser",loginUser);
    }

    @Override
    public int updatePassword(SqlSession session, Map<String, Object> user) {
        return session.update("users.updatePassword",user);
    }
}
