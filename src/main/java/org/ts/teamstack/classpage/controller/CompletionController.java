package org.ts.teamstack.classpage.controller;

import com.itextpdf.layout.properties.TextAlignment;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.context.WebApplicationContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletContext;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.InputStream;
import java.io.FileInputStream;
import java.io.File;

import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.classpage.model.dto.Completion;
import org.ts.teamstack.user.model.dto.Users;
import org.ts.teamstack.classpage.model.service.ClassPageService1;

import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.io.font.FontProgram;
import com.itextpdf.io.font.FontProgramFactory;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.kernel.font.PdfFontFactory.EmbeddingStrategy;

@Controller
@RequiredArgsConstructor
public class CompletionController {

    private final ClassPageService1 service;
    private final WebApplicationContext webApplicationContext;

    @GetMapping("/class/certificate")
    public void downloadCertificate(
            @RequestParam("courseNo") int courseNo,
            @SessionAttribute(name = "loginUser", required = false) Users loginUser,
            HttpServletResponse response) throws Exception {

        // 수료 정보 조회
        Course query = new Course();
        query.setUserId(loginUser.getUserId());
        query.setCourseNo(courseNo);
        Completion completion = service.checkCompletion(query);

        // 파일명 설정
        String rawFilename = completion.getCourseTitle() + " 수료증.pdf";
        String encodedFilename = URLEncoder.encode(rawFilename, StandardCharsets.UTF_8.toString())
                .replaceAll("\\+", "%20");
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFilename);

        // PDF 초기화
        PdfWriter writer = new PdfWriter(response.getOutputStream());
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf, PageSize.A4);

        // 나눔고딕 폰트 로드
        PdfFont font = loadKoreanFont();
        document.setFont(font).setFontSize(12);

        // 수료증 제목
        document.add(new Paragraph("수료증")
                .setFontSize(24)
                .setBold()
                .setTextAlignment(TextAlignment.CENTER)
                .setMarginBottom(20));

        // 강의명 및 기간
        document.add(new Paragraph("강의명: " + completion.getCourseTitle()));
        String period = new SimpleDateFormat("yyyy.MM.dd").format(completion.getStartDate())
                + " ~ "
                + new SimpleDateFormat("yyyy.MM.dd").format(completion.getEndDate());
        document.add(new Paragraph("기간: " + period).setMarginBottom(30));

        // 수료자 정보
        document.add(new Paragraph("수료자: " + loginUser.getName())
                .setTextAlignment(TextAlignment.CENTER)
                .setFontSize(16)
                .setBold()
                .setMarginBottom(30));

        // 발급 기관
        document.add(new Paragraph("TeamStack")
                .setTextAlignment(TextAlignment.CENTER)
                .setFontSize(14)
                .setMarginBottom(20));

        // 발급일
        String issued = new SimpleDateFormat("yyyy년 MM월 dd일").format(new Date());
        document.add(new Paragraph("발급일: " + issued)
                .setTextAlignment(TextAlignment.RIGHT));

        document.close();
    }


    private PdfFont loadKoreanFont() {
        try {
            ServletContext servletContext = webApplicationContext.getServletContext();
            String fontPath = servletContext.getRealPath("/resources/fonts/NanumGothic.ttf");

            if (fontPath != null && new File(fontPath).exists()) {
                try (InputStream is = new FileInputStream(fontPath)) {
                    byte[] fontBytes = is.readAllBytes();
                    FontProgram fontProgram = FontProgramFactory.createFont(fontBytes);
                    return PdfFontFactory.createFont(fontProgram, "Identity-H");
                }
            }

            try (InputStream is = getClass().getResourceAsStream("/fonts/NanumGothic.ttf")) {
                if (is != null) {
                    byte[] fontBytes = is.readAllBytes();
                    FontProgram fontProgram = FontProgramFactory.createFont(fontBytes);
                    return PdfFontFactory.createFont(fontProgram, "Identity-H");
                }
            }

            // 방법 3: 시스템 기본 폰트 사용 (fallback)
//            System.out.println("나눔고딕 폰트를 찾을 수 없어 기본 폰트를 사용합니다.");
            // 한글 지원을 위해 Identity-H 인코딩 사용
            return PdfFontFactory.createFont("Helvetica", "Identity-H", PdfFontFactory.EmbeddingStrategy.PREFER_EMBEDDED);

        } catch (Exception e) {
//            System.err.println("폰트 로드 중 오류 발생: " + e.getMessage());
            try {
                // 최후의 수단으로 기본 폰트 사용
                return PdfFontFactory.createFont("Helvetica");
            } catch (Exception ex) {
                throw new RuntimeException("폰트 로드 실패", ex);
            }
        }
    }
}