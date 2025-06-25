package org.ts.teamstack.user.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.ts.teamstack.user.model.dao.UserDaoImpl;
import org.ts.teamstack.user.model.dto.Users;

@RequiredArgsConstructor
public class LoginUserService implements UserDetailsService {
    private final UserDaoImpl dao;
    private final SqlSession session;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Users u = dao.searchById(username, session);
        /* 유저가 존재하지 않으면 예외를 무조건 던저야 한다. */
        if (u == null) {
            throw new UsernameNotFoundException("존재하지 않는 사용자입니다.");
        }
        return u;
    }
}
