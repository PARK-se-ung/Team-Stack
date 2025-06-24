package org.ts.teamstack.common.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Slf4j
public class FileUpload {
    public static List<String> saveFiles(MultipartFile[] files, String path) throws IOException{
        List<String> list = new ArrayList<String>();
        File dir = new File(path);
        if(!dir.exists()) {
            boolean result = dir.mkdirs();
            if(!result) log.error("file path generate fail");
        }
        for(MultipartFile f : files) {
            if(!f.isEmpty()){
                String origin = f.getOriginalFilename();
                String uuid = UUID.randomUUID().toString();
                String fileName = uuid+"_"+origin;
                File newImage = new File(path, fileName);
                f.transferTo(newImage);
                list.add(fileName);
            }
        }
        return list;
    }
}
