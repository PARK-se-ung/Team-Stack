package org.ts.teamstack.manager.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.ts.teamstack.common.controller.PageBarFactory;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.manager.model.dto.Notice;
import org.ts.teamstack.manager.service.ManagerService;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/manage")
@RequiredArgsConstructor
public class ManagerController {

    private final ManagerService service;
    private final PageInfo pageInfo;
    @RequestMapping("")
    public String manage(){
        return "manage/manage";
    }

    @RequestMapping("/notice")
    public String searchNotice(Model model,
                               @RequestParam(defaultValue = "1") int cPage){
        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(service.searchNoticeCount());
        List<Notice> notices = service.searchNotice(pageInfo);
        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "loadNotice");
        model.addAttribute("notices", notices);
        return "manage/notice";
    }
}
