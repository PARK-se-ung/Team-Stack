package org.ts.teamstack.common.controller;

import org.ts.teamstack.common.model.dto.PageInfo;

public class PageBarFactory {

    public static StringBuffer ajaxPageBuilder(PageInfo pageInfo, String functionName){
        int totalPage = (pageInfo.getTotalData() - 1) / pageInfo.getNumPerpage() + 1;
        int pageNo = 1, pageEnd = totalPage;
        if(pageInfo.getPageBarSize() < totalPage) {
            if(pageInfo.getPageBarSize() / 2 < pageInfo.getCurPage() && pageInfo.getCurPage() < totalPage - pageInfo.getPageBarSize() / 2) {
                pageNo = pageInfo.getCurPage() - pageInfo.getPageBarSize() / 2;
                pageEnd = pageInfo.getCurPage() + pageInfo.getPageBarSize() / 2;
            } else {
                if(pageInfo.getCurPage() <= pageInfo.getPageBarSize() / 2) pageEnd = pageInfo.getPageBarSize();
                if(pageInfo.getCurPage() >= totalPage - pageInfo.getPageBarSize() / 2) pageNo = totalPage - pageInfo.getPageBarSize() + 1;
            }
        }
        StringBuffer pageBar = new StringBuffer("<ul class='pagination justify-content-center'>");
        if(pageInfo.getCurPage() == 1) {
            pageBar.append("<li class='page-item disabled'>");
            pageBar.append("<a class='page-link' href='#');'> prev </a>");
            pageBar.append("</li>");
        } else {
            pageBar.append("<li class='page-item '>");
            pageBar.append("<a class='page-link' href='javascript:" + functionName + "(" + (pageNo > 1? pageNo - 1 : 1) + ")'> prev </a>");
            pageBar.append("</li>");
        }
        for(int i = pageNo; i <= pageEnd; i++) {
            if(i == pageInfo.getCurPage()) {
                pageBar.append("<li class='page-item disabled'>");
                pageBar.append("<a class='page-link' href='#'>"+ i + "</a>");
            } else {
                pageBar.append("<li class='page-item'>");
                pageBar.append("<a class='page-link' href='javascript:" + functionName + "(" + i + ")'> " + i + " </a>");
            }
            pageBar.append("</li>");
        }
        if(pageInfo.getCurPage() == totalPage) {
            pageBar.append("<li class='page-item disabled'>");
            pageBar.append("<a class='page-link' href='#'> next </a>");
        } else {
            pageBar.append("<li class='page-item'>");
            pageBar.append("<a class='page-link' href='javascript:" + functionName + "(" + (pageEnd < totalPage? pageEnd + 1 : totalPage) + ")'> next </a>");
        }
        pageBar.append("</li>");
        pageBar.append("</ul>");

        return pageBar;
    }

}
