package org.ts.teamstack.user.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.ts.teamstack.user.model.dao.UserDao;
import org.ts.teamstack.user.model.dto.User;

@RequiredArgsConstructor
@Service

public class UserService implements UserDetailsService {
    @Autowired
    private final UserDao dao;
    @Autowired
    private final SqlSession session;

    @Override
    public UserDetails loadUserByUsername(String userId)
            throws UsernameNotFoundException {
       User u = dao.searchById(userId,session);
       if (u == null) {throw new UsernameNotFoundException("해당하는 회원이 존재하지 않습니다.");}
        return u;
    }
}
