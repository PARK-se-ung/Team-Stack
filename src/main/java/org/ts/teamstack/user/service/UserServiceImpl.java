package org.ts.teamstack.user.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.ts.teamstack.user.model.dao.UserDaoImpl;
import org.ts.teamstack.user.model.dto.Users;

import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    @Qualifier("userDaoImpl")
    private UserDaoImpl dao;
    @Autowired
    private SqlSession session;
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Override
    public Users searchById(String id,String password) {
        Users u = dao.searchById(id, session);
        if(u!=null&&u.getPassword().equals(password)){
            return u;
        }
        return null;
    }
    @Override
    public int insertUser(Users user) {
        String pwd = passwordEncoder.encode(user.getPassword());
        user.setUserPwd(pwd);
        return dao.insertUser(user,session);
    }
    @Override
    public int updateUsers(Users loginUser) {
        return dao.updateUsers(session,loginUser);
    }

    @Override
    public int updatePassword(Map<String, Object> user) {
        String pwd = passwordEncoder.encode(user.get("password").toString());
        user.put("password",pwd);
        return dao.updatePassword(session,user);
    }
}
