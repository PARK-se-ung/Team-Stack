package org.ts.teamstack.user.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ts.teamstack.user.model.dao.UserDao;
import org.ts.teamstack.user.model.dto.Users;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserDao dao;
    private final SqlSession session;


    public Users searchById(String userId, SqlSession session){
        Users u = dao.searchById(userId,session);
        return u;
    }

}
