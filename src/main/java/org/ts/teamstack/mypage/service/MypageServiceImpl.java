package org.ts.teamstack.mypage.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.ts.teamstack.common.controller.FileUpload;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Apply;
import org.ts.teamstack.course.model.dto.Bookmark;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.manager.model.dto.Approve;
import org.ts.teamstack.mypage.model.dao.MypageDao;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class MypageServiceImpl implements MypageService {

    private final MypageDao mypageDao;
    private final SqlSession session;


    @Override
    public List<Course> selectBookmarkAll(String userId, PageInfo pageInfo) {

        return  mypageDao.selectBookmarkAll(session,userId,pageInfo);
    }

    @Override
    public int searchBookmarkCount(String userId) {
        return mypageDao.selectBookmarkCount(session,userId);
    }

    @Override
    public List<Course> selectReserveAll(String userId,PageInfo pageInfo) {
        return mypageDao.selectReserveAll(session,userId,pageInfo);
    }

    @Override
    public int selectReserveCount(String userId) {
        return mypageDao.selectReserveCount(session,userId);
    }

    @Override
    public int selectApplyCount(String userId) {
        return mypageDao.selectApplyCount(session,userId);
    }

    @Override
    public List<Course> selectApplyAll(String userId, PageInfo pageInfo) {
        return  mypageDao.selectApplyAll(session,userId,pageInfo);
    }

    @Override
    public int selectTakeCount(String userId) {
        return mypageDao.selectTakeCount(session,userId);
    }

    @Override
    public List<Course> selectTakeAll(String userId, PageInfo pageInfo) {
        return mypageDao.selectTakeAll(session,userId,pageInfo);
    }

    @Override
    public int selectCompleteCount(String userId) {
        return mypageDao.selectCompleteCount(session,userId);
    }

    @Override
    public List<Course> selectCompleteAll(String userId, PageInfo pageInfo) {
        return mypageDao.selectCompleteAll(session,userId,pageInfo);
    }

    @Override
    @Transactional
    public int insertApprove(Approve approve, MultipartFile multipartFile,String path ) {
       int result =  mypageDao.insertApprove(session,approve);
        if(result > 0){
            try{
                FileUpload.saveFile(multipartFile,path,approve.getApproveRename());
            }catch (IOException e){
                    throw new RuntimeException("파일저장실패");
            }
        }
        return result;
    }

    @Override
    public String selectApprove(String userId) {
        return mypageDao.selectApprove(session,userId);
    }
}
