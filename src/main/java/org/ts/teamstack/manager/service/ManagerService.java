package org.ts.teamstack.manager.service;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.manager.model.dto.Notice;

import java.util.List;

public interface ManagerService {
    List<Notice> searchNotice(PageInfo pageInfo);
    int searchNoticeCount();
}
