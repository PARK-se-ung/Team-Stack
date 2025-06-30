package org.ts.teamstack.mypage.service;

import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Apply;
import org.ts.teamstack.course.model.dto.Bookmark;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.user.model.dto.Users;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;
import java.util.List;

public interface MypageService {
    List<Course> selectBookmarkAll(String userId, PageInfo pageInfo);
    int searchBookmarkCount(String userId);
    List<Course> selectReserveAll(String userId,PageInfo pageInfo);
    int selectReserveCount(String userId);

    int selectApplyCount( String userId);

    List<Course> selectApplyAll( String userId, PageInfo pageInfo);

    int selectTakeCount( String userId);

    List<Course> selectTakeAll( String userId, PageInfo pageInfo);

    int selectCompleteCount( String userId);

    List<Course> selectCompleteAll( String userId, PageInfo pageInfo);
}
