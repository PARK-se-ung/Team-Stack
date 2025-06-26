package org.ts.teamstack.mypage.service;

import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Bookmark;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.user.model.dto.Users;

import java.util.List;

public interface MypageService {
    List<Course> selectBookmarkAll(String userId, PageInfo pageInfo);
    int searchBookmarkCount(String userId);
}
