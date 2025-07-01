package org.ts.teamstack.common.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;
import org.ts.teamstack.course.model.dto.Course;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Slf4j
public class FileUpload {
    public static List<String> createFiles(MultipartFile[] files, String path) throws IOException{
        List<String> list = new ArrayList<String>();
        if(createPath(path)) log.error("file path generate fail");
        for(MultipartFile file : files) {
            if(!file.isEmpty()){
                String fileName = renameFile(file);
                File newImage = new File(path, fileName);
                file.transferTo(newImage);
                list.add(fileName);
            }
        }
        return list;
    }

    public static String createFile(MultipartFile file, String path) throws IOException {
        if(createPath(path)) log.error("file path generate fail");
        if(!file.isEmpty()){
            String fileName = renameFile(file);
            File newImage = new File(path, fileName);
            file.transferTo(newImage);
            return fileName;
        }
        return null;
    }

    public static void saveFile(MultipartFile file, String path, String rename) throws IOException {
        if (!file.isEmpty()) {
            if (!createPath(path)) {
                throw new IOException("디렉토리 생성 실패: " + path);
            }
            File newImage = new File(path, rename);
            file.transferTo(newImage);
        }
    }

    private static boolean createPath(String path){
        File file = new File(path);
        if(!file.exists()){
            return file.mkdirs();
        }
        return true;
    }

    public static String renameFile(MultipartFile file){
        String origin = file.getOriginalFilename();
        String uuid = UUID.randomUUID().toString();
        return uuid+"_"+origin;
    }

}
