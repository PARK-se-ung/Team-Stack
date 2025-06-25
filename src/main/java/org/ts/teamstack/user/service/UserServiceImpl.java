package org.ts.teamstack.user.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.ts.teamstack.user.model.dao.UserDaoImpl;
import org.ts.teamstack.user.model.dto.Users;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    @Qualifier("userDaoImpl")
    private UserDaoImpl dao;
    @Autowired
    private SqlSession session;
    @Override
    public Users searchById(String id,String password) {
        Users u = dao.searchById(id, session);
        if(u!=null&&u.getPassword().equals(password)){
            return u;
        }
        return null;
    }
    @Override
    public int insertUser(Users user, SqlSession session) {
        return dao.insertUser(user,session);
    }
}
