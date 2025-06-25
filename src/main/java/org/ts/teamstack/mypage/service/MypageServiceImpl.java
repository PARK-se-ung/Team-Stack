package org.ts.teamstack.mypage.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.ts.teamstack.course.model.dto.Bookmark;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.mypage.model.dao.MypageDao;

import java.util.List;

@RequiredArgsConstructor
@Service
public class MypageServiceImpl implements MypageService {

    private final MypageDao mypageDao;
    private final SqlSession session;


    @Override
    public List<Course> selectBookmarkAll(String userId) {

        return  mypageDao.selectBookmarkAll(session,userId);
    }
}
