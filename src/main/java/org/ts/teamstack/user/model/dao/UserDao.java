package org.ts.teamstack.user.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.user.model.dto.User;

@Repository
public class UserDao {

    public User searchById (String userId, SqlSession session)
            throws UsernameNotFoundException {
            return session.selectOne("users.searchById",userId);
    }
}
