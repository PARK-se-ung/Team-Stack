package org.ts.teamstack.classpage.model.dto;

import java.util.HashMap;
import java.util.Map;

public class StudentScore {
    private String userId;
    private String userName;  // 필요 시
    private Map<String, Integer> scores = new HashMap<>();
}
