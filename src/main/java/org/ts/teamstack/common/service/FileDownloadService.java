package org.ts.teamstack.common.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

@Service
@Slf4j
public class FileDownloadService {

    public void downloadPdfFile(String oriname,
                             String rename,
                             String saveDir,
                             HttpServletRequest request,
                             HttpServletResponse response) throws IOException {

        System.out.println(rename);

        System.out.println(saveDir);
        System.out.println(oriname);

        /* 파일명 검증 */
        if (!isValidFileName(rename) || !isAllowedPdfExtension(rename) || !isSafeFileName(oriname)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "허용되지 않는 파일명 또는 확장자입니다.");
            return;
        }

        /* 파일 경로 확인 */
        String path = saveDir;
        File file = new File(path, rename);
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일을 찾을 수 없습니다.");
            log.info("경로 못찾음");
            return;
        }

        /* 브라우저별 인코딩 처리 */
        String header = request.getHeader("User-Agent");
        boolean isMs = header != null && (header.contains("Trident") || header.contains("MSIE"));
        String encodedName = isMs
                ? URLEncoder.encode(oriname, "UTF-8").replaceAll("\\+", "%20")
                : new String(oriname.getBytes("UTF-8"), "ISO-8859-1");

        String encodedUtf8 = URLEncoder.encode(oriname, "UTF-8").replaceAll("\\+", "%20");

        /* 응답헤더 설정 */
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=\"" + encodedName + "\"; filename*=UTF-8''" + encodedUtf8);

        /* 파일 스트림 전송 */
        try (
                FileInputStream fis = new FileInputStream(file);
                OutputStream out = response.getOutputStream()
        ) {
            byte[] buffer = new byte[4096];
            int len;
            while ((len = fis.read(buffer)) != -1) {
                out.write(buffer, 0, len);
            }
        }
    }

    /* 파일명 유효성 검사 (디렉토리 탈출 방지) */
    public boolean isValidFileName(String fileName) {
        if (fileName == null) return false;
        if (fileName.contains("..") || fileName.contains("/") || fileName.contains("\\")) {
            return false;
        }
        String pattern = "^[\\w\\u3131-\\u318E\\uAC00-\\uD7A3\\u1100-\\u11FF\\u1160-\\u11A7\\-_. ]+$";
        return fileName.matches(pattern);
    }

    /* 확장자 화이트 리스트 pdf */
    public boolean isAllowedPdfExtension(String fileName) {
        if (fileName == null) return false;
        return fileName.toLowerCase().endsWith(".pdf");
    }

    /* XSS 위험 문자 필터링 */
    public boolean isSafeFileName(String name) {
        if (name == null) return false;
        return !name.contains("<") && !name.contains(">") && !name.contains("\"") && !name.contains("'");
    }

}
